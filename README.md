# 3D-fractal-compression
The code is used to compress three-dimensional image which is an extension of two-dimensional fractal compression
本程序是程序根据2维分形图像压缩所扩展的三维分形压缩，可以用于医学图像的压缩，如三维脑部CT图像，与二维不同个是，八种变换在三维中变成了19中变换
# 使用说明
## 1.前提
本程序是基于Matlab的
## 2.介绍
* `compression3d`：进行图像压缩时的主要程序  
* `decompression`：用于解压缩，得到解压后的图像
* `affchange`：图像压缩时所用到的19种仿射变换
* `im_b`：所用的三维图片
* `R`：压缩后的文件
## 3.例子
![压缩前原始图片](https://github.com/lgcy/3D-fractal-compression/blob/master/ori.jpg)
![解压缩后的图片](https://github.com/lgcy/3D-fractal-compression/blob/master/decom.jpg)
