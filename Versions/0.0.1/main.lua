
_World = {
    FindFirstChild = function(name)
        for _,Object in pairs(_World.Objects) do 
            if Object.Name == name then 
                return Object
            end
        end
        return nil
    end,
    Objects = {}
}
function Instance(name)
    name = name or "Object"
    local newObj = {Name=name,Type = "rectangle",AirBorn=true,Anchored = false,Collisions = true,Visible = true,LinearVelocity={x=0,y=0},Position = {x = 0,y = 0,},Size = {x = 10,y = 5,},DrawType = "fill",CornerRad = {x = 0,y = 0,},Color = {Red = 1,Blue = 1,Green = 1,Alpha = 1,}}
    table.insert(_World.Objects,newObj)
    return _World.Objects[#_World.Objects]
end

print('\tLoading World\t:\t{\n')

local Border = Instance("Border")
Border.Position = {x=50,y=500}
Border.Size = {x=750,y=30}
Border.Color = {Red=0.5,Blue=0.5,Green=0.5,Alpha=1}
Border.CornerRad = {x=10,y=10}
Border.Anchored = true 

local Border = Instance("Border")
Border.Position = {x=50,y=100}
Border.Size = {x=50,y=600}
Border.Color = {Red=0.5,Blue=0.5,Green=0.5,Alpha=1}
Border.CornerRad = {x=10,y=10}
Border.Anchored = true 

local Border = Instance("Border")
Border.Position = {x=600,y=100}
Border.Size = {x=50,y=500}
Border.Color = {Red=0.5,Blue=0.5,Green=0.5,Alpha=1}
Border.CornerRad = {x=10,y=10}
Border.Anchored = true 

local Border = Instance("Platform")
Border.Position = {x=150,y=350}
Border.Size = {x=200,y=45}
Border.Color = {Red=0.5,Blue=1,Green=0.5,Alpha=1}
Border.CornerRad = {x=10,y=10}
Border.DrawType = "line"
Border.Anchored = true 

local PlayerRoot = Instance("PlayerRoot")
PlayerRoot.Position = {x=275,y=160}
PlayerRoot.Size = {x=25,y=25}
PlayerRoot.Color = {Red=1,Blue=1,Green=1,Alpha=1}
PlayerRoot.LinearVelocity = {x=-3,y=0}

local Border = Instance("Border")
Border.Position = {x=50,y=100}
Border.Size = {x=750,y=30}
Border.Color = {Red=0.5,Blue=0.5,Green=0.5,Alpha=1}
Border.CornerRad = {x=10,y=10}
Border.Anchored = true 

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


print('\tLoading Rogue Wars\t:\t{\n')

local Coroutine = require('./Spawn')
local spawn = Coroutine.spawn
print('\tLoaded: { Coroutine }')

local Functions = require('./functions')
local getobjmoveenv = Functions.getobjmoveenv
print('\tLoaded: { Global Functions }')

print('\n\tFinished Loading\n\n\t\t\t\t\t}')

local Terminal = Instance("Terminal")
Terminal.Position = {x=20,y=20}
Terminal.Collisions = false 
Terminal.Size = {x=500,y=200}
Terminal.Color = {Red=1,Blue=1,Green=1,Alpha=1}
Terminal.CornerRad = {x=0,y=0}
Terminal.Anchored = true 
Terminal.Visible = false 

local terminal_text = ""
function love.draw()
    love.graphics.print(tostring(math.floor(FPS)),20,20)
    for _,Object in pairs(_World.Objects) do 
        if Object.Visible == true then 
            love.graphics.setColor(Object.Color.Red,Object.Color.Blue,Object.Color.Green,Object.Color.Alpha)
            love.graphics[Object.Type](Object.DrawType,Object.Position.x,Object.Position.y,Object.Size.x,Object.Size.y,Object.CornerRad.x,Object.CornerRad.y)
        end
    end
    if _World.FindFirstChild("Terminal").Visible == true then 
        love.graphics.setColor(0,0,0)
        love.graphics.print(terminal_text, 30,40)
    end
end

local Movement = {
    w = false,
    a = false,
    d = false
}

function love.keypressed(key) 
    pcall(function()
        Movement[key] = true
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
        end
        terminal_text = ""
        return
    end
    if key == "backspace" then 
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
    FPS = 1/DT
    Elapsed = Elapsed + (os.time()-Start_Time-Elapsed)


    Coroutine.BeginLoop()

    for _,Object in pairs(_World.Objects) do 
        local Collosion,FinalPosition,Fall = getobjmoveenv(Object,"y",true,1)
        if Collosion == false then 
            Object.AirBorn = Fall
        end 
        if Object.AirBorn == true and Object.Anchored == false then
            Object.LinearVelocity.y = Object.LinearVelocity.y+(18.5*DT)
            local Collosion,FinalPosition,Fall,CollisionObject = getobjmoveenv(Object,"y",true,Object.LinearVelocity.y)
            if Collosion == false then 
                Object.Position.y = Object.Position.y + Object.LinearVelocity.y
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
        if Object.Anchored == false then 
            local Decrease = (Object.LinearVelocity.x>0) and 8.5*DT or -8.5*DT 
            Object.LinearVelocity.x = (Object.LinearVelocity.x>0 and Object.LinearVelocity.x-Decrease>=0) and Object.LinearVelocity.x-Decrease or (Object.LinearVelocity.x< 0 and Object.LinearVelocity.x-Decrease <= 0) and Object.LinearVelocity.x-Decrease or 0
            local Collosion,FinalPosition,_,CollisionObject = getobjmoveenv(Object,"x",true,Object.LinearVelocity.x)
            if Collosion == false then 
                Object.Position.x = Object.Position.x + Object.LinearVelocity.x
            else
                if CollisionObject.Anchored == false then 
                    CollisionObject.LinearVelocity.x = Object.LinearVelocity.x
                end
                Object.LinearVelocity.x = 0
                Object.Position.x = FinalPosition
            end
        end
    end

    if Movement.w == true and PlayerRoot.AirBorn == false then 
        PlayerRoot.AirBorn = true 
        PlayerRoot.LinearVelocity.y = -10
    end

    if Movement.d == true then 
        PlayerRoot.LinearVelocity.x = (PlayerRoot.LinearVelocity.x+15.5*DT<10) and PlayerRoot.LinearVelocity.x+15.5*DT or PlayerRoot.LinearVelocity.x
    end
    if Movement.a == true then 
        PlayerRoot.LinearVelocity.x = (PlayerRoot.LinearVelocity.x-15.5*DT>-10) and PlayerRoot.LinearVelocity.x-15.5*DT or PlayerRoot.LinearVelocity.x
    end

end