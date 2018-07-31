%Name:		Chris Shoemaker
%Course:	EER-280 - Digital Watermarking
%Project: 	Calculates the PSNR (Peak Signal to Noise Ratio)
%            of images A and A', both of size MxN

function [A] = psnr(image,image_prime,M,N)

% convert to doubles
image=double(image);
image_prime=double(image_prime);

% avoid divide by zero nastiness

    mse=0;
    for i=1:M
        for j=1:N
            mse=mse+ ((image(i,j)-image_prime(i,j)).^2);
        end
    end
    mse=mse/(M*N);
    A=10*log10(double((1024.^2)/mse));


return

