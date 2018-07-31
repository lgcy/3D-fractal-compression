function DD = affchange(DD,i,j,z,cund22)
       %第一种变化，相当与原图形没有变
        DD(i,j,z,1,1:64)=reshape(cund22,[1,64]);%将cund2按列重新排列成一行
        %第二种变换，相当于矩阵左右翻转
        cund4=fliplr(cund22);%将cund2矩阵左右翻转，相当于矩阵水平中线反射，fliplr(A)与flip(A,2)
        DD(i,j,z,2,1:64)=reshape(cund4,[1,64]);
        %第三种变换将cund2矩阵上下翻转
        cund4=flipud(cund22);%将cund2矩阵上下翻转，相当于矩阵垂直中线反射，flipud(A)与flip(A,1)
        DD(i,j,z,3,1:64)=reshape(cund4,[1,64]);
        %第四变换，将其前后翻转；
        cund4=flip(cund22,3);
        DD(i,j,z,4,1:64)=reshape(cund4,[1,64]);
        %第五种变换旋转90度
        cund4=rot90_3D(cund22,3,1);%xy平面旋转90度 
        DD(i,j,z,5,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(cund22,2,1);%xz平面旋转90度 
        DD(i,j,z,6,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(cund22,1,3);%yz平面旋转90度 
        DD(i,j,z,7,1:64)=reshape(cund4,[1,64]);
        %第6种变换旋转180度
        cund4=rot90_3D(cund22,3,2);%xy平面旋转180度 
        DD(i,j,z,8,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(cund22,2,2);%xz平面旋转180度 
        DD(i,j,z,9,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(cund22,1,2);%yz平面旋转180度 
        DD(i,j,z,10,1:64)=reshape(cund4,[1,64]);
        %第7种变换旋转270度
        cund4=rot90_3D(cund22,3,3);%xy平面旋转270度 
        DD(i,j,z,11,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(cund22,2,3);%xz平面旋转270度 
        DD(i,j,z,12,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(cund22,1,1);%yz平面旋转270度 
        DD(i,j,z,13,1:64)=reshape(cund4,[1,64]);
        %第8种变换矩阵相对45度反射
        cund4=permute(cund22, [2, 1, 3]);%xy面做反射变换
        DD(i,j,z,14,1:64)=reshape(cund4,[1,64]);
        
        cund4=permute(cund22, [3, 2, 1]);%xz面做反射变换
        DD(i,j,z,15,1:64)=reshape(cund4,[1,64]);
        
        cund4=permute(cund22, [1, 3, 2]);%yz面做反射变换
        DD(i,j,z,16,1:64)=reshape(cund4,[1,64]);
        %第9种变换，矩阵相对135度反射
        cund4=rot90_3D(flipud(cund22),3,1);%xy面矩阵相对135度反射
        DD(i,j,z,17,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(flipud(cund22),2,1);%xz面矩阵相对135度反射
        DD(i,j,z,18,1:64)=reshape(cund4,[1,64]);
        
        cund4=rot90_3D(flip(cund22,3),1,3);%yz面矩阵相对135度反射
        DD(i,j,z,19,1:64)=reshape(cund4,[1,64]);