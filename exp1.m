clear
%�ó�������ʵ�ִ��������ռ�ֱ������֮����໥ת��
%��d�̽���һ����Ϊshiyan1���ļ��У���blh.txt����
% �����������ʵ��һ ����ʦ��ѧԺ ����ѧԺ �ߴ���
lbh=load('d:/shiyan1/blh1.txt'); %��������
B=dms2deg(lbh(:,2));
L=dms2deg(lbh(:,1));
BLH=[B L lbh(:,3)];
XYZ=coordtransfer('int75',BLH,'blh2xyz');
BLH2=coordtransfer('int75',XYZ,'xyz2blh',1e-7);
xx=BLH2-BLH;
Bnew=deg2dms(BLH2(:,1));
Lnew=deg2dms(BLH2(:,2));
lbhnew=[Lnew Bnew BLH2(:,3)];
