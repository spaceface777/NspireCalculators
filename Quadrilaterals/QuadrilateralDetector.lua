local screen = platform.window 
local h=screen:height() 
local w=screen:width() 
local AX = 0
local AY = 0
local BX = 0
local BY = 0
local CX = 0
local CY = 0
local DX = 0
local DY = 0
local Dist1 = 0
local Dist2 = 0
local Slope1 = 0
local Slope2 = 0
local counter = 0
local answer = "" 
local myTable = {"Quadrilateral detector","("..AX..","..AY.."),("..BX..","..BY.."),("..CX..","..CY.."),("..DX..","..DY..")", answer, "Type in the value of AX"} 
local linecount = #table 
local fontSize = 20

function on.resize() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    answer = "" 
    myTable = {"Quadrilateral detector","("..AX..","..AY.."),("..BX..","..BY.."),("..CX..","..CY.."),("..DX..","..DY..")", answer, myTable[4]} 
    screen:invalidate() 
end 

function on.reset() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    AX = 0
    AY = 0
    BX = 0
    BY = 0
    CX = 0
    CY = 0
    DX = 0
    DY = 0
    Dist1 = 0
    Dist2 = 0
    Slope1 = 0
    Slope2 = 0
    counter = 0
    answer = "" 
    myTable = {"Quadrilateral detector","("..AX..","..AY.."),("..BX..","..BY.."),("..CX..","..CY.."),("..DX..","..DY..")", answer, "Type in the value of AX"} 
    screen:invalidate() 
end 

function on.charIn(char) 
      answer = answer..char 
      myTable[3] = answer 
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
        AX = answer
        myTable[4] = "Type in the value of AY" 
        on.resize() 
    else if counter == 1 then 
        counter = counter + 1
        AY = answer
        myTable[4] = "Type in the value of BX" 
        on.resize() 
    else if counter == 2 then 
        counter = counter + 1
        BX = answer
        myTable[4] = "Type in the value of BY" 
        on.resize()
    else if counter == 3 then 
        counter = counter + 1
        BY = answer
        myTable[4] = "Type in the value of CX" 
        on.resize() 
    else if counter == 4 then 
        counter = counter + 1
        CX = answer
        myTable[4] = "Type in the value of CY" 
        on.resize()
    else if counter == 5 then 
        counter = counter + 1
        CY = answer
        myTable[4] = "Type in the value of DX" 
        on.resize() 
    else if counter == 6 then 
        counter = counter + 1
        DX = answer
        myTable[4] = "Type in the value of DY" 
        on.resize()
    else if counter == 7 then 
        counter = counter + 1
        DY = answer
        
        Dist1=math.sqrt(((CX-AX)^2)+((CY-AY))^2)
        Dist2=math.sqrt(((DX-BX)^2)+((DY-BY))^2)
        Slope1=(CY-AY)/(CX-AX)
        Slope2=-1/((DY-BY)/(DX-BX))
        
        if Dist1==Dist2 and Slope1==Slope2 then myTable[4] = "The shape is a square." end
        if Dist1==Dist2 and Slope1~=Slope2 then myTable[4] = "The shape is a rectangle." end
        if Dist1~=Dist2 and Slope1==Slope2 then myTable[4] = "The shape is a rhombus." end
        if Dist1~=Dist2 and Slope1~=Slope2 then myTable[4] = "It is not a square, rectangle or rhombus." end end
        on.resize()
    end 
    end
    end 
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