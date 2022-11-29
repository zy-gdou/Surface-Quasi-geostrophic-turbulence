% reconstruct the Phi_f(kX,kY,Z=0) using surface buoyancy perturbation bs_f(kX,kY)
% using eq. 3.9

% D_f: fft2(phi0_XX*phi0_YY-phi0_XY^2)*Gk(0,Zp)
% which is the integrand in the RHS in eq. (3.8) in Ragon&Badin 2016JFM
D_f=zeros(ng);

% Phi^1, the next order solution is given by the numerical integration in
% vertical direction
phi1_f=zeros(ng);
for  n=nz-1:-1:1 ; %from top to surface(Z=0)
  
    phi0_f = bs_f.*cosh( k*(Zp(n+1)-1) ).*deno; 
   
    phi0_XX=real(ifft2(  -kX.*kX.*phi0_f ));
    phi0_YY=real(ifft2(  -kY.*kY.*phi0_f ));
    phi0_XY=real(ifft2(  -kX.*kY.*phi0_f ));    
    D_f =fft2(phi0_XX.*phi0_YY-phi0_XY.^2).*cosh(k*(Zp(n+1)-1));
    
    
    phi0_f = bs_f.*cosh( k*(Zp(n)-1) ).*deno;    
    
    phi0_XX=real(ifft2(  -kX.*kX.*phi0_f ));
    phi0_YY=real(ifft2(  -kY.*kY.*phi0_f ));
    phi0_XY=real(ifft2(  -kX.*kY.*phi0_f ));    
    D_f =  D_f + fft2(phi0_XX.*phi0_YY-phi0_XY.^2).*cosh(k*(Zp(n)-1)) ;
    D_f =D_f *0.5;
         
    phi1_f = phi1_f + (Zp(n+1)-Zp(n))*D_f;
    
end
phi1_f = phi1_f.*deno;
Phi_f=phi0_f + epsilon * phi1_f ;
 








% tic
% phi1_f=zeros(ng);
% for i=1:ng/2+1
%     for j=1:ng
% integ = squeeze(D_f(i,j,:)).*cosh(k(i,j)*(Zp-1))';    % Gk0zp = cosh(k*(Zp-1)).*deno;
% phi1_f(i,j) = trapz(Zp, integ)  ;
%     end
% end
% phi1_f= phi1_f.*deno;
% 
% 
% i=ng/2+2:ng;
%  phi1_f(i,1)=conj(phi1_f(   ng+2-i,  1  ));   
%  
% 
% j=2:ng;
% phi1_f(i,j)=conj(phi1_f(   ng-i+2,  ng-j+2  ));

  
% toc