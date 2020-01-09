function coordafter = coordtransfer(ellname,coordbefore,opt,pe)
%该程序用来实现大地坐标（blh)与空间直角坐标(xyz)的相互转换
% 输入参数介绍：
% ellname 椭球名字 
% coordbefore 要转换的坐标:[B L H](角度) 或[X Y Z](单位m)
% opt 控制选项（option） “blh2xyz”代表大地坐标转为空间直角坐标  “xyz2blh”代表空间直角坐标转为大地坐标
% pe 大地纬度迭代算法的允许误差（permissible error）
% 输出参数介绍：
% coordafter 转换后的坐标
% 高春春 南阳师范学院 2019-10-24 编制
defval('ellname','int75')
defval('coordbefore',[-442637.918525766,989812.166906006,6270209.38311966])
defval('opt','xyz2blh')
defval('pe',1e-7)
ell_para=ellipsoidpara(ellname); %提取椭球参数
a=ell_para(1);
e2=ell_para(5);
if strcmp(opt,'blh2xyz') % 大地坐标转为空间直角坐标
B=coordbefore(:,1);
L=coordbefore(:,2);
H=coordbefore(:,3);
W=sqrt(1-e2*sind(B));
N=a./W;
X=(N+H).*cosd(B).*cosd(L); % 4-30公式
Y=(N+H).*cosd(B).*sind(L);
Z=(N*(1-e2)+H).*sind(B);
coordafter=[X Y Z];
elseif strcmp(opt,'xyz2blh') %空间直角坐标转为大地坐标
X=coordbefore(:,1);
Y=coordbefore(:,2);
Z=coordbefore(:,3); 
L=atan(Y./X); % 4-31公式
nn=size(coordbefore,1);
for ii=1:nn 
    if sign(X(ii,1))==-1&&sign(Y(ii,1))==1 %判断L位于哪个象限
        L(ii,1)=pi+L(ii,1);
    elseif  sign(X(ii,1))==-1&&sign(Y(ii,1))==-1
         L(ii,1)=L(ii,1)-pi;
    end   
   L(ii,1)=L(ii,1)/pi*180;
   B(ii,1)=atan(Z(ii,1)/sqrt(X(ii,1)^2+Y(ii,1)^2)); % 4-32公式
   jj=1;
   while 1  %迭代求B
   W(ii,jj)=sqrt(1-e2*sin(B(ii,jj)));
   N(ii,jj)=a/W(ii,jj);
   B(ii,jj+1)=atan((Z(ii,1)+N(ii,jj)*e2*sin(B(ii,jj)))/sqrt(X(ii,1)^2+Y(ii,1)^2));
   if abs(B(ii,jj+1)-B(ii,jj))<pe
    break
   end
   jj=jj+1;
end
Bnew(ii,1)=B(ii,jj+1)/pi*180; %计算迭代后的B W 和 N
Wnew(ii,1)=sqrt(1-e2*sind(Bnew(ii,1)));
Nnew(ii,1)=a/Wnew(ii,1);
if Bnew(ii,1)~=0 % 如果B=0 sin(B)将等于0，分母不能为0，所以当B=0时要用4-35公式
H(ii,1)=Z(ii,1)/sind(Bnew(ii,1))-Nnew(ii,1)*(1-e2); %4-34
else
H(ii,1)=sqrt(X(ii,1)^2+Y(ii,1)^2)/cosd(Bnew(ii,1))-Nnew(ii,1);  %4-35
end
end
coordafter=[Bnew L H];
end
