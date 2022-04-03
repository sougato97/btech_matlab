
    [A,map] =  imread('g.gif','frames','all'); %for reading gif file
    
    mov=immovie(A,map);  %for making movie

    implay(mov)  %for displaying the movie

