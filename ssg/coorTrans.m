% this script is used for postprocessing
% it transfers the fields in the geostrophic coordinate system (X,Y)
% into the physical coodinate system (xp,yp) through a fix-point iteration method
% (see Appendix B in Ragon&Badin 2017)

% (Xn Yn) in the code are the geostrophic coodinates of (x,y)
 

clear x xx  yy X Y ts

x=(1:ng);
[xp,yp]=meshgrid(x,x);
% initial coordinates of the points in the field in (X,Y) coordinate system
xp=xp*Ds/ng;
yp=yp*Ds/ng;

% surface buoyance perturbation in geostrophic coordinate sys. (X,Y)
bs_XY=real(ifft2(bs_f));
figure
pcolor(xp, yp, bs_XY);
shading flat;

% padded X and Y coordinates due to the double-periodic boundary condition.
x=[1-ng:0 1:ng  ng+1:2*ng ];
[X,Y]=meshgrid(x,x);
X=X*Ds/ng;
Y=Y*Ds/ng;
% figure;  imagesc(X);
% figure;  imagesc(Y );


clear psi_X psi_Y; % pad psi_X and psi_Y at 4 sides
psi_X= real(ifft2(1j*kX.*Phi_f)) ; %non dimensional
psi_X=[psi_X psi_X psi_X];
psi_X=[psi_X;psi_X;psi_X];
psi_Y= real(ifft2(1j*kY.*Phi_f));
psi_Y=[psi_Y psi_Y psi_Y];
psi_Y=[psi_Y;psi_Y;psi_Y];

% initial guess, Xn Yn could be any value \in [-Ds, 2Ds]
Xn=0.5*Ds;
Yn=0.5*Ds;

nv=4;
n=0;
Niter= 5; %no. of iteration for the fixed-point itertion method

figure;
hold on;
while n<Niter
    
    psi_X2=interp2(X,Y,psi_X,Xn,Yn);
    psi_Y2=interp2(X,Y,psi_Y,Xn,Yn);
    
    Xn=xp + epsilon*psi_X2 ;  % eq. B.1
    Yn=yp + epsilon*psi_Y2;
            
    n=n+1;
    hold on;
    plot(Xn(1:nv:end,1:nv:end),Yn(1:nv:end,1:nv:end),'marker','*','linestyle','none','color',rand(1,3));
    
    ts(:,:,n)=Xn(1:nv:end,1:nv:end) + 1j* Yn(1:nv:end,1:nv:end);
end


% check the convergence of the fix-point iteration method.
figure
hold on
for i=1:size(ts,1)
    for j=1:size(ts,2)
        slice = squeeze((ts(i,j,:)));
        plot(log10(abs(diff(slice))),'marker','x','linestyle','-','color',rand(1,3))
    end
end
ylabel('log(\delta x)')
xlabel([' no. of iteration'])
box on;

bs_XY=[ bs_XY  bs_XY  bs_XY];
bs_XY=[ bs_XY; bs_XY; bs_XY];
bs_xy=interp2(X, Y,  bs_XY,  Xn,  Yn);

figure
pcolor(xp,yp,bs_xy);
shading flat;
title('b_s(x,y)')
