function bd_plotter(files, parameters, options, gui_handle, bd_plotter_settings)

start_date = datenum(files.start_year, files.start_month, files.start_day);
end_date = datenum(files.end_year, files.end_month, files.end_day);

pulse_count_v = [];
pulse_count_cum_v = [];
timestamp_v = [];
edge_time_v = [];
phase_v = [];
refl_time_v = [];
trans_time_v = [];

if(start_date > end_date)
    add_to_log('Start date cannot be before end date!', files, options, gui_handle);
else
    for curr_date = start_date:end_date
        curr_datetime = datetime(curr_date,'ConvertFrom','datenum');
        curr_year = curr_datetime.Year;
        curr_month = curr_datetime.Month;
        curr_day = curr_datetime.Day;
        
        bd_filename = [files.bdfile_dir, files.bdfile_prefix, num2str(curr_year), num2str(curr_month, '%02d'),...
            num2str(curr_day, '%02d'), files.bdfile_suffix];
        
        if(exist(bd_filename, 'file') ~= 2)
            add_to_log(['File '  bd_filename ' is missing.'], files, options, gui_handle);
        else
            try
                curr_data = dlmread(bd_filename, ',', 1, 1);
                
                pulse_count_v = [pulse_count_v; curr_data(:, 1)];
                timestamp_v = [timestamp_v; curr_data(:, 2)];
                edge_time_v = [edge_time_v; curr_data(:, 3)];
                phase_v = [phase_v; curr_data(:, 4)];
                refl_time_v = [refl_time_v; curr_data(:, 5)];
                trans_time_v = [trans_time_v; curr_data(:, 6)];
            catch
                add_to_log(['Error reading '  bd_filename '. Ignoring file.'], files, options, gui_handle);
            end
        end
    end
    
    if(~isequal(pulse_count_v, []))
        %Convert pulse delta to pulse count.
        if(parameters.xbox1)
            for i = 1:length(pulse_count_v)
                pulse_count_cum_v(i) = sum(pulse_count_v(1:i));
            end
            pulse_count_v = pulse_count_cum_v';
        end
        
        initial_pulse_count = pulse_count_v(1);
        num_pulses = max(pulse_count_v) - initial_pulse_count;
        
        %Find previous figures if they exist and close them
        close(findobj('Name', 'Results 1'));
        close(findobj('Name', 'Results 2'));
        close(findobj('Name', 'Results 3'));
        close(findobj('Name', 'Results 4'));
        close(findobj('Name', 'Results 5'));
        close(findobj('Name', 'Results 6'));
        close(findobj('Name', 'Results 7'));
        
        h = figure;
        set(h, 'Name', 'Results 1');
        time_bin_edges = -5:2:70;
        histogram(edge_time_v * 1e9, time_bin_edges);
        xlim(bd_plotter_settings.structure_time_limits * 1e9);
        xlabel('1/2 \times (\tau_{REF} - \tau_{TRA}) (ns)');
        ylabel('Accumulated breakdowns');
        set(gca, 'fontsize', 20);
        
        h = figure;
        set(h, 'Name', 'Results 2');
        histogram(phase_v * 180/pi, 20);
        xlabel('\phi_{refl, final} - \phi_{inc, final} (deg)');
        ylabel('Accumulated breakdowns');
        set(gca, 'fontsize', 20);
        
        if(~parameters.xbox1)
            h = figure;
            set(h, 'Name', 'Results 3');
            hold on;
            plot(phase_v * 180/pi, edge_time_v * 1e9, 'b.');
            xlim([0 360]);
            ylim(bd_plotter_settings.structure_time_limits * 1e9);
            xlabel('\phi_{refl} - \phi_{inc} (deg)');
            ylabel('Position (ns)');
            set(gca, 'fontsize', 20);
        end
        
        h = figure;
        set(h, 'Name', 'Results 4');
        hold on;
        plot(refl_time_v * 1e9, edge_time_v * 1e9, 'b.');
        plot(trans_time_v * 1e9, edge_time_v * 1e9, 'r.');
        legend('Reflected', 'Transmitted');
        xlim([0 360]);
        ylim(bd_plotter_settings.structure_time_limits * 1e9);
        xlabel('Breakdown time (ns)');
        ylabel('1/2 \times (\tau_{ref} - \tau_{tra}) (ns)');
        set(gca, 'fontsize', 20);
        
        
        %Cull events outside structure boundaries for 3D plot:
        pulse_count_culled_v = [];
        edge_time_culled_v = [];
        phase_culled_v = [];
        
        for i = 1:length(pulse_count_v)
            if((edge_time_v(i) >= min(bd_plotter_settings.structure_time_limits)) && ...
                    (edge_time_v(i) <= max(bd_plotter_settings.structure_time_limits)))
                edge_time_culled_v = [edge_time_culled_v; edge_time_v(i)];
                pulse_count_culled_v = [pulse_count_culled_v; pulse_count_v(i)];
                phase_culled_v = [phase_culled_v; phase_v(i)];
            end
        end
        
        %Edge method positioning history
        %Fix this to avoid plotting white areas if no BDs occur in he end
        %of the structure (histogram autoscaling)
        
        
        pulses_bins = round(num_pulses / bd_plotter_settings.pulses_per_bin);
        s_bins = round((max(bd_plotter_settings.structure_time_limits) - ...
            min(bd_plotter_settings.structure_time_limits)) / bd_plotter_settings.s_per_bin);
        
        [counts, bin_centres] = hist3([edge_time_culled_v * 1e9, pulse_count_culled_v - initial_pulse_count],...
            [s_bins pulses_bins]);
        [X, Y] = meshgrid(bin_centres{1}, bin_centres{2});
        
        h = figure;
        set(h, 'Name', 'Results 5');
        [~, h] = contourf(X, Y / 1e6, counts' / (bd_plotter_settings.pulses_per_bin * ...
            bd_plotter_settings.s_per_bin * 1e9), 256);
        h.LineStyle = 'none';
        colormap jet;
        caxis(bd_plotter_settings.position_caxis_limits);
        xlim(bd_plotter_settings.structure_time_limits * 1e9);
        h_cb = colorbar;
        h_cb.Label.String = 'BDR / ns';
        xlabel('Position (ns)');
        ylabel('Pulses (million)');
        title('BD distribution');
        set(gca, 'fontsize', 20);
        
        %Phase history
        if(~parameters.xbox1)
            degrees_bins = round(360 / bd_plotter_settings.degrees_per_bin);
            
            [counts, bin_centres] = hist3([phase_culled_v * 180/pi, pulse_count_culled_v - initial_pulse_count],...
                [degrees_bins pulses_bins]);
            [X, Y] = meshgrid(bin_centres{1}, bin_centres{2});
            
            h = figure;
            set(h, 'Name', 'Results 6');
            [~, h] = contourf(X, Y / 1e6, counts' / (bd_plotter_settings.pulses_per_bin *...
                bd_plotter_settings.degrees_per_bin), 256);
            h.LineStyle = 'none';
            colormap jet;
            caxis(bd_plotter_settings.phase_caxis_limits);
            h_cb = colorbar;
            h_cb.Label.String = 'BDR / deg';
            xlabel('\phi_{refl} - \phi_{inc} (deg)');
            ylabel('Pulses (million)');
            title('BD distribution');
            set(gca, 'fontsize', 20);
        end
        
        %Breakdown time
        s_bins = round(500e-9 / bd_plotter_settings.s_per_bin);
        [counts, bin_centres] = hist3([trans_time_v * 1e9, pulse_count_v - initial_pulse_count], [s_bins pulses_bins]);
        [X, Y] = meshgrid(bin_centres{1}, bin_centres{2});
        
        h = figure;
        set(h, 'Name', 'Results 7');
        [~, h] = contourf(X, Y / 1e6, counts' / (bd_plotter_settings.pulses_per_bin *...
            bd_plotter_settings.s_per_bin * 1e9), 256);
        h.LineStyle = 'none';
        colormap jet;
        xlim(bd_plotter_settings.bd_time_limits * 1e9);
        caxis(bd_plotter_settings.time_caxis_limits);
        h_cb = colorbar;
        h_cb.Label.String = 'BDR / ns';
        xlabel('BD time (ns)');
        ylabel('Pulses (million)');
        title('BD distribution');
        set(gca, 'fontsize', 20);
    else
        add_to_log('No data to plot!', files, options, gui_handle);
    end
end
end