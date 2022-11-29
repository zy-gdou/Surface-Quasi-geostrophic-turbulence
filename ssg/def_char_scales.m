
% define the characteristic scales used for nondimensionalization

OM=2*pi/86400;     % angular rotation rate of the Earth, /s
f0=2*OM*sind(35); % Coriolis parameter, in /s
H=200;                     % upper layer thickness/vertical scale of motion in meter
N=300*f0;                % Brunt-Vasala freq in /s
Ld=N*H/f0;             % defromation radius in meter
U=1;                         % horizontal velocity scale in m/s
epsilon=U/(f0*Ld);  % the geostrophic Rossby number
Ds=15;                   % (nondimensional) horizontal size of the domain, Ds*Ld is the dimensional size
T_max=500;        %max (nondim) time for integration, the dimensional time is T_max/(epsilon*f0)
