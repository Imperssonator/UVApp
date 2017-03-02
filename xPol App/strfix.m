function out = strfix(str)

if ~ischar(str)
    out = str;
    return
end

out = '';
for i = 1:length(str)
    if ~isempty(str2num(str(i)))
        out = [out, str(i)];
    end
end

end