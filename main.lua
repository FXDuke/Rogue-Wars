print('\tLoading Rogue Wars\t:\t{\n')

local Coroutine = require('./Spawn')
local spawn = Coroutine.spawn
print('\tLoaded: { Coroutine }')

local Functions = require('./functions')
local getobjmoveenv = Functions.getobjmoveenv
local Color3 = Functions.Color3 -- RBG
local gradient = Functions.gradient
local rectGradient = Functions.rectGradient
print('\tLoaded: { Global Functions }')

print('\n\tFinished Loading\n\n\t\t\t\t\t}')

function love.load()
	love.window.setMode(800, 600, {resizable=true, vsync=true, minwidth=400, minheight=300})
end

local OriginWidth = love.graphics.getWidth()
local OriginHeight = love.graphics.getHeight()

_G.GLOBAL_DRAW_SCALE = {
    x = 800/OriginWidth,
    y = 600/OriginHeight
}
_G.GLOBAL_OFFSET_X = 0
_G.GLOBAL_OFFSET_Y = 0


_World = {
    FindFirstChild = function(name)
        for _,Object in pairs(_World.Objects) do 
            if Object.Name == name then 
                return Object
            end
        end
        return nil
    end,
    Objects = {},
    Accents = {}
}

function Instance(name)
    name = name or "Object"
    local newObj = {Name=name,Type = "rectangle",DrawSize={x=1,y=1},DrawPosition={x=0,y=0},Player=false,AirBorn=true,Anchored = false,Collisions = true,Visible = true,LinearVelocity={x=0,y=0},Position = {x = 0,y = 0,},Size = {x = 10,y = 5,},DrawType = "fill",CornerRad = {x = 0,y = 0,},Color = {Red = 1,Blue = 1,Green = 1,Alpha = 1,}}
    table.insert(_World.Objects,newObj)
    return _World.Objects[#_World.Objects]
end


print('\tLoading World\t:\t{\n')


GroundTexture = love.graphics.newImage("Assets/GroundGrass.png")
GrassTexture = love.graphics.newImage("Assets/basicblock20x20.png")
GrassTexture2 = love.graphics.newImage("Assets/basicblockgrassy20x20.png")
GrassTexture3 = love.graphics.newImage("Assets/basicblockmushroom20x20.png")
GrassCornerRight = love.graphics.newImage("Assets/basicblockcornerright20x20.png")
GrassCornerLeft = love.graphics.newImage("Assets/basicblockcornerleft20x20.png")
House1 = love.graphics.newImage("Assets/basichouse50x40.png")


local Ground2 = Instance("Ground2")
Ground2.Type = "rectangle"
Ground2.DrawType = "fill"
Ground2.Anchored = true
Ground2.Color = {Red=0,Green=0,Blue=0,Alpha=1}
Ground2.Position = {x=0,y=560}
Ground2.Size = {x=2000,y=3400}

local Ground = Instance("Ground")
Ground.Type = "draw"
Ground.DrawType = GroundTexture
Ground.Anchored = true
Ground.Position = {x=40,y=540}
Ground.DrawPosition = {x=0,y=400}
Ground.Size = {x=1900,y=400}
Ground.DrawSize = {x=1,y=1}



local House = Instance("House")
House.Type = "draw"
House.DrawType = House1
House.Anchored = true 
House.Collisions = false 
House.Position = {x=110,y=-300}
House.Size = {x=500,y=400}
House.DrawPosition = {x=110,y=-300}
House.DrawSize = {x=1,y=1}

local Platform = Instance("Platform")
Platform.Type = "draw"
Platform.DrawType = GrassCornerLeft
Platform.Anchored = true
Platform.Position = {x=10,y=110}
Platform.DrawPosition = {x=0,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}

local Platform = Instance("Platform")
Platform.Type = "draw"
Platform.DrawType = GrassTexture2
Platform.Anchored = true
Platform.Position = {x=200,y=110}
Platform.DrawPosition = {x=200,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}

local Platform = Instance("Platform")
Platform.Type = "draw"
Platform.DrawType = GrassTexture3
Platform.Anchored = true
Platform.Position = {x=400,y=110}
Platform.DrawPosition = {x=400,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}

local Platform = Instance("Platform")
Platform.Type = "draw"
Platform.DrawType = GrassTexture
Platform.Anchored = true
Platform.Position = {x=600,y=110}
Platform.DrawPosition = {x=600,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}

local Platform = Instance("Platform")
Platform.Type = "draw"
Platform.DrawType = GrassCornerRight
Platform.Anchored = true
Platform.Position = {x=790,y=110}
Platform.DrawPosition = {x=800,y=50}
Platform.Size = {x=190,y=140}
Platform.DrawSize = {x=1,y=1}




local Gradient_Dirt = rectGradient(Ground,{
    Direction = "veritcal",
    {0,0,0,0.3},
    {0,0,0,1},
})
table.insert(_World.Accents,Gradient_Dirt)





local PlayerRoot = Instance("PlayerRoot")
PlayerRoot.Player = true 
PlayerRoot.DrawType = "line"
PlayerRoot.Anchored = true
PlayerRoot.Position = {x=150,y=150}
PlayerRoot.Size = {x=125,y=125}
PlayerRoot.Color = {Red=1,Blue=1,Green=1,Alpha=1}
PlayerRoot.LinearVelocity = {x=-3,y=0}


local Start_Time = os.time()
local Start_Clock = os.clock()
local DT = os.clock()-Start_Clock
local Elapsed = os.time()-Start_Time
local FPS = 0 

print('\n\tFinished Loading\n\n\t\t\t\t\t}')

print('\tLoading Libraries\t:\t{\n')

local love = require('love')
print('\tLoaded: { Love2D }')

print('\n\tFinished Loading\n\n\t\t\t\t\t}')


local Terminal = {}
Terminal.Position = {x=20,y=20}
Terminal.Size = {x=500,y=200}
Terminal.Visible = false 

local DeleteCD = 0.5
local terminal_text = ""
function love.draw()
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
    love.graphics.setColor(0,0,0,1)
    love.graphics.print(tostring(math.floor(FPS)),20,20)
    love.graphics.print("Width:\t"..tostring(love.graphics.getWidth()),20,40)
    love.graphics.print("Height:\t"..tostring(love.graphics.getHeight()),20,60)
    for _,Object in pairs(_World.Objects) do 
        if Object.Visible == true then 
            love.graphics.setColor(Object.Color.Red,Object.Color.Blue,Object.Color.Green,Object.Color.Alpha)
            if Object.Type == "rectangle" then
                love.graphics.rectangle(Object.DrawType,(Object.Position.x+GLOBAL_OFFSET_X)/GLOBAL_DRAW_SCALE.x,(Object.Position.y+GLOBAL_OFFSET_Y)/GLOBAL_DRAW_SCALE.y,Object.Size.x/GLOBAL_DRAW_SCALE.x,Object.Size.y/GLOBAL_DRAW_SCALE.y,Object.CornerRad.x,Object.CornerRad.y)
            end 
            if Object.Type == "draw" then 
                love.graphics.draw(Object.DrawType,(Object.DrawPosition.x+GLOBAL_OFFSET_X)/GLOBAL_DRAW_SCALE.x,(Object.DrawPosition.y+GLOBAL_OFFSET_Y)/GLOBAL_DRAW_SCALE.y,0,Object.DrawSize.x/GLOBAL_DRAW_SCALE.x,Object.DrawSize.y/GLOBAL_DRAW_SCALE.y)
            end
        end
    end
    for _,Accent in pairs(_World.Accents) do 
        Accent()
    end
    if Terminal.Visible == true then 
        love.graphics.setColor(1,1,1,1)
        love.graphics.rectangle("fill",0,0,500,200)
        love.graphics.setColor(0,0,0)
        love.graphics.print(terminal_text, 30,40)
    end
end

local Movement = {
    w = false,
    a = false,
    d = false,
    backspace = false,
}

function love.keypressed(key) 
    pcall(function()
        if Terminal.Visible == false then
            Movement[key] = true
        end
    end)
    if key == "/" then 
        Terminal.Visible = not Terminal.Visible
        terminal_text = ''
        return
    end
    if key == "return" and Terminal.Visible == true then
        if terminal_text == "spawn" then 
            local FallingObject = Instance("FallingObject2")
            FallingObject.Position = {x=275,y=160}
            FallingObject.Size = {x=25,y=25}
            FallingObject.Color = {Red=1,Blue=0,Green=1,Alpha=1}
            FallingObject.LinearVelocity = {x=-3,y=0}
        elseif terminal_text:sub(1,6) == "scale " then 
            _G.GLOBAL_DRAW_SCALE = {
                x = tonumber(terminal_text:sub(7)),
                y = tonumber(terminal_text:sub(7))
            }
        end
        terminal_text = ""
        return
    end
    if key == "backspace" then 
        DeleteCD = 0.5
        Movement.backspace = true 
        terminal_text = terminal_text:sub(1,#terminal_text-1)
        return
    end
    key = (key=="space") and " " or key
    terminal_text = terminal_text .. key
end

function love.keyreleased(key)
    pcall(function()
        Movement[key] = false
    end)
end



function love.update(DT)

    

    DeleteCD = (DeleteCD-DT>0) and DeleteCD-DT or 0

    if Movement.backspace == true and DeleteCD < 0.05 then 
        DeleteCD = 0.1
        terminal_text = terminal_text:sub(1,#terminal_text-1)
    end

    if PlayerRoot.Position.y+GLOBAL_OFFSET_Y > 1000 then
        PlayerRoot.Position = {x=150,y=150} 
        PlayerRoot.LinearVelocity = {x=0,y=0}
    end 
    

    FPS = 1/DT
    Elapsed = Elapsed + (os.time()-Start_Time-Elapsed)


    Coroutine.BeginLoop()

    for _,Object in pairs(_World.Objects) do 
        local Collosion,FinalPosition,Fall = getobjmoveenv(Object,"y",true,1)
        if Collosion == false then 
            Object.AirBorn = Fall
        end 
        if Object.AirBorn == true and (Object.Anchored == false or Object.Player == true) then
            Object.LinearVelocity.y = Object.LinearVelocity.y+(60.5*DT)
            local Collosion,FinalPosition,Fall,CollisionObject = getobjmoveenv(Object,"y",true,Object.LinearVelocity.y/GLOBAL_DRAW_SCALE.y)
            if Collosion == false then 
                Object.Position.y = Object.Position.y + Object.LinearVelocity.y/GLOBAL_DRAW_SCALE.y
            else
                if CollisionObject.Anchored == false then 
                    CollisionObject.AirBorn = true 
                    CollisionObject.LinearVelocity.y = Object.LinearVelocity.y/2
                end
                Object.LinearVelocity.y = -Object.LinearVelocity.y/2
                Object.Position.y = FinalPosition
                Object.AirBorn = Fall
            end
        else
            Object.LinearVelocity.y = 0
        end
        if Object.Anchored == false or Object.Player == true then 
            local Increase = (Movement.a or Movement.d) and -10 or 40
            local Decrease = (Object.LinearVelocity.x>0) and (Increase+40.5)*DT or (-Increase-40.5)*DT 
            Object.LinearVelocity.x = (Object.LinearVelocity.x>0 and Object.LinearVelocity.x-Decrease>=0) and Object.LinearVelocity.x-Decrease or (Object.LinearVelocity.x< 0 and Object.LinearVelocity.x-Decrease <= 0) and Object.LinearVelocity.x-Decrease or 0
            local Collosion,FinalPosition,_,CollisionObject = getobjmoveenv(Object,"x",true,Object.LinearVelocity.x/GLOBAL_DRAW_SCALE.x)
            if Collosion == false then 
                Object.Position.x = Object.Position.x + Object.LinearVelocity.x/GLOBAL_DRAW_SCALE.x
            else
                if CollisionObject.Anchored == false then 
                    CollisionObject.LinearVelocity.x = Object.LinearVelocity.x
                end
                Object.LinearVelocity.x = 0
                Object.Position.x = FinalPosition
            end
        end
    end

    local Distance = math.abs(love.graphics.getWidth()/2-(PlayerRoot.Position.x+GLOBAL_OFFSET_X))
    if Distance>1 then 
        _G.GLOBAL_OFFSET_X = (love.graphics.getWidth()/2>(PlayerRoot.Position.x+GLOBAL_OFFSET_X)) and GLOBAL_OFFSET_X+(Distance*(DT*6))*GLOBAL_DRAW_SCALE.x or GLOBAL_OFFSET_X-(Distance*(DT*6))*GLOBAL_DRAW_SCALE.x
    end
    local Distance = math.abs(love.graphics.getHeight()/2-(PlayerRoot.Position.y+GLOBAL_OFFSET_Y))
    if Distance>1 then 
        _G.GLOBAL_OFFSET_Y = (love.graphics.getHeight()/2>(PlayerRoot.Position.y+GLOBAL_OFFSET_Y)) and GLOBAL_OFFSET_Y+(Distance*(DT*6))*GLOBAL_DRAW_SCALE.y or GLOBAL_OFFSET_Y-(Distance*(DT*6))*GLOBAL_DRAW_SCALE.y
    end
    



    if Movement.w == true and PlayerRoot.AirBorn == false then 
        PlayerRoot.AirBorn = true 
        PlayerRoot.LinearVelocity.y = -30
    end

    if Movement.d == true then 
        PlayerRoot.LinearVelocity.x = (PlayerRoot.LinearVelocity.x+77.5*DT<25) and PlayerRoot.LinearVelocity.x+77.5*DT or PlayerRoot.LinearVelocity.x
    end
    if Movement.a == true then 
        PlayerRoot.LinearVelocity.x = (PlayerRoot.LinearVelocity.x-77.5*DT>-25) and PlayerRoot.LinearVelocity.x-77.5*DT or PlayerRoot.LinearVelocity.x
    end

end