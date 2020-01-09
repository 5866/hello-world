clear
%该程序用来实现大地坐标与空间直角坐标之间的相互转换
%在d盘建立一个名为shiyan1的文件夹，将blh.txt放入
% 测量程序设计实验一 南阳师范学院 环旅学院 高春春
lbh=load('d:/shiyan1/blh1.txt'); %载入数据
B=dms2deg(lbh(:,2));
L=dms2deg(lbh(:,1));
BLH=[B L lbh(:,3)];
XYZ=coordtransfer('int75',BLH,'blh2xyz');
BLH2=coordtransfer('int75',XYZ,'xyz2blh',1e-7);
xx=BLH2-BLH;
Bnew=deg2dms(BLH2(:,1));
Lnew=deg2dms(BLH2(:,2));
lbhnew=[Lnew Bnew BLH2(:,3)];
