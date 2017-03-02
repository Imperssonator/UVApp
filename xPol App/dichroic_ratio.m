options = options_film_pure();
FN = '/USB/SUVblade/xPol/';
D = BuildDirectory(FN);
UVS = BuildStruct(D);
UVS = BaselineUV(UVS,options);
UVS = TrimUV(UVS,options);
{UVS(:).Name}'