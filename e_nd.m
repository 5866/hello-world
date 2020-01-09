function [B,L,x,y] = e_nd(ellname,x,y,L0,L0_,k)
%END ���� 194ҳ
%   k: 3 3�ȴ�
 %     6 6�ȴ� 

defval('k',3)
defval('ellname','kra')
defval('x',1944359.6070)
defval('y',240455.4563)
defval('L0',117) %�ɴ�
defval('L0_',120) %�´�

defval('outputformat','dms')

[B,L]=gauss_xy2bl(ellname,x,y,L0,outputformat)
B1 = dms2deg(B);
L1 = dms2deg(L);

[x,y]=gauss_bl2xy(ellname,B1,L1,L0_)

end

