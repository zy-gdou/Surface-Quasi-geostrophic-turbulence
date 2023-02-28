
% define the characteristic scales used for nondimensionalization

OM=2*pi/86400;     % angular rotation rate of the Earth, /s
f0=2*OM*sind(45); % Coriolis parameter, in /s
H=500;                     % upper layer thickness/vertical scale of motion in meter
N=80*f0;                % Brunt-Vasala freq in /s
Ld=N*H/f0;             % defromation radius in meter, as the characteristic horizontal scale
U=3;                         % horizontal velocity scale in m/s
epsilon=U/(f0*Ld);  % the geostrophic Rossby number
Ds=10;               % (nondimensional) horizontal size of the domain, Ds*Ld is the dimensional size; Ds= 2*pi*k0 by Hakim 2002 SQG+1    
disp(['-------------------------  SQG+1 turbulence  ---------------------- '])
disp(['Rossby no.:',num2str(epsilon,'%3.2f'),'; deformation rad: ',num2str(Ld*1.e-3),'km; '......
    ' Domain size: ',num2str(Ds),'*Ld; Typical U=',num2str(U),' m/s']);