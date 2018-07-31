%恢复原图像
RRR=R;
nrx=xx/4;
nry=yy/4;
nrz=zz/4;
% RRR=zeros(nry,nrx,nrz,6);
% for i=1:nry
%     for j=1:nrx
%         RRR(i,j,1)=view(i,j,1);
%         RRR(i,j,2)=view(i,j,2);
%         RRR(i,j,3)=view(i,j,3);
%         RRR(i,j,4)=view(i,j+nrx,1);
%         RRR(i,j,5)=view(i,j+nrx,2);
%         RRR(i,j,6)=view(i,j+nrx,3);
%     end;
% end;
huifu=ones(yy,xx,zz);    
a=50;
for iter=1:a
for f =1:nrz
for i=1:nry
    for j=1:nrx
        st=RRR(i,j,f,1);
        ot=RRR(i,j,f,2);
        dy=RRR(i,j,f,3);
        dx=RRR(i,j,f,4);
%          dy=xy(i,j,1);
%          dx=xy(i,j,2);
        dz=RRR(i,j,f,6);
        ut=RRR(i,j,f,5);
        cund1=huifu(1+4*(dy-1):8+4*(dy-1),1+4*(dx-1):8+4*(dx-1),1+4*(dz-1):8+4*(dz-1));
       % cund1=im(1+4*(i-1):8+4*(i-1),1+4*(j-1):8+4*(j-1),1+4*(z-1):8+4*(z-1));
        if f ==2
           jishu = i;
        end
        for l=1:4
            for m=1:4
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
        switch ut         %8种变换
        case 1 
                cund4=cund22;
        %第二种变换，相当于矩阵左右翻转
        case 2
                cund4=fliplr(cund22);%将cund2矩阵左右翻转，相当于矩阵水平中线反射，fliplr(A)与flip(A,2)
        case 3 
        %第三种变换将cund2矩阵上下翻转
                cund4=flipud(cund22);%将cund2矩阵上下翻转，相当于矩阵垂直中线反射，flipud(A)与flip(A,1)
                case 4
        %第四变换，将其前后翻转；
        cund4=flip(cund22,3);
        case 5
        %第五种变换旋转90度
        cund4=rot90_3D(cund22,3,1);%xy平面旋转90度 

        case 6
        cund4=rot90_3D(cund22,2,1);%xz平面旋转90度 

        case 7
        cund4=rot90_3D(cund22,1,3);%yz平面旋转90度 
        case 8
        %第6种变换旋转180度
        cund4=rot90_3D(cund22,3,2);%xy平面旋转180度 

        case 9
        cund4=rot90_3D(cund22,2,2);%xz平面旋转180度 

        case 10
        cund4=rot90_3D(cund22,1,2);%yz平面旋转180度 
        case 11
        %第7种变换旋转270度
        cund4=rot90_3D(cund22,3,3);%xy平面旋转270度 

        case 12
        cund4=rot90_3D(cund22,2,3);%xz平面旋转270度 

        case 13
        cund4=rot90_3D(cund22,1,1);%yz平面旋转270度 
        case 14
        %第8种变换矩阵相对45度反射
        cund4=permute(cund22, [2, 1, 3]);%xy面做反射变换

        case 15
        cund4=permute(cund22, [3, 2, 1]);%xz面做反射变换

        case 16
        cund4=permute(cund22, [1, 3, 2]);%yz面做反射变换
        case 17
        %第9种变换，矩阵相对135度反射
        cund4=rot90_3D(flipud(cund22),3,1);%xy面矩阵相对135度反射
    
        case 18
        cund4=rot90_3D(flipud(cund22),2,1);%xz面矩阵相对135度反射
  
        case 19
        cund4=rot90_3D(flip(cund22,3),1,3);%yz面矩阵相对135度反射;
        end;
        huifu(1+4*(i-1):4+4*(i-1),1+4*(j-1):4+4*(j-1),1+4*(f-1):4*(f-1)+4)=st*cund4+ot;
    end;
   
end;
end

end;
psnr1=psnr(im(:,:,7),huifu(:,:,7),yy,xx)