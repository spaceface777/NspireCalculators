local screen = platform.window 
local h=screen:height() 
local w=screen:width() 
local AX = 0
local AY = 0
local BX = 0
local BY = 0
local CX = 0
local CY = 0
local AB_Slope = 0
local BC_Slope = 0
local AC_Slope = 0
local AB_P_Slope = 0
local BC_P_Slope = 0
local AC_P_Slope = 0
local AB_P_B = 0
local BC_P_B = 0
local AC_P_B = 0
local Intersection_X = 0
local Intersection_Y = 0
local counter = 0
local Counter = 0
local answer = "" 
local myTable = {"Orthocenter calculator","("..AX..","..AY.."),("..BX..","..BY.."),("..CX..","..CY..")", answer, "Type in the value of AX"} 
local linecount = #table 
local fontSize = 10 

function on.resize() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    answer = "" 
    myTable = {"Orthocenter calculator","("..AX..","..AY.."),("..BX..","..BY.."),("..CX..","..CY..")", answer, myTable[4]} 
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
    AB_Slope = 0
    BC_Slope = 0
    AC_Slope = 0
    AB_P_Slope = 0
    BC_P_Slope = 0
    AC_P_Slope = 0
    AB_P_B = 0
    BC_P_B = 0
    AC_P_B = 0
    Intersection_X = 0
    Intersection_Y = 0
    counter = 0
    Counter = 0
    answer = "" 
    myTable = {"Orthocenter calculator","("..AX..","..AY.."),("..BX..","..BY.."),("..CX..","..CY..")", answer, "Type in the value of AX"} 
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
        
        AB_Slope = ((BY-AY)/(BX-AX))
        BC_Slope = ((CY-BY)/(CX-BX))
        AC_Slope = ((CY-AY)/(CX-AX))
                
        AB_P_Slope = -1/AB_Slope
        BC_P_Slope = -1/BC_Slope
        AC_P_Slope = -1/AC_Slope
        
        if string.find(AB_P_Slope, "9999") then Counter = 1
        else if string.find(BC_P_Slope, "9999") then Counter = 2
        end end
        
        AB_P_B = -(AB_P_Slope * CX) + CY
        BC_P_B = -(BC_P_Slope * AX) + AY
        AC_P_B = -(AC_P_Slope * BX) + BY
        
        Intersection_X = (BC_P_B - AB_P_B)/(AB_P_Slope - BC_P_Slope)
        Intersection_Y = AB_P_Slope * Intersection_X + AB_P_B
        
        if Counter == 1 then
          Intersection_X = (BC_P_B - AC_P_B)/(AC_P_Slope - BC_P_Slope)
          Intersection_Y = AC_P_Slope * Intersection_X + AC_P_B
        else if Counter == 2 then
          Intersection_X = (AC_P_B - AB_P_B)/(AB_P_Slope - AC_P_Slope)
          Intersection_Y = AC_P_Slope * Intersection_X + AC_P_B
        else 
          Intersection_X = (BC_P_B - AB_P_B)/(AB_P_Slope - BC_P_Slope)
          Intersection_Y = AB_P_Slope * Intersection_X + AB_P_B
        end
        end
        
        myTable[4] = "The orthocenter is (" ..  Intersection_X .. "," .. Intersection_Y .. ")." 
        on.resize()
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