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
values = { ...
   authToken, ...
   dataset, ...
   time, ...
   spatialInterpolation, ...
   temporalInterpolation, ...
   points, ...
   };
names = { ...
   'authToken', ...
   'dataset', ...
   'time', ...
   'spatialInterpolation', ...
   'temporalInterpolation', ...
   'points', ...
   };
types = { ...
   '{http://www.w3.org/2001/XMLSchema}string', ...
   '{http://www.w3.org/2001/XMLSchema}string', ...
   '{http://www.w3.org/2001/XMLSchema}float', ...
   '{http://turbulence.pha.jhu.edu/}SpatialInterpolation', ...
   '{http://turbulence.pha.jhu.edu/}TemporalInterpolation', ...
   '{http://turbulence.pha.jhu.edu/}ArrayOfPoint3', ...
   };

% Create the message, make the call, and convert the response into a variable.
soapMessage = createSoapMessage( ...
    'http://turbulence.pha.jhu.edu/', ...
    'GetPressureHessian', ...
    values,names,types,'document');
response = callSoapService( ...
    obj.endpoint, ...
    'http://turbulence.pha.jhu.edu/GetPressureHessian', ...
    soapMessage);
GetPressureHessianResult = parseSoapResponse(response);
