%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Citation:
% Enginoğlu, S., Erkan, U., Memiş, S., 2019. Pixel similarity-based adaptive  
% Riesz mean filter for salt-and-pepper noise removal. Multimedia Tools and 
% Applications, 78, 35401–35418. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Abbreviation of Journal Title: Multimed. Tools Appl.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://doi.org/10.1007/s11042-019-08110-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% https://www.researchgate.net/profile/Serdar_Enginoglu2
% https://www.researchgate.net/profile/Ugur_Erkan
% https://www.researchgate.net/profile/Samet_Memis2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Demo: 
% clc;
% clear all;
% io=imread("lena.tif");
% Noise_Image=imnoise(io,'salt & pepper',0.8);
% Denoised_Image=ARmF(Noise_Image);
% psnr_results=psnr(io,uint8(Denoised_Image));
% ssim_results=ssim(io,uint8(Denoised_Image));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function X=ARmF(A)
A=double(A);
 for p=5:-1:1  
  pA=padarray(A,[p p],'symmetric');
  pB=(pA~=0 & pA~=255);
  [m,n]=size(pB);
  for i=1+p:m-p
    for j=1+p:n-p       
       if (pB(i,j)==0)
            for k=1:p   
                if (isequal(pB(i-k:i+k,j-k:j+k),zeros(2*k+1,2*k+1))~=1)               
                     A(i-p,j-p)=riesz(pA,i,j,k);
                     break;
                end
            end
       end
    end 
  end   
 end
 X=uint8(A);
end
function r=riesz(pA,i,j,k)
R1=pA(i-k:i+k,j-k:j+k);                          
Rz=0;
TRz=0;                            
 for s=1:2*k+1
  for t=1:2*k+1
   if(R1(s,t)~=0 && R1(s,t)~=255)
    Rz=Rz+R1(s,t)*ps(k+1,k+1,s,t);
    TRz=TRz+ps(k+1,k+1,s,t);
   end
  end
 end                                                       
r=Rz/TRz;
end
function s=ps(i,j,m,n)
    s=(1/(1+abs(i-m)+abs(j-n)))^2; 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%