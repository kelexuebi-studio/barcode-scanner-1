function barcode=barcodeEAN13(C)
% clear
% C=[1 1 1 3 1 1 2 1 1 2 3 2 1 2 2 1 1 2 3 3 1 2 1 3 2, ...
%     1 1 1 1 1 1 1 3 2 1 1 2 2 2 1 2 2 2 1 1 1 3 2 1 1 3 2, ...
%     1 2 3 1 1 1 1];

% 0	0001101	0100111	1110010
% 1	0011001	0110011	1100110
% 2	0010011	0011011	1101100
% 3	0111101	0100001	1000010
% 4	0100011	0011101	1011100
% 5	0110001	0111001	1001110
% 6	0101111	0000101	1010000
% 7	0111011	0010001	1000100
% 8	0110111	0001001	1001000
% 9	0001011	0010111	1110100

L=[3 2 1 1;
    2 2 2 1;
    2 1 2 2;
    1 4 1 1;
    1 1 3 2;
    1 2 3 1;
    1 1 1 4;
    1 3 1 2;
    1 2 1 3;
    3 1 1 2];


G=[1 1 2 3;
    1 2 2 2;
    2 2 1 2;
    1 1 4 1;
    2 3 1 1;
    1 3 2 1;
    4 1 1 1;
    2 1 3 1;
    3 1 2 1;
    2 1 1 3];

R=[ 3 2 1 1;
    2 2 2 1;
    2 1 2 2;
    1 4 1 1;
    1 1 3 2;
    1 2 3 1;
    1 1 1 4;
    1 3 1 2;
    1 2 1 3;
    3 1 1 2];

N1=[ 0 0 0 0 0 0;
     0 0 1 0 1 1;
     0 0 1 1 0 1;
     0 0 1 1 1 0;
     0 1 0 0 1 1;
     0 1 1 0 0 1;
     0 1 1 1 0 0;
     0 1 0 1 0 1;
     0 1 0 1 1 0;
     0 1 1 0 1 0];

C1=C(4:27);
C2=C(33:56);

for i=1:6
    D1(i,1:4)=C1((i-1)*4+1:i*4);
    D2(i,1:4)=C2((i-1)*4+1:i*4);
end

d1=ones(1,6)*(-1);
for i=1:6
    for j=1:10
        if sum((R(j,:)-D2(i,:))~=0)==0
           d2(i)=j-1;
        end
    end
    for j=1:10
        if sum((L(j,:)-D1(i,:))~=0)==0
            d1(i)=j-1;
            loc(i)=0;
        end
    end
    for j=1:10
        if sum((G(j,:)-D1(i,:))~=0)==0
            d1(i)=j-1;
            loc(i)=1;
        end
    end
end
for i=1:10
    if sum((N1(i,:)-loc)~=0)==0
        d0=i-1;
    end
end

barcode=[d0 d1 d2];
wt(1:2:length(barcode)-1)=1;
wt(2:2:length(barcode)-1)=3;
chkDig=sum(barcode(1:end-1).*wt);
chkDig=ceil(chkDig/10)*10-chkDig;
if chkDig~=barcode(end)
    disp('error in barcode reading')
    barcode=NaN;
else
    disp(['barcode = ',num2str(barcode)])
end