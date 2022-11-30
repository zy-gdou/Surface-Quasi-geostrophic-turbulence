% about symmetricity of fft2
ng=64; 
a=rand(ng);
 
 fa=fft2(a);
%   fa=k;

%  slice(end-i+2,end-j+2)

%  for i=ng/2+1:ng;
%      for j=1:ng
%          if (j==1)
%              if fa(i,j)~=conj(fa(   ng-i+2,  j  ));
%                  error('wrong')
%              end
%          else
%              if fa(i,j)~=conj(fa(   ng-i+2,  ng-j+2  ));
%                  error('wrong')
%              end
%          end
%      end
%  end
 
i=ng/2+1:ng;
  
j=1;
check= fa(i,j)~=conj(fa(   ng-i+2,   j   ));
sum(check(:))

 j=2:ng;
check= fa(i,j)~=conj(fa(   ng-i+2,  ng-j+2  ));
 sum(check(:))

 