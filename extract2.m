%%%%%%%%%%%%%%%%%%%%%%%%%%% Reading Stego Image %%%%%%%%%%%%%%%%%%%%%%%%%%%
stego_image = imread('stego_image.jpg');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Extracting Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%
color = stego_image(:,:,1); %red color selected where data is embedded
[r,c]=size(color);
j=0;
msg = [];
flag = 0;
length=0;
enable = 1;
for x=0:1:r-1
      for y=0:2:c-1
          if (enable == 1) %enable=0 when any pixels may fall off the boundary
              gp = color(1+x,1+y:2+y); %block of 2 pixels, pi & pi+1
              gp = double(gp);
              d  = gp(1,2) - gp(1,1); %d = difference between 2 pixel
              nd = abs(d); %absolute difference
              lb = [0 8 16 32 64 128]; %lowerbound
              ub = [7 15 31 63 127 255]; %upperbound
              for i=1:1:6 %test the R boundary
                  if(nd>=lb(i)&&nd<=ub(i))
                      %check if any pixel in a block fall off the boundary [0,255]
                      even2 = mod(d,2); 
                      m2 = ub(i) - d;
                      if (even2 == 0)
                          Pcheck=[gp(1,1)-floor(m2/2) gp(1,2)+ceil(m2/2)];
                      else
                          Pcheck=[gp(1,1)-ceil(m2/2) gp(1,2)+floor(m2/2)];
                      end
                      if(Pcheck(1)<0 || Pcheck(2)<0 || Pcheck(1)>255 || Pcheck(2)>255)
                          break
                      end
                      w = ub(i)-lb(i)+1; %quantization width of range
                      t=log2(w); %maximum bit can be embedded between 2 pixel
                      b = nd - lb(i);
                      k=dec2bin(b,t);
                      msg = [msg k];
                      j=j+t;
                      if(flag==0 && j>=20)
                          length=bin2dec(msg(1:20))+3; %possible 3 char error
                          length=length*7;
                          flag=1;
                      end
                      if(flag==1 && j>=length)
                          j=1;
                          for i=20:7:length-7
                              finaltxt(j)=bin2dec(msg(1+i:7+i));
                              j=j+1;
                          end
                          fid=fopen('output.txt','w');
                          fwrite(fid,finaltxt);
                          disp('Message Extracted Successfully');
                          fclose('all');
                          enable = 0;
                      end
                  end
              end
          end
      end
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%