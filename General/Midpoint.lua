local screen = platform.window 
local h=screen:height() 
local w=screen:width() 
local X1 = 0
local Y1 = 0
local X2 = 0
local Y2 = 0
local Number1 = 0
local Number2 = 0
local counter = 0
local answer = "" 
local myTable = {"Midpoint calculator","("..X1..","..Y1.."),("..X2..","..Y2..")", answer, "Type in the value of X1"} 
local linecount = #table 
local fontSize = 10 

function on.resize() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    answer = "" 
    myTable = {"Midpoint calculator","("..X1..","..Y1.."),("..X2..","..Y2..")", answer, myTable[4]} 
    screen:invalidate() 
end 

function on.reset() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    X1 = 0
    Y1 = 0
    X2 = 0
    Y2 = 0
    Number1 = 0
    Number2 = 0
    counter = 0
    answer = "" 
    myTable = {"Midpoint calculator","("..X1..","..Y1.."),("..X2..","..Y2..")", answer, "Type in the value of X1"} 
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
        X1 = answer
        myTable[4] = "Type in the value of Y1" 
        on.resize() 
    else if counter == 1 then 
        counter = counter + 1
        Y1 = answer
        myTable[4] = "Type in the value of X2" 
        on.resize() 
    else if counter == 2 then 
        counter = counter + 1
        X2 = answer
        myTable[4] = "Type in the value of Y2" 
        on.resize()
    else if counter == 3 then 
        counter = counter + 1
        Y2 = answer
        Number1 = (X1+X2)/2
        Number2 = (Y1+Y2)/2
        myTable[4] = "The midpoint is (" ..  Number1 .. "," .. Number2 .. ")." 
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