function [edges, signals] = process_rf_signal(prev_signal, bd_signal, prev_sample_shift,...
    window_start_index, filter_span, diff_threshold, edge_threshold)

%Shift L1 signal to align with BD signal.
prev_shifted = circshift(prev_signal, prev_sample_shift);

%Smooth waveform to remove noise and interference.
prev_filt = smooth(prev_shifted(window_start_index:end), filter_span, 'lowess');
bd_filt = smooth(bd_signal(window_start_index:end), filter_span, 'lowess');

%Find sample just before rising edge of L1 signal.
%Start of rising edge defined as sample at which derivative of signal first
%crosses a threshold. Threshold is a defined as a fraction of the signal peak.
prev_filt_diff = diff(prev_filt);
%Remove first few samples of filtered signal to remove edge artifacts.
prev_filt_diff = prev_filt_diff(filter_span:end-filter_span);
prev_filt_diff_peak = max(prev_filt_diff);
prev_pulse_start_index = max(1, find(prev_filt_diff >= diff_threshold * prev_filt_diff_peak, 1) - 1 + filter_span);

%Use the above edge information to offset the signal such that the start of
%the compressed pulse is at zero, diregarding the ramp just before the
%compressed pulse.
prev_offset = prev_filt - prev_filt(prev_pulse_start_index);

%Get difference between L1 and BD signals.
deviation = abs(prev_filt - bd_filt);

%Find the integer sample index at which the offset L2 signal crosses a
%threshold. Threshold is defined as a fraction of the signal peak.
prev_edge_index = find(prev_offset / max(prev_offset) >= edge_threshold, 1);

%Use linear interpolation to get a fractional sample index from the above.
if(prev_edge_index > 1)
    prev_edge_frac_index = (edge_threshold*max(prev_offset) - prev_offset(prev_edge_index - 1))/...
        (prev_offset(prev_edge_index) - prev_offset(prev_edge_index - 1)) + prev_edge_index;
else
    prev_edge_frac_index = 1;
end

%Apply the above steps to the difference signal
dev_edge_index = find(deviation / max(deviation) >= edge_threshold, 1);

if(dev_edge_index > 1) %In case deviation exceeds threshold over first sample
    dev_edge_frac_index = (edge_threshold*max(deviation) - deviation(dev_edge_index - 1))/...
        (deviation(dev_edge_index) - deviation(dev_edge_index - 1)) + dev_edge_index;
else
    dev_edge_frac_index = 1;
end

edges.prev = prev_edge_frac_index;
edges.dev = dev_edge_frac_index;

%Output intermediate signals
signals.prev_filt = prev_filt;
signals.prev_offset = prev_offset;
signals.bd_filt = bd_filt;
signals.dev = deviation;
signals.ramp_start_index = prev_pulse_start_index;
signals.diff_threshold = diff_threshold * prev_filt_diff_peak;
signals.prev_threshold = edge_threshold*max(prev_offset);
signals.dev_threshold = edge_threshold*max(deviation);
end