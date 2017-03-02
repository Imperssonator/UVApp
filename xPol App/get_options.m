function options = get_options(handles)


switch get(handles.sampleType,'Value')
    
    case 1 % Blanked on 90
        options = options_film_pol();
        options.blank = '90';
        
    case 2 % Blanked on 0
        options = options_film_pol();
        options.blank = '0';

    case 3 % Both blanked
        options = options_film_pol();
        options.blank = 'both';
        
    case 4 % Neither blanked
        options = options_film_pol();
        options.blank = 'neither';
        
end
