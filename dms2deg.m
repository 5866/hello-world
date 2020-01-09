function deg=dms2deg(dms)
%该函数用来实现度分秒到度的转换
defval('dms',-114.0925)
coor(:,1)=sign(dms);
coor(:,2)=fix(abs(dms));
coor(:,3)=fix((abs(dms)-coor(:,2))*100);
coor(:,4)=((abs(dms)*100-fix(abs(dms)*100)))*100;
deg=coor(:,1).*(coor(:,2)+coor(:,3)/60+coor(:,4)/3600);
