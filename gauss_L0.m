function [L0,NN]=gauss_L0(L,belt)
% �ó������������˹ͶӰ�����������߾���L0�ʹ���NN
% L ��ؾ��ȣ�degree��
% belt ����6�Ȼ�3�ȣ�
% ����ʦ��ѧԺ �ߴ��� 2019.11
defval('L',114.5)
defval('belt',6)
aa = find(L<0);
L(aa) = L(aa)+360;

if belt==6
    NN=fix(L/6)+1;
    L0=NN*6-3;
elseif belt==3
    NN=round(L/3);
    L0=NN*3;
end
