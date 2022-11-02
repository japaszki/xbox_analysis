function generate_debug_plots(parameters, field_names, tdms_struct, BD_list, BD_index, ...
    psi_edges, psi_signals, pei_edges, pei_signals, psr_edges, psr_signals, phase_diff)

prev_dc_down = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.DC_Down_field).data);
bd_dc_down = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.DC_Down_field).data);

prev_dc_up = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.DC_Up_field).data);
bd_dc_up = double(tdms_struct.(field_names{BD_list{BD_index}.index}).(parameters.DC_Up_field).data);

dc_up_dt = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.DC_Up_field).Props.wf_increment);
dc_down_dt = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.DC_Down_field).Props.wf_increment);

dc_up_t = (1:length(bd_dc_up)) * dc_up_dt;
dc_down_t = (1:length(bd_dc_up)) * dc_down_dt;

psi_dt = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.PSI_amp_field).Props.wf_increment);
psr_dt = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.PSR_amp_field).Props.wf_increment);
pei_dt = double(tdms_struct.(field_names{BD_list{BD_index}.prev_index}).(parameters.PEI_amp_field).Props.wf_increment);

psi_t = (1:length(psi_signals.bd_filt)) * psi_dt;
psr_t = (1:length(psr_signals.bd_filt)) * psr_dt;
pei_t = (1:length(pei_signals.bd_filt)) * pei_dt;

%Find previous figures if they exist and close them
close(findobj('Name', 'Pulse Explorer 1'));
close(findobj('Name', 'Pulse Explorer 2'));
close(findobj('Name', 'Pulse Explorer 3'));
close(findobj('Name', 'Pulse Explorer 4'));
close(findobj('Name', 'Pulse Explorer 5'));
close(findobj('Name', 'Pulse Explorer 6'));

h = figure;
set(h, 'Name', 'Pulse Explorer 1');
hold on;
% plot(psi_signals.bd_filt, 'g');
% plot(psi_signals.prev_filt, 'g--');
% plot(pei_signals.bd_filt, 'r');
% plot(pei_signals.prev_filt, 'r--');
% plot(psr_signals.bd_filt, 'b');
% plot(psr_signals.prev_filt, 'b--');
% xlabel('Time (samples)');
plot(1e9 * psi_t, psi_signals.bd_filt, 'g');
plot(1e9 * psi_t, psi_signals.prev_filt, 'g--');
plot(1e9 * pei_t, pei_signals.bd_filt, 'r');
plot(1e9 * pei_t, pei_signals.prev_filt, 'r--');
plot(1e9 * psr_t, psr_signals.bd_filt, 'b');
plot(1e9 * psr_t, psr_signals.prev_filt, 'b--');
xlabel('Time (ns)');
title('BD and previous signals.');
set(gca, 'fontsize', 20);

h = figure;
set(h, 'Name', 'Pulse Explorer 2');
hold on;
plot(psi_signals.prev_offset, 'g');
plot(pei_signals.prev_offset, 'r');
plot(psr_signals.prev_offset, 'b');
plot(psi_edges.prev * [1 1], ylim(), 'g--');
plot(pei_edges.prev * [1 1], ylim(), 'r--');
plot(psr_edges.prev * [1 1], ylim(), 'b--');
plot(xlim(), psi_signals.prev_threshold * [1 1], 'g--');
plot(xlim(), pei_signals.prev_threshold * [1 1], 'r--');
plot(xlim(), psr_signals.prev_threshold * [1 1], 'b--');
title('Start of compressed pulse for previous signals.');
set(gca, 'fontsize', 20);

h = figure;
set(h, 'Name', 'Pulse Explorer 3');
hold on;
plot(diff(psi_signals.prev_filt), 'g');
plot(diff(pei_signals.prev_filt), 'r');
plot(diff(psr_signals.prev_filt), 'b');
plot(psi_signals.ramp_start_index * [1 1], ylim(), 'g--');
plot(pei_signals.ramp_start_index * [1 1], ylim(), 'r--');
plot(psr_signals.ramp_start_index * [1 1], ylim(), 'b--');
plot(xlim(), psi_signals.diff_threshold * [1 1], 'g--');
plot(xlim(), pei_signals.diff_threshold * [1 1], 'r--');
plot(xlim(), psr_signals.diff_threshold * [1 1], 'b--');
title('Derivative of previous signals.');
set(gca, 'fontsize', 20);

h = figure;
set(h, 'Name', 'Pulse Explorer 4');
hold on;
plot(psi_signals.dev, 'g');
plot(pei_signals.dev, 'r');
plot(psr_signals.dev, 'b');
plot(psi_edges.dev * [1 1], ylim(), 'g--');
plot(pei_edges.dev * [1 1], ylim(), 'r--');
plot(psr_edges.dev * [1 1], ylim(), 'b--');
plot(xlim(), psi_signals.dev_threshold * [1 1], 'g--');
plot(xlim(), pei_signals.dev_threshold * [1 1], 'r--');
plot(xlim(), psr_signals.dev_threshold * [1 1], 'b--');
title('Difference between previous and BD signals.');
xlabel('Time (samples)');
set(gca, 'fontsize', 20);

h = figure;
set(h, 'Name', 'Pulse Explorer 5');
hold on;
% plot(prev_dc_down, 'b--');
% plot(bd_dc_down, 'b');
% plot(prev_dc_up, 'k--');
% plot(bd_dc_up, 'k');
% xlabel('Time (samples)');
plot(1e9 * dc_down_t, prev_dc_down, 'b--');
plot(1e9 * dc_down_t, bd_dc_down, 'b');
plot(1e9 * dc_up_t, prev_dc_up, 'k--');
plot(1e9 * dc_up_t, bd_dc_up, 'k');
xlabel('Time (ns)');
title('DC signals for previous and BD pulse.');
set(gca, 'fontsize', 20);

if(~parameters.xbox1)
    %Find phase trigger sample index:
    if(strcmp(parameters.phase_sampling_edge, 'PSI'))
        ph_edge = psi_edges.dev;
    elseif(strcmp(parameters.phase_sampling_edge, 'PSR'))
        ph_edge = psr_edges.dev;
    end
    
    ph_edge = ph_edge + parameters.phase_sampling_delay;
        
    h = figure;
    set(h, 'Name', 'Pulse Explorer 6');
    hold on;
%     plot(mod(phase_diff, 2*pi) * 180/pi, 'r');
%     plot(psi_edges.dev * [1 1], ylim(), 'g--');
%     plot(psr_edges.dev * [1 1], ylim(), 'b--');
%     plot(ph_edge * [1 1], ylim(), 'k--');
%     xlabel('Time (samples)');
    plot(1e9 * psi_t, mod(phase_diff, 2*pi) * 180/pi, 'r');
    plot(psi_edges.dev * 1e9 * psi_dt * [1 1], ylim(), 'g--');
    plot(psr_edges.dev * 1e9 * psr_dt * [1 1], ylim(), 'b--');
    plot(ph_edge * 1e9 * psr_dt * [1 1], ylim(), 'k--');
    xlabel('Time (ns)');
    ylabel('\phi_{refl} - \phi_{inc} (deg)');
    ylim([0 360]);
    set(gca, 'fontsize', 20);
end
end