local screen = platform.window 
local h=screen:height() 
local w=screen:width() 
local Y_Int_1 = 0
local Y_Int_2 = 0
local Slope_1 = 0
local Slope_2 = 0
local Intersection_X = 0
local Intersection_Y = 0
local counter = 0
local answer = "" 
local myTable = {"Intersection calculator","           ", answer, "Type in the slope of the first line"} 
local linecount = #table 
local fontSize = 10 

function on.resize() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    answer = "" 
    myTable = {"Intersection calculator","                  ", answer, myTable[4]} 
    screen:invalidate() 
end 

function on.reset() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    Y_Int_1 = 0
    Y_Int_2 = 0
    Slope_1 = 0
    Slope_2 = 0
    Intersection_X = 0
    Intersection_Y = 0
    counter = 0
    answer = "" 
    myTable = {"Intersection calculator","           ", answer, "Type in the slope of the first line"}
    screen:invalidate() 
end 

function on.charIn(char) 
      answer = answer..char 
      myTable[3] = answer 
    -- Refresh the screen after each key is pressed. 
      screen:invalidate() 
end 

function on.backspaceKey() 
      answer = string.usub(answer,0,-2) 
      myTable[3] = answer 
      screen:invalidate() 
end 

function on.escapeKey() 
    on.reset() 
    screen:invalidate() 
end 

function on.enterKey() 
    if answer == "" then 
        on.resize() 
    else if counter == 0 then 
        counter = counter + 1
        Slope_1 = answer
        myTable[4] = "Type in the Y-intercept of the first line" 
        on.resize() 
    else if counter == 1 then 
        counter = counter + 1
        Y_Int_1 = answer
        myTable[4] = "Type in the slope of the second line" 
        on.resize() 
    else if counter == 2 then 
        counter = counter + 1
        Slope_2 = answer
        myTable[4] = "Type in the Y-intercept of the second line" 
        on.resize()
    else if counter == 3 then 
        counter = counter + 1
        Y_Int_2 = answer
	    Intersection_X=(Y_Int_2 - Y_Int_1)/(Slope_1 - Slope_2)
        Intersection_Y=Slope_1 * Intersection_X + Y_Int_1
        myTable[4] = "The intersection is ("..Intersection_X..","..Intersection_Y..")"
        
        if Slope_1 == Slope_2 then 
            if Y_Int_1 == Y_Int_2 then 
                myTable[4] = "The lines are the same."
            else myTable[4] = "The lines do not intersect."
        end end   
        on.resize()
    end 
    end
    end
    end
    end
   screen:invalidate()    
end 

function on.paint(gc) 
      h=screen:height() 
      w=screen:width() 

    local linecount = #myTable 
    for k = 1, linecount do 
    if k == 1 then 
     gc:setFont("sansserif", "b", fontSize) 
        gc:setColorRGB(20, 20, 138) 
    elseif k == 2 then 
     gc:setFont("sansserif", "b", fontSize) 
        gc:setColorRGB(158, 5, 8) 
    else 
     gc:setFont("sansserif", "b", fontSize) 
        gc:setColorRGB(158, 5, 8) 
    end 
        strwidth = gc:getStringWidth(myTable[k]) 
        strheight = gc:getStringHeight(myTable[k]) 
        gc:drawString(myTable[k], w/2 - strwidth/2 ,h*(k)/(linecount+1) + strheight/2) 
    end 

     local ht = 0.1*h 
    
     gc:setColorRGB(20, 20, 138) 
     gc:setPen("medium", "smooth") 
     gc:drawPolyLine({
        0.2*w, h*(linecount-1)/(linecount + 0.3) - ht, 
        0.8*w, h*(linecount-1)/(linecount + 0.3) - ht, 
        0.8*w, h*(linecount-1)/(linecount + 0.3) + ht, 
        0.2*w, h*(linecount-1)/(linecount + 0.3) + ht, 
        0.2*w, h*(linecount-1)/(linecount + 0.3) - ht }) 
end