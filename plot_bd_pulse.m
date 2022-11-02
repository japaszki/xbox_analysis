function plot_bd_pulse(bd_pulse, prev_pulse, parameters, show_prev)

figure;
hold on;
plot(bd_pulse.(parameters.PSI_amp_field).data, 'g');
plot(bd_pulse.(parameters.PEI_amp_field).data, 'r');
plot(bd_pulse.(parameters.PSR_amp_field).data, 'b');
if(show_prev)
    plot(prev_pulse.(parameters.PSI_amp_field).data, 'g--');
    plot(prev_pulse.(parameters.PEI_amp_field).data, 'r--');
    plot(prev_pulse.(parameters.PSR_amp_field).data, 'b--');
end
xlabel('Time (samples)');
title('RF Signals');
set(gca, 'fontsize', 20);

figure;
hold on;
plot(bd_pulse.(parameters.DC_Down_field).data, 'b');
plot(bd_pulse.(parameters.DC_Up_field).data, 'k');
if(show_prev)
    plot(prev_pulse.(parameters.DC_Down_field).data, 'b--');
    plot(prev_pulse.(parameters.DC_Up_field).data, 'k--');
end
xlabel('Time (samples)');
legend('Downstream', 'Upstream');
title('Faraday cup signals');
set(gca, 'fontsize', 20);

end