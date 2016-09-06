function options = get_options(handles)

switch get(handles.sampleType,'Value')
    
    case 1
        options = options_film_pure();
        
    case 2
        options = options_sol_pure();
%         options = options_sol_spec();
        
end
