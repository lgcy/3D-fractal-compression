clear;clc
tic
load('im_b.mat')
%load('E:\DD\DD1.mat')%载入压缩的序列图像
size1=size(im);
xx=size1(2);%图像横轴像素列数
yy=size1(1);%图像纵轴像素行数
zz=size1(3);
nrx=xx/4;%将原始图像划分成8*8的像素矩阵
nry=yy/4;%将原始图像划分成8*8的像素矩阵
nrz=zz/4;
ndx=(xx-8)/4+1;%将定义域划分成16*16的像素矩阵,步长为1
ndy=(yy-8)/4+1;%将定义域划分成16*16的像素矩阵，步长为1
ndz=(zz-8)/4+1;
DD=zeros(ndy,ndx,ndz,19,64);%用于存在定义域压缩后8*8矩阵的8种对应的变换形式
cund1=zeros(8,8,8);%用于存放16*16的定义域像素块
cund2=zeros(4,4,4);%用于存放有16*16的定义域像素块压缩后形成的8*8像素块
cund3=zeros(1,64);
cund33=zeros(1,64);
cund4=zeros(4,4,4);


RRR=zeros(nry,nrx,nrz,6); 
error=zeros(nry,nrx,nrz,1);%划分块
cunr=zeros(1,64);

for z =1:ndz
  for i=1:ndy
    for j=1:ndx
        cund1=im(1+4*(i-1):8+4*(i-1),1+4*(j-1):8+4*(j-1),1+4*(z-1):8+4*(z-1));%取定义域图像（原始图像）中16*16的像素矩阵
        for l=1:4
            for m=1:4
                %求定义域像素每临近四个像素点的平均值，借以将16*16的定义域块转换成8*8的块
                 cund2(l,m,1)=(cund1(1+2*(l-1),1+2*(m-1),1)+cund1(2+2*(l-1),2+2*(m-1),1)+cund1(2+2*(l-1),1+2*(m-1),1)+cund1(1+2*(l-1),2+2*(m-1),1))/4;
                 cund2(l,m,2)=(cund1(1+2*(l-1),1+2*(m-1),2)+cund1(2+2*(l-1),2+2*(m-1),2)+cund1(2+2*(l-1),1+2*(m-1),2)+cund1(1+2*(l-1),2+2*(m-1),2))/4;
                 cund2(l,m,3)=(cund1(1+2*(l-1),1+2*(m-1),3)+cund1(2+2*(l-1),2+2*(m-1),3)+cund1(2+2*(l-1),1+2*(m-1),3)+cund1(1+2*(l-1),2+2*(m-1),3))/4;
                 cund2(l,m,4)=(cund1(1+2*(l-1),1+2*(m-1),4)+cund1(2+2*(l-1),2+2*(m-1),4)+cund1(2+2*(l-1),1+2*(m-1),4)+cund1(1+2*(l-1),2+2*(m-1),4))/4;
                 cund2(l,m,5)=(cund1(1+2*(l-1),1+2*(m-1),5)+cund1(2+2*(l-1),2+2*(m-1),5)+cund1(2+2*(l-1),1+2*(m-1),5)+cund1(1+2*(l-1),2+2*(m-1),5))/4;
                 cund2(l,m,6)=(cund1(1+2*(l-1),1+2*(m-1),6)+cund1(2+2*(l-1),2+2*(m-1),6)+cund1(2+2*(l-1),1+2*(m-1),6)+cund1(1+2*(l-1),2+2*(m-1),6))/4;
                 cund2(l,m,7)=(cund1(1+2*(l-1),1+2*(m-1),7)+cund1(2+2*(l-1),2+2*(m-1),7)+cund1(2+2*(l-1),1+2*(m-1),7)+cund1(1+2*(l-1),2+2*(m-1),7))/4;
                 cund2(l,m,8)=(cund1(1+2*(l-1),1+2*(m-1),8)+cund1(2+2*(l-1),2+2*(m-1),8)+cund1(2+2*(l-1),1+2*(m-1),8)+cund1(1+2*(l-1),2+2*(m-1),8))/4;
            end;
        end;
        cund22(:,:,1) = (cund2(:,:,1)+cund2(:,:,2))/2;
        cund22(:,:,2) = (cund2(:,:,3)+cund2(:,:,4))/2;
        cund22(:,:,3) = (cund2(:,:,5)+cund2(:,:,6))/2;
        cund22(:,:,4) = (cund2(:,:,7)+cund2(:,:,8))/2;
        %以上将8*8*4的矩形块转换成4*4*2的矩形块
        %进行19种变换
        DD = affchange(DD,i,j,z,cund22);
    end;
  end;
end

% 以上工作生成 码本
tic
for f = 1:nrz
  for i=1:nry%这两个循环（i和j）保证了对于每个值域块都找到了相应的定义域块，并且求出了该定义域块
    for j=1:nrx%得一系列变换过程
        %将值域块8*8的像素值重新排列成一列，放到cunr
        cunr=reshape(im(1+4*(i-1):4+4*(i-1),1+4*(j-1):4+4*(j-1),1+4*(f-1):4*(f-1)+4),[1,64]);
        sumalpha=sum(cunr);   %cunr  is ri（值域块的值）
        sumalpha2=norm(cunr)^2;%cunr中各个数值的平方（即向量2范数的平方），相当于求值域块矩阵每个元素的平方再求和
        dx=1;%这几个变量就是分形编码的数据量，他们的初值可以随意定。记录l的值
        dy=1;%记录k的值
        dz=1;
        ut=1;%记录m的值
        minH=10^20;%记录最小的均方根误差R值
        minot=0;%参数minot记录下与当前值域块能够最佳匹配的定义域块下变换所需的亮度调节    o
        minst=0;%参数minst记录下与当前值域块能够最佳匹配的定义域块下变换所需的对比度调节   s
      for z=1:ndz  
        for k=1:ndy%参数k与l记录下与当前值域块能够最佳匹配的定义域块的序号
            for l=1:ndx%
                for m=1:19%参数m记录下与当前值域块能够最佳匹配的定义域块得19种基本变形的序号
                    cund3(1:64)=DD(k,l,z,m,1:64);
                    sumbeta=sum(cund3);  % cund3 is di（定义域块的值）
                    sumbeta2=norm(cund3)^2;%求出向量的2范数，相当于定义域块矩阵的每个元素的平方再求和
                    alphabeta=cunr*cund3';
                     if (64*sumbeta2-sumbeta^2)~=0
                        st=(64*alphabeta-sumalpha*sumbeta)/(64*sumbeta2-sumbeta^2);%st即是对比度调节系数s
                     end;
                     if (64*sumbeta2-sumbeta^2)==0||st > 1 || st < -1
                             st=0;
                     end;
                    ot=(sumalpha-st*sumbeta)/64;%ot即使亮度调节系数
                    H=(sumalpha2+st*(st*sumbeta2-2*alphabeta+2*ot*sumbeta)+ot*(64*ot-2*sumalpha))/64;%在当前s与o的条件下的R
                    if H<minH    %寻求定义域块与值域块的最佳匹配，并记录下最佳匹配的参数值
                        dx=l;
                        dy=k;
                        dz=z;
                        ut=m;
                        minot=ot;
                        minst=st;
                        minH=H;
                        cund33=cund3;
                    end;
                end;
            end;
        end;
      end
        RRR(i,j,f,1)=minst;
        RRR(i,j,f,2)=minot;
        RRR(i,j,f,3)=dy;
        RRR(i,j,f,4)=dx;
        RRR(i,j,f,5)=ut;
        RRR(i,j,f,6)=dz;
        error(i,j,f,1) = minH;
    end;
  end
end;
%save(currentFileDD,'RRR')
toc