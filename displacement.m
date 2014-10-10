function [output] = displacement(img1, img2)
    count = 0;
    for x = -15:15
        for y = -15:15
        count = count+1;
        img1Shift = circshift(img1, [x y]); %%the whole img1 matrix has been displaced by x and y.
        ssd = sum(sum((img2-img1Shift).^2));          %% find the corresponding value of ssd for this displacement of img1 matrix.
        
            if count == 1;
            min = ssd;
            output = [x y];
            end
            if count > 1    
            if ssd < min
               min = ssd ;
               output = [x y];
            end
            end
         end
    end
end
  
