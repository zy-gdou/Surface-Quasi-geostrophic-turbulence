
% define the  (nondimensional) 2D geostrophic coordinate (X,Y)
ng=512; % horizontal grid resolution for (X,Y)
disp(['SSG run with horizontal resolution '.....
    num2str(ng),'x',num2str(ng),' in (X,Y) domain!'])
i=2:ng+1; %indices for Arakawa Jacobian
j=i;

x=(1:ng)./ng*Ds;
[X,Y]=meshgrid(x, x); %the geostrophic coordinates
dx=Ds/ng; %nondimensional grid resolution

Arakawa_Jac_coe=1/(12*dx^2); %coefficient for Arakawa Jacobian
dt=0.005;  %nondimensional time step; the dimensional dt^*=dt/(epsilon*f0) in seconds
hdt=dt/2;
sdt=dt/6;
outfreq= 100;%output every outfreq steps
T_max=120;        %max (nondim) time for integration, the dimensional time is T_max/(epsilon*f0)
disp(['time step :',num2str(dt),'; output freq : ',num2str(outfreq),....
    '; Max time of integration: ',num2str(T_max)])

% define vertical grid ;
nz=40;                           % no. of the vertical layers
Zp = logspace(-3,0,nz); % 1st layer located at 10^-3*H
Zp(1)=0;                        % relocate the top layer to the surface, z=0
disp(['no. of vertical layers :',num2str(nz)])

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