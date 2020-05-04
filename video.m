function video()
global axes1handles axes3handles obj nFrames rob;
global edit7 edit8 edit9 edit10 edit11 edit12; 
global nowFrames;
axes(axes1handles);
data=read(obj,nowFrames);
% subplot(4,2,1);
% imshow(data);
% subplot(4,2,2);
% imshow(data(:,:,1));
% subplot(4,2,3);
% imshow(rgb2gray(data));
diff_im = imsubtract(data(:,:,1), rgb2gray(data));
% subplot(4,2,4);
% imshow(diff_im);
diff_im = medfilt2(diff_im, [3 3]);%中值滤波
% subplot(4,2,5);
% imshow(diff_im);
diff_im = imbinarize(diff_im,0.5);  %转换为二值图像
% subplot(4,2,6);
% imshow(diff_im);
diff_im = bwareaopen(diff_im,50);%从二值图像中删除小对象 像素小于300
% subplot(4,2,7);
% imshow(diff_im);
bw = bwlabel(diff_im, 8); %对8连通分量标注
% subplot(4,2,8);
% imshow(bw);
stats = regionprops(logical(bw), 'BoundingBox', 'Centroid');
axes(axes1handles);
imshow(data)
    for object = 1:length(stats)
%       axes(axes1handles);
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        rectangle('Position',bb,'EdgeColor','b','LineWidth',2);
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        Px=bc(1);
        Py=bc(2);
        Pz=0;
        a2 = 650;
        a3 = 0;
        d3 = 190;
        d4 = 600;
         K = (Px^2+Py^2+Pz^2-a2^2-a3^2-d3^2-d4^2)/(2*a2);
        theta1 = (atan2(Py,Px)-atan2(d3,sqrt(Px^2+Py^2-d3^2)));
                c1 = cos(theta1);
                s1 = sin(theta1);
                theta3 = (atan2(a3,d4)-atan2(real(K),real(sqrt(a3^2+d4^2-K^2))));
                c3 = cos(theta3);
                s3 = sin(theta3);
                t23 = atan2((-a3-a2*c3)*Pz-(c1*Px+s1*Py)*(d4-a2*s3),(a2*s3-d4)*Pz+(a3+a2*c3)*(c1*Px+s1*Py));
                theta2 = (t23 - theta3);
                c2 = cos(theta2);
                s2 = sin(theta2);
                s23 = ((-a3-a2*c3)*Pz+(c1*Px+s1*Py)*(a2*s3-d4))/(Pz^2+(c1*Px+s1*Py)^2);
                c23 = ((a2*s3-d4)*Pz+(a3+a2*c3)*(c1*Px+s1*Py))/(Pz^2+(c1*Px+s1*Py)^2);
                theta4 = atan2(s1+c1,c1*c23-s1*c23 + s23);
                c4 = cos(theta4);
                s4 = sin (theta4);
                s5 = -((c1*c23*c4+s1*s4)+(s1*c23*c4-c1*s4)-(s23*c4));
                c5 = (-c1*s23)+(-s1*s23)+(-c23);
                theta5 = atan2(s5,c5);
                s6 = (c1*c23*s4-s1*c4)-(s1*c23*s4+c1*c4)+(s23*s4);
                c6 = ((c1*c23*c4+s1*s4)*c5-c1*s23*s5)+((s1*c23*c4-c1*s4)*c5-s1*s23*s5)-(s23*c4*c5+c23*s5);
                theta6 = atan2(s6,c6);
        q=[theta1 theta2 theta3 theta4 theta5 theta6];
        set(edit7,'string',num2str(q(1)/pi*180));
        set(edit8,'string',num2str(q(2)/pi*180));
        set(edit9,'string',num2str(q(3)/pi*180));
        set(edit10,'string',num2str(q(4)/pi*180));
        set(edit11,'string',num2str(q(5)/pi*180));
        set(edit12,'string',num2str(q(6)/pi*180));
        axes(axes3handles);
        rob.plot(q);
    end
    pause(0.05);
nowFrames=nowFrames+1;
if nowFrames==nFrames
    nowFrames=1;
end



