function varargout=ellipsoidpara(ellname,lat)
%该程序用来选取不同椭球的参数和辅助函数
%ellname用来选择不同的参考椭球
%'kra'克氏椭球，'int75'1975国际椭球，'wgs84'wgs84椭球，'cgcs2000'cgcs2000椭球
%lat指纬度[正负号 度 分 秒]或弧度
%ell_para椭球参数[长半轴 短半轴 c 扁率 第一偏心率平方 第二偏心率平方]
% ell_aux辅助函数[W V]
%r_cur曲率半径[子午圈M 卯酉圈N 平均曲率半径R 短半轴r]
% 高春春 2015年11月26日第一次编制
 defval('ellname','kra')
 defval('lat',[1 30 0 0])
if size(lat,2)==4
lat_rad=((lat(:,2)+lat(:,3)/60+lat(:,4)/3600)*pi/180).*lat(:,1);
elseif size(lat,2)==1
  lat_rad=lat;
end
if strcmp(ellname,'kra')
    a=6378245.000;b=6356863.0187730473;
elseif strcmp(ellname,'int75')
    a=6378140.000; b=6356755.2881575287;
elseif strcmp(ellname,'wgs84')
    a=6378137.000; b=6356752.3142;
elseif strcmp(ellname,'cgcs2000')
    a=6378137.000; b=6356752.3141;
end
c = a*a/b;
flat = (a-b)/a;
e2 = (a*a-b*b)/(a*a);
e_2 = (a*a-b*b)/(b*b);
ell_para=[a,b,c,flat,e2,e_2];
W=sqrt(1-e2*sin(lat_rad).^2);
V=sqrt(1+e_2*cos(lat_rad).^2);
ell_aux=[W V];
r_cuv=[c./V.^3 c./V c./V.^2 c./V.*cos(lat_rad)];
varns={ell_para,ell_aux,r_cuv};
varargout=varns(1:nargout);
