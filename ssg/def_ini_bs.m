% define initial  surface buoyancy,b_s, in the (kX,kY) wavenumber space

% eq. 4.2
Ini.k0=14;
Ini.m=25;
Ini.Amp=15;
Ini.bs_amp_stru=k.^(Ini.m/4)./(k+Ini.k0).^(Ini.m*0.5);
Ini.bs_amp_stru=Ini.bs_amp_stru./max(Ini.bs_amp_stru(:)); %normalize the structure such that
% the max is 1.  There are of course other ways for normalization,
% assign an (nondimensional) amplitude and the radomn phase to the initial buoyancy spectrum
bs_f = Ini.Amp *Ini.bs_amp_stru .*exp( 2*pi*1j* rand(ng) );

% % d\theta/\theta_0 = e
%d\theta is the temperature perturbation, which dirves the SSG system

%in Ragon's paper, the initial non-dimensional surface KE_{sg}=5
% thus the following could be checked 
phi_from_bs
v=real(ifft2(  1j*kX.*Phi_f ));
u=real(ifft2( -1j*kY.*Phi_f));
ke=0.5*(u.^2+v.^2);
disp(['initial field spectrum: k0=',num2str(Ini.k0),' m=',num2str(Ini.m),' Amp=',num2str(Ini.Amp)])
disp([  'initial surface kinetic energy is ' num2str( sum(ke(:)) )   ])

figure;
imagesc( real(ifft2( bs_f )) );
colorbar;
title('b_s(X,Y)');
xlabel('X');
ylabel('Y');