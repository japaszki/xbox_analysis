function bdr = bd_filter(pulse_count_v, filter_pos, filter_param, filter_limit, filter_type)
%pulse_count_v: list of pulse counts at which BDs occured
%filter_pos: pulse count at which BDR is being evaluated
%filter_param: filtering parameter in number of pulses, eg. window size or time constant
%filter_limit: ignore breakdowns more than this many pulses away from filter_pos
%filter_type: options: moving_avg, double_expo, gaussian


window_start = min(pulse_count_v(end),  max(1, round(filter_pos - filter_limit)));
window_end = min(pulse_count_v(end), max(1, round(filter_pos + filter_limit)));
        
pulse_count_start = find(pulse_count_v >= window_start, 1, 'first');
pulse_count_end = find(pulse_count_v <= window_end, 1, 'last');

window_v = pulse_count_v(pulse_count_start:pulse_count_end);

if(strcmp(filter_type, 'moving_avg'))
    %for moving_avg, filter_param is window half-length
    bdr = nnz(abs(window_v - filter_pos) <= filter_param) / (2*filter_param);
elseif(strcmp(filter_type, 'double_expo'))
    %for double_expo, filter_param is decay constant
    acc = 0;
    
    for i = 1:length(window_v)
        acc = acc + exp(-abs(window_v(i) - filter_pos) / filter_param);
    end
    bdr = acc / (2*filter_param); 
elseif(strcmp(filter_type, 'gaussian'))
    %for gaussian, filter_param is standard deviation
    a = 1 / (2*filter_param^2);
    acc = 0;
    
    for i = 1:length(window_v)
        acc = acc + sqrt(a/pi) * exp(-a*(window_v(i) - filter_pos)^2);
    end
    bdr = acc;
else
   error('Invalid filter type.'); 
end

end