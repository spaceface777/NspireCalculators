local screen = platform.window 
local h=screen:height() 
local w=screen:width() 
local A = 0
local B = 0
local C = 0
local Number1 = 0
local Number2 = 0
local counter = 0
local answer = "" 
local myTable = {"Quadratic formula calculator",A.."x^2 + "..B.."x + "..C, answer, "Type in the value of A",""} 
local linecount = #table 
local fontSize = 10 

function on.resize() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    answer = "" 
    myTable = {"Quadratic formula calculator",A.."x^2 + "..B.."x + "..C, answer, myTable[4],myTable[5]} 
    screen:invalidate() 
end 

function on.reset() 
    h=screen:height() 
    w=screen:width() 
    fontSize = math.floor(h/20 + 0.5) 
    fontSize = fontSize > 7 and fontSize or 7 
    fontSize = fontSize < 24 and fontSize or 24 
    A = 0
    B = 0
    C = 0
    Number1 = 0
    Number2 = 0  
    counter = 0
    answer = "" 
    myTable = {"Quadratic formula calculator",A.."x^2 + "..B.."x + "..C, answer, "Type in the value of A",""} 
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

local function round (num, n)
  local mult = 10^(n or 0)
  return math.floor(num * mult + 0.5) / mult
end

function on.enterKey() 
    if answer == "" then 
        on.resize() 
    else if counter == 0 then 
        counter = counter + 1
        A = answer
        myTable[4] = "Type in the value of B" 
        on.resize() 
    else if counter == 1 then 
        counter = counter + 1
        B = answer
        myTable[4] = "Type in the value of C" 
        on.resize() 
    else if counter == 2 then 
        counter = counter + 1
        C = answer
        Number1=(-B + math.sqrt(B^2 - 4*A*C)) / (2*A)
        Number2=(-B - math.sqrt(B^2 - 4*A*C)) / (2*A)        
        VertexX=(-B / (2*A))
        VertexY=((A*VertexX^2)+(B*VertexX)+C)
        myTable[4] = "The zeroes are ".. round(Number1, 2) .. "," .. round(Number2, 2)
        myTable[5] = "The vertex is (".. round(VertexX, 2) .. "," .. round(VertexY, 2)..")"
        on.resize()
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
        0.1*w, 140, 
        0.9*w, 140, 
        0.9*w, 110, 
        0.1*w, 110, 
        0.1*w, 140}) 
end