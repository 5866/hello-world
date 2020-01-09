function [L0,NN]=gauss_L0(L,belt)
% 该程序用来计算高斯投影的中央子午线经度L0和带号NN
% L 大地经度（degree）
% belt 带宽（6度或3度）
% 南阳师范学院 高春春 2019.11
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
