function GetPressureHessianResult = GetPressureHessian(obj,authToken,dataset,time,spatialInterpolation,temporalInterpolation,points)
%GetPressureHessian(obj,authToken,dataset,time,spatialInterpolation,temporalInterpolation,points)
%
%   Retrieve the pressure hessian at a fixed location
%   
%     Input:
%       authToken = (string)
%       dataset = (string)
%       time = (float)
%       spatialInterpolation = (SpatialInterpolation)
%       temporalInterpolation = (TemporalInterpolation)
%       points = (ArrayOfPoint3)
%   
%     Output:
%       GetPressureHessianResult = (ArrayOfPressureHessian)

% Build up the argument lists.
data.val.authToken.name = 'authToken';
data.val.authToken.val = authToken;
data.val.authToken.type = '{http://www.w3.org/2001/XMLSchema}string';
data.val.dataset.name = 'dataset';
data.val.dataset.val = dataset;
data.val.dataset.type = '{http://www.w3.org/2001/XMLSchema}string';
data.val.time.name = 'time';
data.val.time.val = time;
data.val.time.type = '{http://www.w3.org/2001/XMLSchema}float';
data.val.spatialInterpolation.name = 'spatialInterpolation';
data.val.spatialInterpolation.val = spatialInterpolation;
data.val.spatialInterpolation.type = '{http://turbulence.pha.jhu.edu/}SpatialInterpolation';
data.val.temporalInterpolation.name = 'temporalInterpolation';
data.val.temporalInterpolation.val = temporalInterpolation;
data.val.temporalInterpolation.type = '{http://turbulence.pha.jhu.edu/}TemporalInterpolation';
data.val.points.name = 'points';
data.val.points.wrap = 'Point3';
data.val.points.parallel = 1;
data.val.points.val.x.name = 'x';
data.val.points.val.x.val = points(1,:);
data.val.points.val.y.name = 'y';
data.val.points.val.y.val = points(2,:);
data.val.points.val.z.name = 'z';
data.val.points.val.z.val = points(3,:);

% Create the message, make the call, and convert the response into a variable.
soapMessage = createSoapMessage( ...
    'http://turbulence.pha.jhu.edu/', ...
    'GetPressureHessian', ...
    data,'document');
response = callSoapService( ...
    obj.endpoint, ...
    'http://turbulence.pha.jhu.edu/GetPressureHessian', ...
    soapMessage);
GetPressureHessianResult = parseSoapResponse(response);

% Fault message handling
if isfield(GetPressureHessianResult, 'faultstring')
    error('faultcode: %s\nfaultstring: %s\n', ...
        GetPressureHessianResult.faultcode, ...
        GetPressureHessianResult.faultstring);
end