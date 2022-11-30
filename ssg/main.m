clear all;close all;clc;
% this is a script for the surface-semi-geostrophic turbulence
% following Ragon & Badin's  2016 JFM: 
% A study of surface semi-geostrophic turbulence: Freely decaying dynamics paper
 

def_char_scales;  %define the characteristic scales 
def_grid;              %define the horizontal grid and the associated wavenumbers
def_2irds_cutoff_filter; %define the spectral filter used to suppress the small-scale noises
def_ini_bs;                  %define the initial buoyancy perturbation field
close all;


% ---------------------- mian iteration-------------------
drawnow;
T=0;
niter=0;
while T<T_max
    
    phi_from_bs;
    Jac_Arakawa;
    k1=fft2(Jac);
    
    bs_f0=bs_f;
   
    
    bs_f = bs_f0+  k1*hdt;
    phi_from_bs;
    Jac_Arakawa;
    k2=fft2(Jac);
    
    bs_f = bs_f0+  k2*hdt;
    phi_from_bs;
    Jac_Arakawa;
    k3=fft2(Jac);
    
    bs_f = bs_f0+  k3*dt;
    phi_from_bs;
    Jac_Arakawa;
    k4=fft2(Jac);
    
    bs_f = bs_f0+(k1+2*k2+2*k3+k4)*sdt;
    bs_f =  Hou_filter.d1'*Hou_filter.d1.*bs_f;
       
    T=T+dt;
    niter=niter+1;
    
    if mod(niter, outfreq)==0
        imagesc( real(ifft2(bs_f))  );
        out_filename=['T=',num2str(T)];
        colorbar;title(['b_s(X,Y) ',out_filename])
        print(gcf,[out_filename],'-r200','-dpng')
        pause(0.05);
    end
    
end






% figure;imagesc(u*U );
% colorbar;title('u, m/s');







