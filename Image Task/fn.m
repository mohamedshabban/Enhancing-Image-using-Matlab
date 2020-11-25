function Modified= fn(img)
figure,imshow(img),title('original');
R=fftshift(fft2(double(img(:,:,1))));
G=fftshift(fft2(double(img(:,:,2))));
B=fftshift(fft2(double(img(:,:,3))));

Modified=img;

[w,h]=size(G);

%Center Point
u = w/2+1;
v = h/2+1;

%Matrix  3*3 for pixel in Red Channel
r=R(u,v)./R(u-1:u+1,v-1:v+1);


%Matrix  3*3 for pixel in Red Channel
g=G(u,v)./G(u-1:u+1,v-1:v+1);


%Matrix  3*3 for pixel in Red Channel
b=B(u,v)./B(u-1:u+1,v-1:v+1);



%Median for Red Channel
r=median(abs(reshape(r,1,[])));



%Median for Red Channel
g=median(abs(reshape(g,1,[])));



%Median for Red Channel
b=median(abs(reshape(b,1,[])));


%Comparing Median between Center and every pixel for first half of image

for i=2:w-1
    
    for j=2:v
        
        Red_Channel=R(i,j)./R(i-1:i+1,j-1:j+1);
        
        
        Red_Channel=median(abs(reshape(Red_Channel,1,[])));
        
        if Red_Channel>2*r && (i~=u||j~=v)
            R(i-1:i+1,j-1:j+1)=0;
            
            R(i+w-2*i+2-1:i+w-2*i+2+1,j+h-2*j+2-1:j+h-2*j+2+1)=0;
        end
        
        GreenChannel=G(i,j)./G(i-1:i+1,j-1:j+1);
        
        
        GreenChannel=median(abs(reshape(GreenChannel,1,[])));
        
        if GreenChannel>2*g && (i~=u||j~=v)
            G(i-1:i+1,j-1:j+1)=0;
            G(i+w-2*i+2-1:i+w-2*i+2+1,j+h-2*j+2-1:j+h-2*j+2+1)=0;
        end
        
        
        BlueChannel=B(i,j)./B(i-1:i+1,j-1:j+1);
        
        
        BlueChannel=median(abs(reshape(BlueChannel,1,[])));
        
        if BlueChannel>2*b && (i~=u||j~=v)
            
            
            B(i-1:i+1,j-1:j+1)=0;
            B(i+w-2*i+2-1:i+w-2*i+2+1,j+h-2*j+2-1:j+h-2*j+2+1)=0;
        end
    end
end


Modified(:,:,1) = uint8((ifft2(ifftshift(R))));

Modified(:,:,2) = uint8((ifft2(ifftshift(G))));

Modified(:,:,3) = uint8((ifft2(ifftshift(B))));

figure,imshow(Modified),title('Modified');

end

