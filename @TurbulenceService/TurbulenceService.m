function obj = TurbulenceService

thisPath = regexprep(fileparts(which('TurbulenceService')), '/@TurbulenceService', '', 'ignorecase');
a = dir(thisPath);
set = 0;
for i = 1:numel(a)
    if a(i).isdir && ~isempty(regexpi(a(i).name, '^matlab.fast.soap'))
        addpath(sprintf('%s/%s', thisPath, a(i).name));
        set = 1;
        break;
    end
end

if ~set
    error('Could not find Matlab-Fast-SOAP package. PMake sure to include a copy of Matlab-Fast-SOAP in the Turbmat path.');
end


obj.endpoint = 'http://turbulence.pha.jhu.edu/service/turbulence.asmx';
obj.wsdl = 'http://turbulence.pha.jhu.edu/service/turbulence.asmx?WSDL';

obj = class(obj,'TurbulenceService');