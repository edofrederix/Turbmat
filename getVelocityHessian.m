%
%  Written by:
%  
%  Jason Graham
%  The Johns Hopkins University
%  Department of Mechanical Engineering
%  jgraha8@gmail.com
%

function result = getVelocityHessian(authToken,dataset,time,spatialInterpolation, ...
                                     temporalInterpolation,npoints, points)
%
%     Retrieve velocity hessian for specified 'time' and 'points'
%   
%     Input:
%       authToken = (string)
%       dataset = (string)
%       time = (float)
%       spatialInterpolation = (string)
%       temporalInterpolation = (string)
%       npoints = (integer)
%       points = (float array 3xN)
%   
%     Output:
%       result = (float array 3xN)
%     

if( size(points,1) ~= 3 || size(points,2) ~= npoints)
    
  error('Points not specified correctly.');

end

% Get the TurbulenceService object
obj = TurbulenceService;

resultStruct =  GetVelocityHessian (obj, authToken, dataset, time, ...
		spatialInterpolation, ...
		temporalInterpolation, ...
		points);

result = getVector(resultStruct.GetVelocityHessianResult.VelocityHessian);

return
