
% define the  (nondimensional) 2D coordinate (x,y) in the physical domain
disp(['SQG+1 run with horizontal resolution '.....
    num2str(ng),'x',num2str(ng),' in (x,y) domain!'])
% i=2:ng+1; %indices for Arakawa Jacobian
% j=i;

x=(1:ng)./ng*Ds;    %non-dimenisonal x
[X,Y]=meshgrid(x, x); %the physical (non-dimensional) coordinates
dx=Ds/ng; %nondimensional grid size




% figure;
% plot(1:nz,Zp,'bo-');
% title('vertical grid location');
% xlabel('layers')
% ylabel('Nondimensional dep.')

% define the horizontal (nondimensional) wavenumber space (kX,kY)
k=2*pi/Ds*[0:ng/2,-ng/2+1:-1];
[kX,kY]=meshgrid(k,k); % nondimensional wavenumbers
k=sqrt(kX.^2+kY.^2); 
deno= -1./(k.*sinh(k));    % denominator in eq. 3.9
deno(1,1)=0;                    % to prevent explosion as $k \to 0$
k_tanhk = k.*cosh(k)./sinh(k);
k_tanhk(1,1)=1;
