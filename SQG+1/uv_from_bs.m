% reconstruct the surface u,v using the updated 
% surface buoyancy perturbation bs(X,Y)
% following the appendix A7 of Hakim et al., JAS 2002.

 % surface buyancy perturbation 
bs= real(ifft2(bs_f)); %phi0_z
bs_bar=mean(bs(:)); %its surface averaged value
bs_x=real(ifft2( 1j*kX.*bs_f)); 
bs_y=real(ifft2( 1j*kY.*bs_f)); 

% FFT2(the 0-order stream function at the surface)
phi0_f=  bs_f.*deno.*cosh(k); %eq. 7 is for a inifinitely deep case, 
% here, in order to compare with the fintie-depth SSG flow (Ragon Badin 2017),
% the orginal zero-order solution eq.(7) is modified 

phi0_x=real(ifft2( 1j.*kX.*phi0_f)); %vs0
phi0_y=real(ifft2( 1j.*kY.*phi0_f)); %-us0



phi0_zz=real(ifft2(phi0_f.*k.*k));
phi0_xz=real(ifft2(bs_f.*1j.*kX ));
phi0_yz=real(ifft2(bs_f.*1j.*kY ));

phi_tilde_1z_f = fft2( bs_bar - bs.*phi0_zz);  %fft2(rhs in the last eq. in A6)

phi1_tilde_x= real(ifft2(   phi_tilde_1z_f.*1j.*kX.*deno.*cosh(k)   ));
phi1_tilde_y= real(ifft2(   phi_tilde_1z_f.*1j.*kY.*deno.*cosh(k)   ));

phi1_x = bs.*phi0_xz + phi1_tilde_x;
phi1_y = bs.*phi0_yz + phi1_tilde_y;


% eq: A7 in appendix A
F1_z=phi0_yz.*bs+phi0_zz.*phi0_y;
F1_z=F1_z+real(ifft2(   fft2(phi0_y.*bs).*k_tanhk   ));

G1_z = - phi0_xz.*bs - phi0_x.*phi0_zz;
G1_z = G1_z-real(ifft2(   fft2(phi0_x.*bs).*k_tanhk   ));


v =   phi0_x + epsilon*phi1_x - epsilon*G1_z;
u = - phi0_y - epsilon*phi1_y + epsilon*F1_z;

% subplot(221)
% imagesc(abs(phi0_x));
% colorbar;subplot(222)
% imagesc(abs(phi1_x));
% colorbar;subplot(223)
% imagesc(abs(G1_z));
% colorbar