clear all
close all

%Reads files produced by read_field.m and bd_locator.m

% files.bdfile_dir = '.\XBox2_PSI1\';
% files.bdfile_prefix = 'BD_location_';
% files.bdfile_suffix = '.txt';
% 
% files.fldfile_dir = '.\XBox2_PSI1\';
% files.fldfile_prefix = 'field_';
% files.fldfile_suffix = '.txt';
% 
% files.start_year = 2017;
% files.start_month = 10;
% files.start_day = 5;
% 
% files.end_year = 2018;
% files.end_month = 3;
% files.end_day = 19;
% 
% name = 'T24 PSI 1';
% start_1 = 1.5e8;
% end_1 = 2e8;
% start_2 = 3.5e8;
% end_2 = 4e8;

files.bdfile_dir = '.\XBox2_PSI2\';
files.bdfile_prefix = 'BD_location_';
files.bdfile_suffix = '.txt';

files.fldfile_dir = '.\XBox2_PSI2\';
files.fldfile_prefix = 'field_';
files.fldfile_suffix = '.txt';

files.start_year = 2018;
files.start_month = 3;
files.start_day = 26;

files.end_year = 2018;
files.end_month = 8;
files.end_day = 31;

name = 'T24 PSI 2';
start_1 = 0.5e8;
end_1 = 1e8;
start_2 = 3.5e8;
end_2 = 4e8;

% files.bdfile_dir = '.\XBox2_TD26CC\';
% files.bdfile_prefix = 'BD_location_';
% files.bdfile_suffix = '.txt';
% 
% files.fldfile_dir = '.\XBox2_TD26CC\';
% files.fldfile_prefix = 'field_';
% files.fldfile_suffix = '.txt';
% 
% files.start_year = 2017;
% files.start_month = 2;
% files.start_day = 1;
% 
% files.end_year = 2017;
% files.end_month = 9;
% files.end_day = 31;
% 
% name = 'TD26CCN3';
% start_1 = 4.5e8;
% end_1 = 5e8;
% start_2 = 7.5e8;
% end_2 = 8e8;

% struct_impedance = 1e8^2 / 38.5e6;
% filter_length = 11;

start_date = datenum(files.start_year, files.start_month, files.start_day);
end_date = datenum(files.end_year, files.end_month, files.end_day);

bd_pulse_count_v = [];
fld_pulse_count_v = [];
peak_power_v = [];
flat_top_power_v = [];
pulse_length_v = [];

if(start_date > end_date)
    disp('Start date cannot be before end date!');
else
    for curr_date = start_date:end_date
        curr_datetime = datetime(curr_date,'ConvertFrom','datenum');
        curr_year = curr_datetime.Year;
        curr_month = curr_datetime.Month;
        curr_day = curr_datetime.Day;
        
        bd_filename = [files.bdfile_dir, files.bdfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
            num2str(curr_day, '%02d'), files.bdfile_suffix];
        
        fld_filename = [files.fldfile_dir, files.fldfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
            num2str(curr_day, '%02d'), files.fldfile_suffix];
        
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
        
        %         %Load field file
        %         if(exist(fld_filename, 'file') ~= 2)
        %             disp(['File '  fld_filename ' is missing.']);
        %         else
        %             try
        %                 curr_data = dlmread(fld_filename, ',', 1, 0);
        %
        %                 fld_pulse_count_v = [fld_pulse_count_v; curr_data(:, 1)];
        %                 peak_power_v = [peak_power_v; curr_data(:, 3)];
        %                 flat_top_power_v = [flat_top_power_v; curr_data(:, 4)];
        %                 pulse_length_v = [pulse_length_v; curr_data(:, 5)];
        %             catch
        %                 disp(['Error reading '  fld_filename '. Ignoring file.']);
        %             end
        %         end
    end
    
    
    %Reset BD pulse count to start from 1
    bd_pulse_count_v = bd_pulse_count_v - bd_pulse_count_v(1) + 1;
    bd_count_v = 1:length(bd_pulse_count_v);
    
    %Reset field pulse count to start from 1
    %     fld_pulse_count_v = fld_pulse_count_v - fld_pulse_count_v(1) + 1;
    
    %Create cumulative BD curve:
    figure;
    plot(bd_pulse_count_v / 1e6, bd_count_v, 'Linewidth', 2);
    xlabel('Pulse count (million)');
    ylabel('Cumulative BDs');
    set(gca, 'fontsize', 20);
    
    %Get BDR vs pulse:
    pulses_to_bd_v = diff(bd_pulse_count_v);
    
    figure;
    semilogy(bd_pulse_count_v(2:end) / 1e6, 1 ./ pulses_to_bd_v, 'Linewidth', 2);
    xlabel('Pulse count (million)');
    ylabel('Instantaneous BDR');
    set(gca, 'fontsize', 20);
    
    
    
    %     ptbdu = unique(pulses_to_bd_v);
    %     occurences = zeros(1, length(ptbdu));
    %     for i = 1:length(ptbdu)
    %         occurences(i) = nnz(abs(pulses_to_bd_v - ptbdu(i)) / ptbdu(i) <= 0.02);
    %     end
    %
    %     figure;
    %     loglog(ptbdu, occurences, '.');
    
    
    %filtered BDR:
    fast_gauss_std_dev = 1e5;
    slow_gauss_std_dev = 1e6;
    small_window_size = 1e5;
    large_window_size = 1e6;
    N_samples = 1e5;
    
    sample_pos_v = linspace(1, bd_pulse_count_v(end), N_samples);
    
    % % Demo of different filtering methods
    %     fast_gauss_filt_bdr = zeros(size(sample_pos_v));
    %     slow_gauss_filt_bdr = zeros(size(sample_pos_v));
    %     small_window_bdr = zeros(size(sample_pos_v));
    %     large_window_bdr = zeros(size(sample_pos_v));
    %
    %     for i = 1:N_samples
    %         small_window_bdr(i) = bd_filter(bd_pulse_count_v, sample_pos_v(i), small_window_size, 2e7, 'moving_avg');
    %         large_window_bdr(i) = bd_filter(bd_pulse_count_v, sample_pos_v(i), large_window_size, 2e7, 'moving_avg');
    %         fast_gauss_filt_bdr(i) = bd_filter(bd_pulse_count_v, sample_pos_v(i), fast_gauss_std_dev, 2e7, 'gaussian');
    %         slow_gauss_filt_bdr(i) = bd_filter(bd_pulse_count_v, sample_pos_v(i), slow_gauss_std_dev, 2e7, 'gaussian');
    %     end
    %
    %     figure;
    %     semilogy(sample_pos_v / 1e6, small_window_bdr, 'Linewidth', 2);
    %     hold on;
    %     semilogy(sample_pos_v / 1e6, large_window_bdr, 'Linewidth', 2);
    %     semilogy(sample_pos_v / 1e6, fast_gauss_filt_bdr, 'Linewidth', 2);
    %     semilogy(sample_pos_v / 1e6, slow_gauss_filt_bdr, 'Linewidth', 2);
    %     xlabel('Pulse count (million)');
    %     ylabel('Filtered BDR');
    %     legend('Moving average, 50k pulses', 'Moving average, 500k pulses', ...
    %         'Gaussian, \sigma = 50k pulses', 'Gaussian, \sigma = 500k pulses');
    %     set(gca, 'fontsize', 20);
    
    
    %     %Generate random sequence of BDs for comparison
    %     poisson_3e6_pulse_count_v = [];
    %     poisson_1e5_pulse_count_v = [];
    %     poisson_3e5_pulse_count_v = [];
    %     for i = 1:bd_pulse_count_v(end)
    %         if(rand() <= 3e-6)
    %             poisson_3e6_pulse_count_v = [poisson_3e6_pulse_count_v i];
    %         end
    %
    %         if(rand() <= 1e-5)
    %             poisson_1e5_pulse_count_v = [poisson_1e5_pulse_count_v i];
    %         end
    %
    %         if(rand() <= 3e-5)
    %             poisson_3e5_pulse_count_v = [poisson_3e5_pulse_count_v i];
    %         end
    %     end
    
    %     %Walter model for BD clustering:
    %     bdr_primary = 3e-6;
    %     bdr_secondary = 1e-3;
    %     cluster_duration = 2e3;
    %
    %     cluster_pulse_count_v = [];
    %     cluster_countdown = 0;
    %
    %     for i = 1:bd_pulse_count_v(end)
    %         if(cluster_countdown > 0)
    %             if(rand() <= bdr_secondary)
    %                 cluster_pulse_count_v = [cluster_pulse_count_v i];
    %                 cluster_countdown = cluster_duration;
    %             else
    %                 cluster_countdown = cluster_countdown - 1;
    %             end
    %         else
    %             if(rand() <= bdr_primary)
    %                 cluster_pulse_count_v = [cluster_pulse_count_v i];
    %                 cluster_countdown = cluster_duration;
    %             else
    %                 cluster_countdown = max(cluster_countdown - 1, 0);
    %             end
    %         end
    %     end
    
    
    fast_gauss_filt_bdr = zeros(size(sample_pos_v));
    slow_gauss_filt_bdr = zeros(size(sample_pos_v));
    %     poisson_3e5_filt_bdr = zeros(size(sample_pos_v));
    %     poisson_1e5_filt_bdr = zeros(size(sample_pos_v));
    %     poisson_3e6_filt_bdr = zeros(size(sample_pos_v));
    %     cluster_filt_bdr = zeros(size(sample_pos_v));
    
    
    for i = 1:N_samples
        fast_gauss_filt_bdr(i) = bd_filter(bd_pulse_count_v, ...
            sample_pos_v(i), fast_gauss_std_dev, 2e7, 'gaussian');
        slow_gauss_filt_bdr(i) = bd_filter(bd_pulse_count_v, ...
            sample_pos_v(i), slow_gauss_std_dev, 2e7, 'gaussian');
        %         poisson_3e5_filt_bdr(i) = bd_filter(poisson_3e5_pulse_count_v, ...
        %             sample_pos_v(i), fast_gauss_std_dev, 2e7, 'gaussian');
        %         poisson_1e5_filt_bdr(i) = bd_filter(poisson_1e5_pulse_count_v, ...
        %             sample_pos_v(i), fast_gauss_std_dev, 2e7, 'gaussian');
        %         poisson_3e6_filt_bdr(i) = bd_filter(poisson_3e6_pulse_count_v, ...
        %             sample_pos_v(i), fast_gauss_std_dev, 2e7, 'gaussian');
        %         cluster_filt_bdr(i) = bd_filter(cluster_pulse_count_v, ...
        %             sample_pos_v(i), fast_gauss_std_dev, 2e7, 'gaussian');
    end
    
    figure;
    semilogy(sample_pos_v / 1e6, fast_gauss_filt_bdr, 'Linewidth', 2);
    hold on;
    semilogy(sample_pos_v / 1e6, slow_gauss_filt_bdr, 'Linewidth', 2);
    xlabel('Pulse count (million)');
    ylabel('Filtered BDR');
    legend('Gaussian, \sigma = 50k pulses', 'Gaussian, \sigma = 500k pulses');
    set(gca, 'fontsize', 20);
    
    %BDR histogram:
    start_index_1 = find(sample_pos_v >= start_1, 1, 'first');
    end_index_1 = find(sample_pos_v >= end_1, 1, 'first');
    
    start_index_2 = find(sample_pos_v >= start_2, 1, 'first');
    end_index_2 = find(sample_pos_v >= end_2, 1, 'first');
    
    log_bdr_hist = log10(fast_gauss_filt_bdr);
    log_bdr_hist = log_bdr_hist(log_bdr_hist >= -7);
    
    log_bdr_1 = log10(fast_gauss_filt_bdr(start_index_1:end_index_1));
    log_bdr_1 = log_bdr_1(log_bdr_1 >= -7);
    
    log_bdr_2 = log10(fast_gauss_filt_bdr(start_index_2:end_index_2));
    log_bdr_2 = log_bdr_2(log_bdr_2 >= -7);
    
    figure;
    histogram(log_bdr_hist, 30, 'Normalization', 'pdf', 'DisplayStyle', 'stairs', 'LineWidth', 2);
    hold on;
    histogram(log_bdr_1, 30, 'Normalization', 'pdf', 'DisplayStyle', 'stairs', 'LineWidth', 2);
    histogram(log_bdr_2, 30, 'Normalization', 'pdf', 'DisplayStyle', 'stairs', 'LineWidth', 2);
    xlim([-7 -3]);
    ylim([1e-4 1]);
    set(gca,'YScale','log');
    set(gca, 'fontsize', 20);
    xlabel('log_{10}(BDR)');
    ylabel('Probability density');
    title(name);
    legend('Full history', [num2str(start_1/1e6, '%i') 'M to ' num2str(num2str(end_1/1e6, '%i')) 'M pulses'],...
        [num2str(start_2/1e6, '%i') 'M to ' num2str(num2str(end_2/1e6, '%i')) 'M pulses']);
    
    %     log_bdr_3e5 = log10(poisson_3e5_filt_bdr);
    %     log_bdr_3e5 = log_bdr_3e5(log_bdr_3e5 >= -7);
    %
    %     log_bdr_1e5 = log10(poisson_1e5_filt_bdr);
    %     log_bdr_1e5 = log_bdr_1e5(log_bdr_1e5 >= -7);
    %
    %     log_bdr_3e6 = log10(poisson_3e6_filt_bdr);
    %     log_bdr_3e6 = log_bdr_3e6(log_bdr_3e6 >= -7);
    %
    %     log_bdr_cluster = log10(cluster_filt_bdr);
    %     log_bdr_cluster = log_bdr_cluster(log_bdr_cluster >= -7);
    
    %     figure;
    %     histogram(log_bdr_3e5, 30, 'Normalization', 'pdf');
    %     hold on
    %     histogram(log_bdr_1e5, 30, 'Normalization', 'pdf');
    %     histogram(log_bdr_3e6, 30, 'Normalization', 'pdf');
    %     xlim([-7 -3]);
    %     ylim([1e-4 5]);
    %     set(gca,'YScale','log');
    %     set(gca, 'fontsize', 20);
    %     xlabel('log_{10}(BDR)');
    %     ylabel('Probability density');
    %     legend('3E-5', '1E-5', '3E-6');
    
    
    %     figure;
    %     histogram(log_bdr_1, 30, 'Normalization', 'probability');
    %     hold on;
    %     histogram(log_bdr_cluster, 30, 'Normalization', 'probability');
    %     xlim([-7 -3]);
    %     ylim([1e-4 1]);
    %     set(gca,'YScale','log');
    %     set(gca, 'fontsize', 20);
    %     xlabel('log_{10}(BDR)');
    %     ylabel('Probability density');
    %     legend('Full history', 'Clustering model');
    
    
    
    %     peak_gradient_smoothed = medfilt1(real((peak_power_v .* struct_impedance).^0.5), filter_length);
    %     pulse_length_smoothed = medfilt1(pulse_length_v, filter_length);
    %
    %
    %     figure;
    %     plot(fld_pulse_count_v / 1e6, peak_gradient_smoothed / 1e6, '.');
    %     xlabel('Pulse count (million)');
    %     ylabel('Peak gradient (MV/m)');
    %     set(gca, 'fontsize', 20);
    %
    %     figure;
    %     plot(fld_pulse_count_v / 1e6, pulse_length_smoothed * 1e9, '.');
    %     xlabel('Pulse count (million)');
    %     ylabel('Pulse length (ns)');
    %     set(gca, 'fontsize', 20);
end