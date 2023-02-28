% define the high-order exponential spectral filter, invented by Hou & Li 2007. 
% This filter does the same job as the 2/3 cutoff but give a smooth flow field in the (X,Y) domain

kn=[0:ng/2,-ng/2+1:-1];
ci=0;
for ii=1:numel(kn)
    ci=ci+1;
    kn_label{ci}=num2str(kn(ii));
end
kn=kn/ng*2;
Hou_filter.alpha=36;
Hou_filter.m=19;
Hou_filter.d1 = exp (-Hou_filter.alpha*abs(kn).^Hou_filter.m);

figure;
imagesc(  Hou_filter.d1'*Hou_filter.d1);
set(gca, 'xtick', 1:10:ng, 'ytick', 1:10:ng, 'xticklabel',  kn_label(1:10:end), 'yticklabel',  kn_label(1:10:end))
title('Hou''s exponential filter in 2D') ;xlabel('k_X');ylabel('k_Y');