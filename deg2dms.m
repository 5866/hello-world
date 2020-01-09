function dms=deg2dms(deg)
%该函数用来实现度到度分秒的转换
defval('deg',-114.1569)
coor(:,1)=sign(deg);
coor(:,2)=fix(abs(deg));
coor(:,3)=fix((abs(deg)-coor(:,2))*60);
coor(:,4)=((abs(deg)-coor(:,2))*60-fix((abs(deg)-coor(:,2))*60))*60;
dms=coor(:,1).*(coor(:,2)+coor(:,3)/100+coor(:,4)/10000);
