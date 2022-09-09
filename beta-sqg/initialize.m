% this specifies the initial conditions used in the QG / SQG models for the
% beta-plane turbulence 
close all;
clc;
clear all;

% no. of grid in each direction
nn=9; %grid resolution Nx=2^nn
surfelevation = 2.e-1; % surf elevation in the eddy center, m
R_eddy = 60*1.e3;  % edddy radius, m
Omega=2*pi/86400*sind(45);% rotating of the Earth
f=2*Omega;% the Coriolis parameter

bta_sqg_c = 0.02; %nondimensional beta = bta_sqg_c*N/f, N/f=50 is common in the upper ocean ,

dt = 3600; % the time interval dt for diffustion equation (without advection)
outfreq1 = 200; % output frequency of the model at the initial moment
outfreq2 = 500; % output frequency of the model at the initial moment
TN = 500000; % total number of time marching steps


Nx=2^nn;
Ny=Nx;
disp(['Model grid resolution:',num2str(Nx),'x',num2str(Ny)]);




% horizontal dimension of the basin in meter
Lx = 1.e6;  %1000km, horizonal scale of the domain
Ly = 1.e6;  
g = 9.82; % acceleration of gravity, m/s^2
H = 200;  % mean water depth
gama =0; % linear Ekman friction, used for damping inversely cascading quantity at large scale
Rd = sqrt(g*H)/f;% barotropic deformation radius
% Rdc=Rd*0.003;
kd2 = Rd^-2; %inverse of deformation radius, Rd, square
% kdc = 2*pi/Lx*Nx/2*0.35;
% kd2c = Rdc^-2;
hdt=dt*0.5000000000000000000000000000000000000000000000000;
sdt=dt*0.1666666666666666666666666666666666666666666666666666666666666666666666666666666666667;
rd=1/86400;

 
% define the wavenumber space for the use of spectral differencing 
[kx,ky] = meshgrid( [0:Nx/2,-Nx/2+1:-1],[0:Ny/2,-Ny/2+1:-1]);
% % a spectral filter to remove the highest 1/3 wavenumbers using Hou's filter:
%alf=36; m=19;
alf=512; m=24;
HFilt = exp(-alf*abs(2*kx/Nx).^m)......
      .*exp(-alf*abs(2*ky/Nx).^m) ;

kx=kx*2*pi/Lx; % dimensional m^-1
ky=ky*2*pi/Ly;
k2 = kx.^2+ky.^2;

kx(:,Nx/2+1)=0;%suppress the grid-size instability 
ky(Ny/2+1,:)=0;%(always necessary when performing the odd-order differentiaitons)
% according to page 23, chapter 3 in <spectral method in Matlab>-Trefethen
k_ky_1j=1j*ky.* -sqrt(k2);
k_kx_1j=1j*kx.* -sqrt(k2);
% imagesc(fforcing);
% k2(1,1)=(pi/Lx)^2+(pi/Ly)^2; % put the max scale as the basin scale in the 1st element in k2 matrix
% ks = kd2 + k2;
% mrks= -1./ks;
% mrks(1,1)=0;
mrks_sqg= -1./sqrt(k2);
mrks_sqg(1,1)=0;
mrks_sqg=mrks_sqg.*HFilt; % implement 1/3 cutoff inside mrks_sqg

Ah = 0;%1e19; %horizontal viscosity, choosen to damp the small scale instability, Ah=0 is ok if 2/3-cutoff is used
% 5e18 is min required for stability given Nx=1024
% C = -dt*k2.* mrks.*(Ah*k2.^4+gama);
% Coe = 1./(1.+C); 
% figure;imagesc(C);colorbar
% figure;imagesc(Coe);colorbar


%de-aliasing: Orzag-2/3 cut-off to remove the highest 1/3 wavenumbers for QG code 
%modellings, 
% mrks(  k2>=(2*pi*Nx/(3*Lx))^2+ (2*pi*Ny/(3*Ly))^2   ) = 0;
% mrks_sqg(  k2>=(2*pi*Nx/(3*Lx))^2+ (2*pi*Ny/(3*Ly))^2   ) = 0;

% x and y location for all the points in physical space
x = (0:Nx-1)/Nx*Lx;
y = (0:Ny-1)/Ny*Ly;
[xx,yy] = meshgrid(x,y);
clear x y;

% y=2*sin(kx(3)*x);
% plot(x,kx(3)*2*cos(kx(3)*x));
% hold on;
% plot(x,real(ifft(fft(y).*kx*1j)));

% initial max surface elevation in the eddy center



amp = g*surfelevation/f; %stream function amplitude, m^2/s
% the eddy radial profile is Gaussian-like:
r2 = ((xx-0.5*Lx)./R_eddy).^2+ ( (yy-0.5*Ly)./R_eddy ).^2 ;
clear xx yy;
% the initial eddy in terms of the stream function
psi  =  amp*(1-r2*0.5).*exp(-r2);
fpsi =  fft2(  psi ); % Fourier transform of the stream function, its dimension is the same as [psi]=m^2/s
clear r2


Ro=g*surfelevation/f^2/R_eddy^2;
bta_sqg = Ro*f^2*bta_sqg_c; % dimensional beta used in  SQG, s^-2

C = dt.*(Ah*k2.^4+gama)......
   -dt*1j*kx./sqrt(k2)*bta_sqg/f;
C(1,1)=0;%otherwise C(1,1)=0/0=nan;
Coe_sqg = 1./(1+C).*HFilt; %figure;imagesc(Coe_sqg)
clear C bta_sqg ;




%zetay=real(ifft2( -1j*ky.*k2.*fpsi ))  ; % d(relative vorticity)/dy
%bta = max(abs(zetay(:)))*1.e-1; % beta used in the QG simulation


% bta * (Lx/Nx); % in sqg, the beta term has different dimension from QG beta term, 1/s(some freq
% which is beta*[R_eddy, Rd, Lx/Nx]? ).
clear psi zeta zetay k2;

output_folder=[.....
    'R',      num2str(Nx),....
    ' ep',    num2str(bta_sqg_c,'%.1e'),.....
    ' Ro',    num2str(Ro,'%5.2f'),......
    ' eta',   num2str(surfelevation*100,'%4.0f'),.......
    'cm Reddy', num2str(R_eddy*1.e-3,'%03i'),'km'.....
    ];



if exist(['./',output_folder])==7
    disp(['---------continue a old run ? ----------'])
else
    disp(['---------start a new run ----------'])
    mkdir(['./',output_folder])
        disp(['output folder ==> ',output_folder])         
end
