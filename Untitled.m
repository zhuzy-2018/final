clear I BW
filename='test2.png';
filtername='Prewitt';
I=imread(filename);
% I=rgb2gray(I);
% I(:,:)=I1(:,:,1)+I1(:,:,2);
I=im2double(I(:,:,1));
BW=edge(I,filtername);
[H,T,R]=hough(BW,'RhoResolution',10,'ThetaResolution',10);
figure,
subplot(121),imshow(BW);title(filename);
subplot(122),imshow(imadjust(mat2gray(H)));title('对应的Hough变换');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal;
hold on;
colormap(gca,hot);

P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
%%
lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');