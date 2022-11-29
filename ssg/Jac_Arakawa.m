% Arakawa(1966) Jacobian 9-point shceme for the nonlinear advection term J(Psi,bs) in (X,Y) coordinate system
% this schemes conserves both enstrophy and kinetic energy in a 2D plane.

Phi=zeros(ng+2);
Phi(2:end-1,2:end-1)= real(ifft2( Phi_f )); % back to the (X,Y) space
% double-periodicity boundary conditions:  4 sides
Phi(1,2:end-1)=Phi(end-1,2:end-1);
Phi(end,2:end-1)=Phi(2,2:end-1);
Phi(2:end-1,1)=Phi(2:end-1,end-1);
Phi(2:end-1,end)=Phi(2:end-1,2);
% double-periodicity boundary conditions:  4 corners
Phi(1,1)=Phi(end-1,end-1);
Phi(end,end)=Phi(2,2);
Phi(1,end)=Phi(end-1,2);
Phi(end,1)=Phi(2,end-1);


bs=zeros(ng+2);
bs(2:end-1,2:end-1)= real(ifft2( bs_f ));
bs(1,2:end-1)=bs(end-1,2:end-1);
bs(end,2:end-1)=bs(2,2:end-1);
bs(2:end-1,1)=bs(2:end-1,end-1);
bs(2:end-1,end)=bs(2:end-1,2);
bs(1,1)=bs(end-1,end-1);
bs(end,end)=bs(2,2);
bs(1,end)=bs(end-1,2);
bs(end,1)=bs(2,end-1);

% i=2:ng+1;
% j=i;

Jac=zeros(ng); %eq. 46 of Arakawa 1966 JCP paper
Jac=(Phi(j-1,i)+Phi(j-1,i+1)-Phi(j+1,i)-Phi(j+1,i+1) ).*(bs(j,i)+bs(j,i+1)).....
           -(Phi(j-1,i-1)+Phi(j-1,i)-Phi(j+1,i-1)-Phi(j+1,i) ).*(bs(j,i)+bs(j,i-1)).....
           +(Phi(j,i+1)+Phi(j+1,i+1)-Phi(j,i-1)-Phi(j+1,i-1) ).*(bs(j,i)+bs(j+1,i)) ......
           -(Phi(j-1,i+1)+Phi(j,i+1)-Phi(j-1,i-1)-Phi(j,i-1) ).*(bs(j,i)+bs(j-1,i)) .....
           +(Phi(j,i+1)-Phi(j+1,i)).*(bs(j,i)+bs(j+1,i+1)).....
           -(Phi(j-1,i)-Phi(j,i-1)).*(bs(j,i)+bs(j-1,i-1)) .......
           +(Phi(j+1,i)-Phi(j,i-1)).*(bs(j,i)+bs(j+1,i-1)).....          
           -(Phi(j,i+1)-Phi(j-1,i)).*(bs(j,i)+bs(j-1,i+1));
       
Jac=Jac*Arakawa_Jac_coe;