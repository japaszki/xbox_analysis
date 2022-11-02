function [bin_centres, bin_values] = bd_binning(values, bin_size)
%bd_binning Put BD data into bins of given size

%Sort in ascending order
sorted_values = sort(values);

bin_centres = [];
bin_values = [];

%Populate bins up to defined size
%Remainder of data insufficient to fill a bin is discarded.
curr_bin = [];
for i = 1:length(sorted_values)
    curr_bin = [curr_bin sorted_values(i)];
    
    if(length(curr_bin) >= bin_size)
        %Wider span of values for given bin size means smaller value of PDF
        bin_span = max(curr_bin) - min(curr_bin);
        
        %Reject bin if span is 0.
        if(bin_span > 0)
            bin_centres = [bin_centres mean(curr_bin)];
            bin_values = [bin_values 1./bin_span];
        end
        curr_bin = [];
    end
end

%Normalise bin values to PDF (ie. sum = 1)
bin_values = bin_values / sqrt(sum(bin_values));

end