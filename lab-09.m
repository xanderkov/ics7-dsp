function lab_09()
    pkg load image;
    I=double(imread('bimage6.bmp')) / 255;

    hold on;
    figure(1);
    imshow(I);
    title('Source image');
    print -djpg res1.jpg
    hold off;
    PSF=fspecial('motion', 9, -5);
    estimated_nsr = 0.0005 / var(I(:));
    J1=deconvwnr(I, PSF, estimated_nsr);
    hold on;
    figure(2);
    imshow(J1);
    title('Recovered image');
    print -djpg res2.jpg
    hold off;
end

lab_09()
