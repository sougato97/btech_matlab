clc;
close all;
clear;
%%%%%%%%%%%%%%%%%%%%%%% Reading a Secret Text File %%%%%%%%%%%%%%%%%%%%%%%%
file_id = fopen('message.txt','r');
file_content = fread(file_id);
file_length = length(file_content);
in = [];
in = [in dec2bin(file_length,20)]; %character to binary conversion 
for i=1:file_length  
      in=[in dec2bin(file_content(i),7)];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Reading Cover Image %%%%%%%%%%%%%%%%%%%%%%%%%%%
cover_image = imread('goodnight.gif','frames','all'); %get cover image                            %%%%%%%%%%%%%%%%%%%%55 edited %%%%%%%%%%%%%%%
red = cover_image(:,:,1); %seperating rgb values 
blue = cover_image(:,:,2);
green = cover_image(:,:,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Embedding Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
color = red; %red color selected for embedding
[r,c] = size(color);
final = double(color); 
next=0;
capacity=0; %total no of bits that can be embedded
for x=0:1:r-1 
      for y=0:2:c-1
          enable = 1; %enable=0 when new pixels may fall off the boundary
          p = color(1+x,1+y:2+y); %block of two pixels, pi & pi+1
          p = double(p);
          d = p(1,2) - p(1,1); %d = difference between 2 pixel
          d_abs = abs(d); %absolute difference
          lb=[0 8 16 32 64 128]; %lowerbound
          ub=[7 15 31 63 127 255]; %upperbound
          for i=1:1:6 %test the R boundary
              if((d_abs >= lb(i)) && (d_abs <= ub(i))) %selecting range
                  %check if any pixel in a block fall off the boundary [0,255]
                  even2 = mod(d,2); 
                  m2 = ub(i) - d;
                  if (even2 == 0)
                      Pcheck=[p(1,1)-floor(m2/2) p(1,2)+ceil(m2/2)];
                  else
                      Pcheck=[p(1,1)-ceil(m2/2) p(1,2)+floor(m2/2)];
                  end
                  if(Pcheck(1)<0 || Pcheck(2)<0 || Pcheck(1)>255 || Pcheck(2)>255)
                      enable = 0;
                      break
                  end
                  n = ub(i)-lb(i)+1; %quantization width of range
                  t = floor(log2(n)); %maximum bit can be embedded in 2 pixels
                  capacity=capacity+t; %max capacity of the cover image 
                  %check if next exceeds the length of message
                  if(next>length(in)) 
                      m=0;
                  %check if next+t exceeds the length of message
                  elseif(next+t>length(in)) 
                      if(1+next>=length(in))
                          k=zeros(1,t);
                      else
                          k=in(1+next:length(in));
                      end
                      diff =next+t-length(in);
                      k1=zeros(1,t);
                      if(diff>0)
                          for j=1:next+t-length(in)
                              k1(j)=k(j);
                          end
                      end
                      k=k1;
                      next=next+t;
                      k=bin2dec(char(k));
                      if(1+next>length(in))
                          m=0;
                      else
                          if(d >= 0)
                              dnew = k + lb(i);
                          else
                              dnew = -(k + lb(i));
                          end
                          m = dnew - d;
                      end
                  %if next is less than the length of message
                  else 
                      k=in(1+next:t+next);
                      next=next+t;
                      k=bin2dec(char(k));
                      if(d >= 0)
                          dnew = k + lb(i);
                      else
                          dnew = -(k + lb(i));
                      end
                      m = dnew - d;
                  end
              end
          end
          if (enable == 1)
              even = mod(d,2);
              if (even == 0)
                  P0=[p(1,1)-floor(m/2) p(1,2)+ceil(m/2)];
              else
                  P0=[p(1,1)-ceil(m/2) p(1,2)+floor(m/2)];
              end
              final(1+x,1+y)=P0(1,1);
              final(1+x,2+y)=P0(1,2);
          end
      end
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% Creating Stego-Image %%%%%%%%%%%%%%%%%%%%%%%%%%
if(next>length(in))
      disp('Message Embedded Successfully');
      final = uint8(final);
      stego_image = cat(3,final,blue,green);
      imwrite(stego_image,'stego_image.bmp');
      fclose('all');
  else %check if the cover is samll for the given messege to be embedded
      error('Cover Image is too small for the given messege to be embedded, please replace cover image with the larger one.');
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%