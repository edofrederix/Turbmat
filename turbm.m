%
% JHU Turbulence Database sample Matlab client code
%
clear all;
close all;

authkey = 'edu.jhu.pha.turbulence.testing-201104';
dataset = 'isotropic1024coarse';

% Generates TurbulenceService object
%createClassFromWsdl('http://turbulence.pha.jhu.edu/service/turbulence.asmx?WSDL')

% ---- Temporal Interpolation Options ----
NoTInt   = 'None' ; % No temporal interpolation
PCHIPInt = 'PCHIP'; % Piecewise cubic Hermit interpolation in time

% ---- Spatial Interpolation Flags for getVelocity &amp; getVelocityAndPressure ----
NoSInt = 'None'; % No spatial interpolation
Lag4   = 'Lag4'; % 4th order Lagrangian interpolation in space
Lag6   = 'Lag6'; % 6th order Lagrangian interpolation in space
Lag8   = 'Lag8'; % 8th order Lagrangian interpolation in space

% ---- Spatial Differentiation &amp; Interpolation Flags for getVelocityGradient &amp; getPressureGradient ----
FD4NoInt = 'None_Fd4' ; % 4th order finite differential scheme for grid values, no spatial interpolation
FD6NoInt = 'None_Fd6' ; % 6th order finite differential scheme for grid values, no spatial interpolation
FD8NoInt = 'None_Fd8' ; % 8th order finite differential scheme for grid values, no spatial interpolation
FD4Lag4  = 'Fd4Lag4'  ; % 4th order finite differential scheme for grid values, 4th order Lagrangian interpolation in space

%  Set time step to sample
timestep = 182;
time = 0.002 * timestep;

npoints = 10;

points = zeros(3,npoints);
result1  = zeros(npoints);
result3  = zeros(3,npoints);
result4  = zeros(4,npoints);
result6  = zeros(6,npoints);
result9  = zeros(9,npoints);
result18 = zeros(18,npoints);

%  Set spatial locations to sample
for p = 1:npoints
  points(1,p) = 0.20 * p;
  points(2,p) = 0.50 * p;
  points(3,p) = 0.15 * p;
end

fprintf('\nRequesting velocity at %i points...\n',npoints);
result3 =  getVelocity (authkey, dataset, time, Lag6, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: %f, %f, %f\n', p, result3(1,p),  result3(2,p),  result3(3,p));
end

fprintf('\nRequesting forcing at %i points...\n',npoints);
result3 =  getForce (authkey, dataset, time, Lag6, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: %f, %f, %f\n', p, result3(1,p),  result3(2,p),  result3(3,p));
end

fprintf('\nRequesting velocity and pressure at %i points...\n',npoints);
result4 = getVelocityAndPressure (authkey, dataset, time, Lag6, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: %f, %f, %f, %f\n', p, result4(1,p),  result4(2,p),  result4(3,p), result4(4,p));
end

fprintf('\nRequesting velocity gradient at %i points...\n',npoints);
result9 = getVelocityGradient (authkey, dataset, time,  FD4Lag4, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: duxdx=%f, duxdy=%f, duxdz=%f, duydx=%f, duydy=%f, duydz=%f, duzdx=%f, duzdy=%f, duzdz=%f\n', p, ...
    result9(1,p), result9(2,p), result9(3,p), ...
    result9(4,p), result9(5,p), result9(6,p), ...
    result9(7,p), result9(8,p), result9(9,p));
end

fprintf('\nRequesting velocity hessian at %i points...\n',npoints);
result18 = getVelocityHessian (authkey, dataset, time, FD4Lag4, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: d2uxdxdx=%f, d2uxdxdy=%f, d2uxdxdz=%f, d2uxdydy=%f, d2uxdydz=%f, d2uxdzdz=%f, d2uydxdx=%f, d2uydxdy=%f, d2uydxdz=%f, d2uydydy=%f, d2uydydz=%f, d2uydzdz=%f, d2uzdxdx=%f, d2uzdxdy=%f, d2uzdxdz=%f, d2uzdydy=%f, d2uzdydz=%f, d2uzdzdz=%f\n', p, ...
    result18(1,p), result18(2,p), result18(3,p), result18(4,p), result18(5,p), result18(6,p), ...
    result18(7,p), result18(8,p), result18(9,p), result18(10,p), result18(11,p), result18(12,p), ...
    result18(13,p), result18(14,p), result18(15,p), result18(16,p), result18(17,p), result18(18,p));
end

fprintf('\nRequesting velocity laplacian at %i points...\n',npoints);
result3 =  getVelocityLaplacian (authkey, dataset, time, FD4Lag4, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: grad2ux=%f, grad2uy=%f, grad2uz=%f\n', p, result3(1,p),  result3(2,p),  result3(3,p));
end

fprintf('\nRequesting pressure gradient at %i points...\n',npoints);
result3 =  getPressureGradient (authkey, dataset, time, FD4Lag4, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: dpdx=%f,dpdy=%f,dpdz=%f\n', p, result3(1,p),  result3(2,p),  result3(3,p));
end

fprintf('\nRequesting pressure hessian at %i points...\n',npoints);
result6 = getPressureHessian (authkey, dataset, time, FD4Lag4, NoTInt, npoints, points);
for p = 1:npoints
  fprintf(1,'%i: d2pdxdx=%f,d2pdxdy=%f,d2pdxdz=%f, d2pdydy=%f, d2pdydz=%f, d2pdzdz=%f\n', p, ...
    result6(1,p), result6(2,p), result6(3,p), ...
    result6(4,p), result6(5,p), result6(6,p));
end

% ///////////////////////////////////////////////////////////
% ////////////// GENERATE A SIMPLE CONTOUR PLOT /////////////
%////////////////////////////////////////////////////////////

%  Chose a random time step
time = 0.002 * randi(1024,1);
spacing = 2.0*pi/1023;

% Set domain size and position
nx = 64;
ny = nx;
xoff = 2*pi*rand; 
yoff = 2*pi*rand;
zoff = 2*pi*rand;
npoints = nx*ny;

clear points;

% Create surface
x = linspace(0, (nx-1)*spacing, nx) + xoff;
y = linspace(0, (ny-1)*spacing, ny) + yoff;
[X Y] = meshgrid(x, y);
points(1:2,:) = [X(:)'; Y(:)'];
points(3,:) = zoff;
    
% Get the velocity at each point
fprintf('\nRequesting velocity at %i points...\n',npoints);
result3 = getVelocity(authkey, dataset, time, Lag4, NoTInt, npoints, points);

% Calculate velocity magnitude
z = sqrt(result3(1,:).^2 + result3(2,:).^2 + result3(3,:).^2);
Z = transpose(reshape(z, nx, ny));

% Plot velocity magnitude contours
contourf(X, Y, Z, 30, 'LineStyle', 'none');
set(gca, 'FontSize', 11)
title('Velocity magnitude', 'FontSize', 13, 'FontWeight', 'bold');
xlabel('x', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('y', 'FontSize', 12, 'FontWeight', 'bold');
colorbar('FontSize', 12);
axis([xoff max(x) yoff max(y)]);
set(gca, 'TickDir', 'out', 'TickLength', [.02 .02],'XMinorTick', 'on', 'YMinorTick', 'on');

