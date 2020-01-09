function [X_me,f1,S_pa]=arc_length(ellname,lat,longdiff)
%该程序用于计算子午圈和平行圈弧长
%ell椭球 lat大地纬度（弧度）
% 南阳师院 高春春
defval('ellname','int75')
defval('lat',pi/4)
defval('longdiff',pi/4)
[ell_para,ell_aux]=ellipsoidpara(ellname,lat);
a=ell_para(1);
c=ell_para(3);
e_2=ell_para(end);
W=ell_aux(:,1);
b0=1-e_2*3/4+e_2^2*45/64-e_2^3*175/256+e_2^4*11025/16384;
b2=b0-1;
b4=e_2^2*15/32-e_2^3*175/384+e_2^4*3675/8192;
b6=-e_2^3*35/96+e_2^4*735/2048;
b8=e_2^4*315/1024;
X_me=c*(b0*lat+(b2*cos(lat)+b4*cos(lat).^3+b6*cos(lat).^5+b8*cos(lat).^7).*sin(lat));
f1=c*((b2*cos(lat)+b4*cos(lat).^3+b6*cos(lat).^5+b8*cos(lat).^7).*sin(lat));
N=a./W;
S_pa=N.*cos(lat)*longdiff;

