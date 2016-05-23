function abs_base = baselineCorrect(Waves,Abs,range)

% % If only one value is provied, baseline is range -> end
% if numel(range) == 1
%     range = [range, max(Waves)];
% end

% % Convert range values into indices in Waves
% ri = range;
% ri(1) = find(Waves==range(1),1);
% ri(2) = find(Waves==range(2),1);
% 
% % Fit a line to the range of absorbance values
% reg = MultiPolyRegress(Waves(ri(1):ri(2)),Abs(ri(1):ri(2)),1);
% Baseline = Waves.*reg.PowerMatrix(1).*reg.Coefficients(1) + ...
%     Waves.*reg.PowerMatrix(2).*reg.Coefficients(2);

Baseline = Abs(find(Waves==range),1);

% Subtract that line from the whole spectrum
abs_base = Abs-Baseline;

end