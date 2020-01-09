function [x,y,fx,fy]=gauss_bl2xy(ellname,Bd,Ld,L0)
%该程序实现高斯坐标的正算
% 输入参数：
% ellname 椭球名字以求取参数
% Bd 大地纬度（degree)
% Ld 大地经度（degree）
% L0 零子午线经度（degree）
% 输出参数：
% x y 高斯平面坐标
% fx fy 辅助参数
% 南阳师院 高春春 2019年11月22日
defval('ellname','kra')
defval('Bd',30.5)
defval('Ld',114+20/60)
defval('L0',(fix(Ld/6)+1)*6-3)
l=(Ld-L0)/180*pi; %换成弧度
Brad = Bd/180*pi;
[ell_para,~,r_cuv] = ellipsoidpara(ellname,Brad);
N=r_cuv(:,2);
t = tan(Brad);
eta2 = ell_para(end)*cos(Brad).^2;
X=arc_length(ellname,Brad);
fx=N.*sin(Brad).*cos(Brad).*l.^2/2+N.*sin(Brad).*cos(Brad).^3.*(5-t.^2+9*eta2+4*eta2.^2).*l.^4/24+...
    N.*sin(Brad).*cos(Brad).^5.*(61-58*t.^2+t.^4).*l.^6/720;
fy=N.*cos(Brad).^3.*(1-t.^2+eta2).*l.^3/6+...
    N.*cos(Brad).^5.*(5-18*t.^2+t.^4+14*eta2-58*eta2.*t.^2).*l.^5/120;
x=X+fx;
y=N.*cos(Brad).*l+fy;
