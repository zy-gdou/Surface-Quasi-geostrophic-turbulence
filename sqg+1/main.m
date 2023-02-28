clear all;close all;clc;
% this is a script for the SQG+1 turbulence
% following Hakim 2002 J. of American Meteorology Society:
% A new surface model for cyclone-anticyclone asymmetry

% The purpose is to compare it with the SSG turbulence by Ragon and
% Badin 2017, whose SSG is for a finite-depth case. Here, Hakim's SQG+1
% is also modified into into a finite-depth version for comparison

ng = 128; % horizontal grid resolution for (x,y)
def_char_scales;  %define the characteristic scales
def_grid;              %define the horizontal grid and the associated wavenumbers
def_2irds_cutoff_filter; %define the spectral filter used to suppress the small-scale noises
def_ini_bs;                  %define the initial buoyancy perturbation field
close all;


% ---------------------- mian iteration-------------------
drawnow;
T=0;
niter=0;
nt2=0;
while T<T_max
    
    uv_from_bs    
    k1=fft2( - u.*bs_x - v.*bs_y);
    
    bs_f0=bs_f;
        
    bs_f = bs_f0+  k1*hdt;
    uv_from_bs
    k2= fft2(- u.*bs_x - v.*bs_y);
    
    bs_f = bs_f0+  k2*hdt;
    uv_from_bs;
    k3= fft2(- u.*bs_x - v.*bs_y);
    
    bs_f = bs_f0+  k3*dt;
    uv_from_bs;
    k4= fft2(- u.*bs_x - v.*bs_y);
    
    bs_f = bs_f0+(k1+2*k2+2*k3+k4)*sdt;
    bs_f =  Hou_filter.d1'*Hou_filter.d1.*bs_f;
    
    T=T+dt;
    niter=niter+1;
    
    if mod(niter, outfreq)==0
        nt2=nt2+1;
        Ts_bs_bar(nt2)=bs_bar;
               
        imagesc(  - bs    );
        out_filename=['T=',num2str(T)];
        colorbar;
        title(['b_s(x,y) ',out_filename])
%         set(gca,'xtick',[],'ytick',[])
%         caxis([-1 1]*2.e-2)
%         print(gcf,[out_filename],'-r200','-dpng')
        pause(0.05);
    end    
end
