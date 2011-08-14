function obj = TurbulenceService

%
a = dir;
set = 0;
for i = 1:numel(a)
    if a(i).isdir && ~isempty(regexpi(a(i).name, '^matlab.fast.soap'))
        addpath(a(i).name);
        set = 1;
        break;
    end
end

if ~set
    error('Could not find Matlab-Fast-SOAP package. Please place the Matlab-FAST-SOAP package in the root of this package.');
end


obj.endpoint = 'http://turbulence.pha.jhu.edu/service/turbulence.asmx';
obj.wsdl = 'http://turbulence.pha.jhu.edu/service/turbulence.asmx?WSDL';

obj = class(obj,'TurbulenceService');

