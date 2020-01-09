function [B,L]=gauss_xy2bl(ellname,x,y,L0,outputformat)
%该程序用来实现高斯坐标反算
%输入参数：ellname 椭球名字 x y高斯平面坐标（单位：m) L0 中央子午线(degree)
%          outputformat为输出角度的格式
% 输出参数：B 大地纬度 L 大地经度 （单位：degree）
% 南阳师范学院 高春春 2019年11月29日编写
defval('ellname','kra')
defval('x',3.378627239487606e+06)
defval('y',-2.560465873789376e+05)
defval('L0',117)
defval('outputformat','dms')
ell_para=ellipsoidpara(ellname);
e_2=ell_para(end);
c=ell_para(3);
b0=1-e_2*3/4+e_2^2*45/64-e_2^3*175/256+e_2^4*11025/16384;
Bf0=x/b0/c;
while 1
    [~,f1]=arc_length(ellname,Bf0);
    Bfi=(x-f1)/b0/c;
    eps=1e-10;
    bi=abs(Bfi-Bf0)<eps;
    sumbla=sum(bi);
    an=size(Bfi,1);
    if sumbla==an
        break
    end
    Bf0=Bfi;
end
Bf=Bfi;
[~,~,r_cuv]=ellipsoidpara(ellname,Bf);
Mf=r_cuv(:,1);
Nf=r_cuv(:,2);
tf=tan(Bf);
etaf2=e_2*cos(Bf).^2;
B=Bf-tf.*y.^2./Mf./Nf/2+tf.*(5+3*tf.^2+etaf2-9*etaf2.*tf.^2).*y.^4./Mf./Nf.^3/24-...
    tf.*(61+90*tf.^2+45.*tf.^4).*y.^6./Mf./Nf.^5/720;
l=y./Nf./cos(Bf)-(1+2*tf.^2+etaf2).*y.^3./Nf.^3./cos(Bf)/6+...
    (5+28*tf.^2+24*tf.^4+6*etaf2+8*etaf2.*tf.^2).*y.^5./Nf.^5./cos(Bf)/120;
B=B*180/pi;
L=L0+l*180/pi;
if strcmp(outputformat,'dms')
    B=deg2dms(B);
    L=deg2dms(L);
elseif strcmp(outputformat,'deg')
    B=B;
    L=L;
elseif strcmp(outputformat,'rad')
    B=B*pi/180;
    L=L*pi/180;
end
