
% define the  (nondimensional) 2D geostrophic coordinate (X,Y)
ng=128; % horizontal grid resolution for (X,Y)
i=2:ng+1; %indices for Arakawa Jacobian
j=i;
x=(1:ng)./ng*Ds;
[X,Y]=meshgrid(x, x); %the geostrophic coordinates
dx=Ds/ng; %nondimensional grid resolution

Arakawa_Jac_coe=1/(12*dx^2); %coefficient for Arakawa Jacobian
dt=0.05;  %nondimensional time step; the dimensional dt^*=dt/(epsilon*f0) in seconds
hdt=dt/2;
sdt=dt/6;

% define vertical grid ;
nz=40;                           % no. of the vertical layers
Zp = logspace(-3,0,nz); % 1st layer located at 10^-3*H
Zp(1)=0;                        % relocate the top layer to the surface, z=0

figure;
plot(1:nz,Zp,'bo-');
title('vertical grid location');
xlabel('layers')
ylabel('Nondimensional dep.')

% define the horizontal (nondimensional) wavenumber space (kX,kY)
% associated with the geostrophic coordinate system (X,Y)
k=2*pi/Ds*[0:ng/2,-ng/2+1:-1];
[kX,kY]=meshgrid(k,k); % nondimensional wavenumbers
k=sqrt(kX.^2+kY.^2); 
deno= -1./(k.*sinh(k));    % denominator in eq. 3.9
deno(1,1)=0;                    % to prevent explosion as $k \to 0$