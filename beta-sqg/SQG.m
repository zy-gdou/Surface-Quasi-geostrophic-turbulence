% Quasi-geostrophic simulaiton in terms of pv and stream funciton
% ref:PHS 1994 spectra of local and nonlocal 2d turbulence: eq(1b)
% ref:Held 95 surface quasi-geostrophic dynamics
run ./initialize.m

% a typical form of 2D mesoscale eddy;     imagesc(zeta)
% fpsi=-fft2(zeta)./sqrt(k2);;  psi=real(ifft2(fpsi));figure;imagesc(psi*f/g);colorbar
% psi=amp*(r2<1.5);


% --------classic 4-order runge-kutta scheme for the nonlinear term, and
% implicit for diffusion, beta terms 
% in the spectral space ---------------------------------------


% Tday=0; %total number of days of time integration
timestep=0;
drawnow;
while timestep<TN
    timestep = timestep+1;
    
       Jac=real(ifft2( 1j*kx.*fpsi)).* (real(ifft2( k_ky_1j.*fpsi )) ) - ...
        real(ifft2( 1j*ky.*fpsi)).*  real(ifft2( k_kx_1j.*fpsi));
    sum_sJac=-fft2(Jac).*mrks_sqg; % dimension is m^2/s^2
    
    fpsi_h = fpsi + sum_sJac*hdt ; %dimension is m^2/s, the same as [psi]
    Jac=real(ifft2( 1j*kx.*fpsi_h)).* (real(ifft2( k_ky_1j.*fpsi_h )) ) - ...
        real(ifft2( 1j*ky.*fpsi_h)) .* real(ifft2( k_kx_1j.*fpsi_h));
    fJac=-fft2(Jac).*mrks_sqg;
    sum_sJac=sum_sJac +2*fJac;
    
    fpsi_h = fpsi +fJac*hdt ;
    Jac=real(ifft2( 1j*kx.*fpsi_h)).* (real(ifft2( k_ky_1j.*fpsi_h )) ) - ...
        real(ifft2( 1j*ky.*fpsi_h)) .*  real(ifft2( k_kx_1j.*fpsi_h));
    fJac=-fft2(Jac).*mrks_sqg;
    sum_sJac=sum_sJac +2*fJac;
    
    fpsi_h = fpsi + fJac*dt ;
    Jac=real(ifft2( 1j*kx.*fpsi_h)).* (real(ifft2( k_ky_1j.*fpsi_h ))) - ...
        real(ifft2( 1j*ky.*fpsi_h)).*  real(ifft2( k_kx_1j.*fpsi_h));
    sum_sJac=sum_sJac - fft2(Jac).*mrks_sqg;
    
    
    % run add_forcing.m
    fpsi = fpsi + sum_sJac*sdt;
    % the diffusion terms: Ekman friction , horizontal viscisity, and the beta term are written inside Coe in an implicit form
    fpsi=fpsi.*Coe_sqg  ;
    % fpsi=fpsi + fforcing*dt.diff;
    
%      if timestep <= 30000
        if mod(timestep,outfreq1)==0||timestep==1
%             fJac=real(ifft2(    fpsi   ));
            fJac=real(ifft2(   (-kx.^2-ky.^2).*fpsi   ));
%             save(['./',output_folder,'/psi-',num2str(timestep),'.mat'],'fJac')
            disp([num2str(timestep),' time steps.']);
            
            
                           imagesc(fJac/f,[-0.05 0.05])
                           colorbar;
                           text(10,10,[num2str(timestep),' stps'],'fontsize',15);
     pause(0.05)
            
%         end
%     else
%         if mod(timestep,outfreq2)==0            
%             %    adaptive time step
%             fJac=real(ifft2( 1j*kx.*fpsi_h));%v
%             dt=Lx/(2*Nx*max(abs(fJac(:))));
%         hdt=dt*0.5000000000000000000000000000000000000000000000000;
% sdt=dt*0.1666666666666666666666666666666666666666666666666666666666666666666666666666666666667;
%             
%             fJac=real(ifft2(fpsi));
% %             save(['./',output_folder,'/psi-',num2str(timestep),'.mat'],'fJac','Tday')
%             disp([num2str(timestep),' steps, ',num2str(Tday,'%10i'),' days.']);
        end
%     end    
    
%     Tday = Tday+dt*rd;
    
    if any(isnan(fpsi(:)))
        disp(['nan value appears, simulation overflowed at step ',num2str(timestep)])
        break;
    end
    
    
end

disp(['model finished at ',num2str(timestep/TN*100,'%5.1f'),'%'])
exit;
% save( ....
%     ['R',num2str(Nx),' Reddy ',num2str(R_eddy/1000,'%3.0f'),  ' eta ',num2str(surfelevation,'%5.2e'), ....
%     ' outfreq ',num2str(outfreq,'%3.0f'),......
%     ' beta ',num2str(bta,'%5.2e'), ' Ah ',num2str(Ah,'%5.2e'),' SQG.mat']....
%     ,'mov')
% figure;plot(ts/f)
