% define initial  surface buoyancy,b_s, in the (kX,kY) wavenumber space
% ng=106; 
% def_grid;

% eq. 4.2
Ini.Amp = 1.e-3; 
%dimension is (Ini.Amp*N*U/g) with a unit of d\theta/theta_0 in SSG;
% dimension is U with unit of m/s in SQG+1
Ini.k0=8;
Ini.m=25;
Ini.bs_amp_stru = k.^(Ini.m/4)./(k+Ini.k0).^(Ini.m*0.5);
Ini.bs_amp_stru = Ini.bs_amp_stru./max(Ini.bs_amp_stru(:)); %normalize the structure such that
% assign an (nondimensional) amplitude and the radomn phase to the initial buoyancy spectrum
bs_f = Ini.Amp *ng^2*Ini.bs_amp_stru .*exp( 2*pi*1j* rand(ng) );
% ng^2 is to make the initial forcing amplitude insensitive to the resolution, ng

figure;imagesc(real(ifft2(bs_f)));colorbar

%in Ragon's paper, the initial non-dimensional surface KE_{sg}=5
uv_from_bs
ke=u.^2+v.^2;
disp(['initial field spectrum: k0=',num2str(Ini.k0),' m=',num2str(Ini.m),' Amp=',num2str(Ini.Amp)])
disp([  'initial Urms is ' num2str( sqrt(mean(ke(:)))*U ) ,' m/s.'])
 disp([    'surface buoyancy perturbation of relative amp ',num2str(Ini.Amp*N*U/10)  ])

% figure;
% imagesc(  bs);
% colorbar;
% title('b_s(X,Y)');
% xlabel('X');
% ylabel('Y');
% 
% 
dt =0.08*dx/sqrt(max(ke(:))) ;  %nondimensional time step; the dimensional dt^*=dt/(epsilon*f0) in seconds
hdt = dt/2; 
sdt = dt/6;
outfreq =400;% round(100/dt);      % output every outfreq steps
T_max = 100000;      % max (nondim) time for integration, the dimensional time is T_max/(epsilon*f0)
disp(['time step :',num2str(dt),'; output freq : ',num2str(outfreq),....
    '; Max time of integration: ',num2str(T_max)])