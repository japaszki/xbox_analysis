clear all
close all

%Reads files produced by bd_locator.m

files{1}.bdfile_dir = '.\XBox2_PSI1\';
files{1}.bdfile_prefix = 'BD_location_';
files{1}.bdfile_suffix = '.txt';

files{1}.start_year = 2017;
files{1}.start_month = 10;
files{1}.start_day = 5;

files{1}.end_year = 2018;
files{1}.end_month = 3;
files{1}.end_day = 19;

files{1}.window_values{1} = [0 1e10];
files{1}.window_values{2} = [1.5e8 2e8];
files{1}.window_values{3} = [3.5e8 4e8];

files{1}.window_name{1} = 'Full history';
files{1}.window_name{2} = '150M to 200M pulses';
files{1}.window_name{3} = '350M to 400M pulses';

files{1}.name = 'T24 PSI 1';

files{2}.bdfile_dir = '.\XBox2_PSI2\';
files{2}.bdfile_prefix = 'BD_location_';
files{2}.bdfile_suffix = '.txt';

files{2}.start_year = 2018;
files{2}.start_month = 3;
files{2}.start_day = 26;

files{2}.end_year = 2018;
files{2}.end_month = 9;
files{2}.end_day = 25;

files{2}.window_values{1} = [0 1e10];
files{2}.window_values{2} = [0.5e8 1e8];
files{2}.window_values{3} = [1e8 1.5e8];

files{2}.window_name{1} = 'Full history';
files{2}.window_name{2} = '50M to 100M pulses';
files{2}.window_name{3} = '100M to 150M pulses';

files{2}.name = 'T24 PSI 2';


structure_indices = 1:2;
window_indices = 1:3;


for structure = structure_indices
    start_date = datenum(files{structure}.start_year, files{structure}.start_month, files{structure}.start_day);
    end_date = datenum(files{structure}.end_year, files{structure}.end_month, files{structure}.end_day);
    
    bd_pulse_count_v = [];
    
    if(start_date > end_date)
        disp('Start date cannot be before end date!');
    else
        for curr_date = start_date:end_date
            curr_datetime = datetime(curr_date,'ConvertFrom','datenum');
            curr_year = curr_datetime.Year;
            curr_month = curr_datetime.Month;
            curr_day = curr_datetime.Day;
            
            bd_filename = [files{structure}.bdfile_dir, files{structure}.bdfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
                num2str(curr_day, '%02d'), files{structure}.bdfile_suffix];
            
            
            %Load BD file
            if(exist(bd_filename, 'file') ~= 2)
                disp(['File '  bd_filename ' is missing.']);
            else
                try
                    curr_data = dlmread(bd_filename, ',', 1, 1);
                    bd_pulse_count_v = [bd_pulse_count_v; curr_data(:, 1)];
                catch
                    disp(['Error reading '  bd_filename '. Ignoring file.']);
                end
            end
        end
        
        %Reset BD pulse count to start from 1
        bd_pulse_count_v = bd_pulse_count_v - bd_pulse_count_v(1) + 1;
        
        for i = window_indices
            bd_pulse_count_window_c{i} = bd_pulse_count_v((bd_pulse_count_v >= files{structure}.window_values{i}(1))&...
                (bd_pulse_count_v < files{structure}.window_values{i}(2)));
        end
        
        
        %PDF fit (histogram):
        pulses_to_bd_v = diff(bd_pulse_count_v);
        pulses_to_bd_trunc_v = pulses_to_bd_v(pulses_to_bd_v >= 0);
        
        [hist_bin_centres, hist_pdf_values] = bd_binning(pulses_to_bd_trunc_v, 100);
        
        hist_values_c{structure} = hist_pdf_values;
        hist_bin_centres_c{structure} = hist_bin_centres;
        
        %Fit a power-law curve:
        plaw_fit_indices = find(hist_bin_centres > 100); %remove small time to BD to ignore ramp
        plaw_fit_c{structure} = fit(log10(hist_bin_centres_c{structure}(plaw_fit_indices)'), ...
            log10(hist_values_c{structure}(plaw_fit_indices)'), 'poly1');
        
        %Fit a double exponential:
        exp_fit_indices = find((hist_bin_centres > 100) & (hist_bin_centres < 2e4));
        dexp_fit_c{structure} = fit(hist_bin_centres_c{structure}(exp_fit_indices)', ...
            hist_values_c{structure}(exp_fit_indices)', 'exp2');
        
        %Windowed PDF fit:
        for i = 1:3
            pulses_to_bd_v = diff(bd_pulse_count_window_c{i});
            pulses_to_bd_trunc_v = pulses_to_bd_v(pulses_to_bd_v >= 0);
            
            [hist_bin_centres, hist_pdf_values] = bd_binning(pulses_to_bd_trunc_v, 30);
            
            hist_values_window_c{structure}{i} = hist_pdf_values;
            hist_bin_centres_window_c{structure}{i} = hist_bin_centres;
            
            %Define range to fit over:
            plaw_fit_indices = find(hist_bin_centres > 100); %remove small time to BD to ignore ramp
            
            %Fit a power-law curve:
            plaw_fit_window_c{structure}{i} = fit(log10(hist_bin_centres_window_c{structure}{i}(plaw_fit_indices)'), ...
                log10(hist_values_window_c{structure}{i}(plaw_fit_indices)'), 'poly1');
        end
    end
end

%Full PDFs
for structure = structure_indices
    gradient = plaw_fit_c{structure}.p1;
    conf_interval = confint(plaw_fit_c{structure}, 0.6827); %1 sigma error
    error = 0.5 * (max(conf_interval(:,1)) - min(conf_interval(:,1)));
    
    %log-log (power law)
    figure;
    plot(log10(hist_bin_centres_c{structure}), log10(hist_values_c{structure}), '.', 'MarkerSize', 8);
    hold on;
    plot(plaw_fit_c{structure});
    set(gca, 'fontsize', 20);
    xlabel('log_{10}(Pulses between BDs)');
    ylabel('log_{10}(Probability density)');
    legend(['Full history, slope = ' num2str(gradient, '%.2f') ' \pm ' num2str(error, '%.2f')]);
    title(files{structure}.name);
end


%Windowed PDFs
for structure = structure_indices
    legend_entries = {''};
    
    figure;
    hold on;
    for i = 1:3
        h1(i) = plot(log10(hist_bin_centres_window_c{structure}{i}), ...
            log10(hist_values_window_c{structure}{i}), '.', 'MarkerSize', 10);
        h2(i) = plot(plaw_fit_window_c{structure}{i});
        set(h2(i), 'Color', get(h1(i), 'Color'));
        
        gradient = plaw_fit_window_c{structure}{i}.p1;
        conf_interval = confint(plaw_fit_window_c{structure}{i}, 0.6827); %1 sigma error
        error = 0.5 * (max(conf_interval(:,1)) - min(conf_interval(:,1)));
        legend_entries{i} = [files{structure}.window_name{i} ', slope = ' num2str(gradient, '%.2f') ' \pm ' num2str(error, '%.2f')];
    end
    set(gca, 'fontsize', 20);
    title(files{structure}.name);
    legend(legend_entries);
    xlim([0 6]);
    ylim([-8 0]);
    xlabel('log_{10}(Pulses between BDs)');
    ylabel('log_{10}(Probability density)');
    
    %Fake legend:
    h0 = zeros(3, 1);
    h0(1) = plot(NaN,NaN, '.', 'MarkerSize', 12);
    h0(2) = plot(NaN,NaN, '.', 'MarkerSize', 12);
    h0(3) = plot(NaN,NaN, '.', 'MarkerSize', 12);
    
    for i = 1:3
        set(h0(i), 'Color', get(h1(i), 'Color'));
    end
    
    legend(h0, legend_entries);
end