print('\tLoading Rogue Wars\t:\t{\n')

local Coroutine = require('./Spawn')
local spawn = Coroutine.spawn
local wait = Coroutine.Wait.Add_Wait
print('\tLoaded: { Coroutine }')

local Functions = require('./functions')
local Physics = Functions.Physics
local ApplyForce = Physics.ApplyForce
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
local text = ""
function group(obj,obj2)
    pcall(function()
        for _,Object in pairs(obj.Group.Children) do
            if Object == obj then
                table.remove(obj.Group.Children,_)
            end
        end 
    end)
    pcall(function()
        obj.Group = obj2
        table.insert(obj2.Children,obj)
    end)
end
Instance = {
    ValidTypes = {
        ['OBJECT'] = true,
        ['FOLDER'] = true,
        ['BUTTON'] = true,
        ['PLAYER'] = true,
    },
    PhysicalTypes = {
        ['OBJECT'] = true,
        ['BUTTON'] = true,
        ['PLAYER'] = true,
    },
    OBJECT = function()
        return {Group={},GroupActivated=false,GroupActivation=function() return end,Children={},Activation=function()return true end,Weight=1,Exclude={},Button = {Value = false},ApplyPrevious=false,AppliedStopPower=1,Type = "rectangle",DrawSize={x=1,y=1},DrawPosition={x=0,y=0},Player=false,AirBorn=true,Anchored = false,Collisions = true,Visible = true,LinearVelocity={x=0,y=0},Position = {x = 0,y = 0,},Size = {x = 10,y = 5,},DrawType = "fill",CornerRad = {x = 0,y = 0,},Color = {Red = 1,Blue = 1,Green = 1,Alpha = 1,}}
    end,
    FOLDER = function()
        return {Group={},GroupActivated=false,GroupActivation=function() return end,Children={},Activation=function()return true end,Button = {Value = false}}
    end,
    BUTTON = function()
        return {Group={},GroupActivated=false,GroupActivation=function() return end,Children={},Activation=function()return true end,Weight=1,Exclude={},Button = {activationFunction=function()return true end,Activated=false,Value = false,Origin = {x=0,y=0},startx = 0,maxx = 0,starty = 0,maxy = 0,Axis = "x",},ApplyPrevious=false,AppliedStopPower=1,Type = "rectangle",DrawSize={x=1,y=1},DrawPosition={x=0,y=0},Player=false,AirBorn=true,Anchored = false,Collisions = true,Visible = true,LinearVelocity={x=0,y=0},Position = {x = 0,y = 0,},Size = {x = 10,y = 5,},DrawType = "fill",CornerRad = {x = 0,y = 0,},Color = {Red = 1,Blue = 1,Green = 1,Alpha = 1,}}
    end,
    PLAYER = function()
        return {Group={},GroupActivated=false,GroupActivation=function() return end,Children={},Activation=function()return true end,PlayerValues={JumpCD=0,WallRide=false,WallRiding=false,RideTime=0,MaxTime=0.175},Weight=1,Exclude={},Button = {Value = false},ApplyPrevious=false,AppliedStopPower=1,Type = "rectangle",DrawSize={x=1,y=1},DrawPosition={x=0,y=0},Player=true,AirBorn=true,Anchored = false,Collisions = true,Visible = true,LinearVelocity={x=0,y=0},Position = {x = 0,y = 0,},Size = {x = 10,y = 5,},DrawType = "fill",CornerRad = {x = 0,y = 0,},Color = {Red = 1,Blue = 1,Green = 1,Alpha = 1,}}
    end,
    new = function(Type,Parent)
        Type2 = string.upper(Type)
        Parent = Parent or _World.Objects
        if (Instance.ValidTypes[Type2]~=true) then return error("'"..tostring(Type).."' is not a valid Instance Type.")  end

        local Item = Instance[Type2]()
        Item.Name = Type
        Item.InstanceType = Type2
        table.insert(_World.Objects,Item)
        group(_World.Objects[#_World.Objects],Parent)
        return _World.Objects[#_World.Objects]
    end,
}

print('\tLoading World\t:\t{\n')


GroundTexture = love.graphics.newImage("Assets/GroundGrass.png")
GrassTexture = love.graphics.newImage("Assets/basicblock20x20.png")
GrassTexture2 = love.graphics.newImage("Assets/basicblockgrassy20x20.png")
GrassTexture3 = love.graphics.newImage("Assets/basicblockmushroom20x20.png")
GrassCornerRight = love.graphics.newImage("Assets/basicblockcornerright20x20.png")
GrassCornerLeft = love.graphics.newImage("Assets/basicblockcornerleft20x20.png")
House1 = love.graphics.newImage("Assets/basichouse50x40.png")


local Ground2 = Instance.new("Object")
Ground2.Type = "rectangle"
Ground2.DrawType = "fill"
Ground2.Anchored = true
Ground2.Color = {Red=0,Green=0,Blue=0,Alpha=1}
Ground2.Position = {x=0,y=560}
Ground2.Size = {x=2000,y=3400}

local Ground = Instance.new("Object")
Ground.Type = "draw"
Ground.DrawType = GroundTexture
Ground.Anchored = true
Ground.Position = {x=40,y=540}
Ground.DrawPosition = {x=0,y=400}
Ground.Size = {x=1900,y=400}
Ground.DrawSize = {x=1,y=1}



local House = Instance.new("Object")
House.Type = "draw"
House.DrawType = House1
House.Anchored = true 
House.Collisions = false 
House.Position = {x=110,y=-300}
House.Size = {x=500,y=400}
House.DrawPosition = {x=110,y=-300}
House.DrawSize = {x=1,y=1}

local PlatformHolder = Instance.new("Folder")


local Platform = Instance.new("Object",PlatformHolder)
Platform.Type = "draw"
Platform.DrawType = GrassCornerLeft
Platform.Anchored = true
Platform.Position = {x=10,y=110}
Platform.DrawPosition = {x=0,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}


local Platform = Instance.new("Object",PlatformHolder)
Platform.Type = "draw"
Platform.DrawType = GrassTexture2
Platform.Anchored = true
Platform.Position = {x=200,y=110}
Platform.DrawPosition = {x=200,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}

local Platform = Instance.new("Object",PlatformHolder)
Platform.Type = "draw"
Platform.DrawType = GrassTexture3
Platform.Anchored = true
Platform.Position = {x=400,y=110}
Platform.DrawPosition = {x=400,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}


local Platform = Instance.new("Object",PlatformHolder)
Platform.Type = "draw"
Platform.DrawType = GrassTexture
Platform.Anchored = true
Platform.Position = {x=600,y=110}
Platform.DrawPosition = {x=600,y=50}
Platform.Size = {x=200,y=140}
Platform.DrawSize = {x=1,y=1}

local Platform = Instance.new("Object",PlatformHolder)
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





local PlayerRoot = Instance.new("Player")
PlayerRoot.Player = true 
PlayerRoot.Weight = 10
PlayerRoot.DrawType = "line"
PlayerRoot.Anchored = true
PlayerRoot.Position = {x=150,y=150}
PlayerRoot.Size = {x=125,y=125}
PlayerRoot.Color = {Red=1,Blue=1,Green=1,Alpha=1}
PlayerRoot.LinearVelocity = {x=-3,y=0}

local PlayerRoot2 = Instance.new("Player")
PlayerRoot2.Weight = 10
PlayerRoot2.Player = false 
PlayerRoot2.DrawType = "line"
PlayerRoot2.Anchored = false
PlayerRoot2.Position = {x=150,y=150}
PlayerRoot2.Size = {x=125,y=125}
PlayerRoot2.Color = {Red=1,Blue=1,Green=1,Alpha=1}
PlayerRoot2.LinearVelocity = {x=-3,y=0}


local i = 0
local Button = Instance.new("Button")
Button.Anchored = false
Button.DrawType = "fill"
Button.Position = {x=2140,y=540}
Button.Size = {x=100,y=100}
Button.LinearVelocity = {x=0,y=5}
Button.Weight = 1
Button.Color = {Red=1,Blue=0,Green=0,Alpha=1}
Button.Button = {
    Value = true,
    Axis = "y",
    starty = -5,
    maxy = 55,
    activationDistance=20,
    activationFunction = function() text = "hi"..tostring(i);i=i+1 end,
    Origin = {x=2140,y=540}
}

local Item = Instance.new("Object")
Item.Position = {x=1200,y=100}
Item.Size = {x=100,y=100}
Item.Anchored = true 
Item.Activation = function(Obj)
    if Item.Visible == false then return end
    Obj.LinearVelocity.y = -25
    Obj.AirBorn = true
    wait(1,function()
        Item.Visible = false 
        Item.Collisions = false
        wait(3,function()
            Item.Visible = true 
            Item.Collisions = true
        end)
    end)
end

local ButtonBox = Instance.new("Object")
ButtonBox.Collisions = true
ButtonBox.DrawType = "fill"
ButtonBox.Anchored = true 
ButtonBox.Position = {x=2115,y=600}
ButtonBox.Size = {x=150,y=105}
ButtonBox.Color = {Red=0.5,Blue=0.5,Green=0.5,Alpha=1}




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
    love.graphics.print(tostring(PlayerRoot.PlayerValues.RideTime),20,40)
    love.graphics.print(tostring((Button.Position.y>Button.Button.Origin.y+Button.Button.starty)),20,60)
    love.graphics.print(text,20,80)
    --love.graphics.print("ApplyForce :\t"..tostring(ApplyForce(PlayerRoot,PlayerRoot2,"x",10)),20,40)
    for _,Object in pairs(_World.Objects) do
        text = Object.InstanceType 
        if Instance.PhysicalTypes[Object.InstanceType] == true then
            
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
            local PlayerRoot2 = Instance.new("Player")
            PlayerRoot2.Weight = 10
            PlayerRoot2.Player = false 
            PlayerRoot2.DrawType = "line"
            PlayerRoot2.Anchored = false
            PlayerRoot2.Position = {x=150,y=150}
            PlayerRoot2.Size = {x=125,y=125}
            PlayerRoot2.Color = {Red=1,Blue=1,Green=1,Alpha=1}
            PlayerRoot2.LinearVelocity = {x=-3,y=0}
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
        if PlayerRoot.PlayerValues.WallRiding == true then
            PlayerRoot.PlayerValues.WallRide = true
        end
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


    Coroutine.BeginLoop(DT)
    for _,Object in pairs(_World.Objects) do 
        if Instance.PhysicalTypes[Object.InstanceType] then 
            Object.ApplyPrevious = (Object.LinearVelocity == {x=0,y=0}) and false or Object.ApplyPrevious
            local Collosion,ObjectTable = getobjmoveenv(Object,"y",true,1)
            if Collosion == false then 
                Object.AirBorn = true
            end 
            if Object.AirBorn == true and (Object.Anchored == false or Object.Player == true) and Object.Button.Value == false then
                Object.LinearVelocity.y = Object.LinearVelocity.y+(70.5*DT)
                local Collosion,ObjectTable,FinalPosition = getobjmoveenv(Object,"y",true,Object.LinearVelocity.y/GLOBAL_DRAW_SCALE.y)
                if Collosion == false then 
                    Object.Position.y = Object.Position.y + Object.LinearVelocity.y/GLOBAL_DRAW_SCALE.y
                else
                    for _,Table in pairs(ObjectTable) do 
                        local CollisionObject = Table.CollisionObject
                        if CollisionObject.Anchored == false then 
                            CollisionObject.AirBorn = true 
                            if CollisionObject.Button.Value == true then
                                CollisionObject.LinearVelocity.y = (Object.LinearVelocity.y>0) and (Object.Weight*9.7) or -(Object.Weight*9.7)
                            else 
                                ApplyForce(Object,CollisionObject,"y")
                            end
                        else 
                            Object.LinearVelocity.y = -Object.LinearVelocity.y/2
                        end
                        if CollisionObject.Button.Value == true then 
                            Object.LinearVelocity.y = -0.1
                        end
                    end
                        if Object.Player == true then
                            if Object.PlayerValues.WallRide == true then 
                                Object.PlayerValues.WallRiding = false 
                                Object.PlayerValues.WallRide = false 
                                Object.PlayerValues.RideTime = 0
                            end
                        end
                        Object.Position.y = FinalPosition
                        Object.AirBorn = (Object.LinearVelocity.y>=0) and true or false
                end
            else
                Object.LinearVelocity.y = (Object.Button.Value==false) and 0 or Object.LinearVelocity.y
            end
            if Object.Anchored == false or Object.Player == true and Object.Button.Value == false then 
                local Increase = (Movement.a or Movement.d) and -10 or 40
                local Decrease = (Object.LinearVelocity.x>0) and (Increase+40.5)*DT or (-Increase-40.5)*DT 
                Object.LinearVelocity.x = (Object.LinearVelocity.x>0 and Object.LinearVelocity.x-Decrease>=0) and Object.LinearVelocity.x-Decrease or (Object.LinearVelocity.x< 0 and Object.LinearVelocity.x-Decrease <= 0) and Object.LinearVelocity.x-Decrease or 0
                local Collosion,ObjectTable,FinalPosition = getobjmoveenv(Object,"x",true,Object.LinearVelocity.x/GLOBAL_DRAW_SCALE.x)
                if Collosion == false then 
                    Object.Position.x = Object.Position.x + Object.LinearVelocity.x/GLOBAL_DRAW_SCALE.x
                else
                    for _,Table in pairs(ObjectTable) do 
                        local CollisionObject = Table.CollisionObject
                        if CollisionObject.Button.Value == true  then 
                        
                            CollisionObject.LinearVelocity.y = 30
                            Object.LinearVelocity.y = -2
                            Object.AirBorn = true
                        end
                        if CollisionObject.Anchored == false then 
                            ApplyForce(Object,CollisionObject,"x")
                        else
                            Object.LinearVelocity.x = 0
                        end
                        if Object.Player or CollisionObject.Player then
                            if (CollisionObject.Position.y-Object.Position.y>-2.5) and Object.LinearVelocity.y>=0 and Object.PlayerValues.WallRide == false and Object.PlayerValues.RideTime<Object.PlayerValues.MaxTime then
                                Object.PlayerValues.WallRiding = true
                                Object.AirBorn = (CollisionObject.Anchored==true) and true or false
                                Object.PlayerValues.RideTime = Object.PlayerValues.RideTime+DT
                                Object.LinearVelocity.y = -180.5*DT -math.abs(CollisionObject.Position.y-Object.Position.y)*DT
                            end
                        end
                        if CollisionObject.Button.Value == true then 
                            Object.LinearVelocity.x = 0
                        end
                    end
                    Object.Position.x = FinalPosition
                end
            end
            if Object.Button.Value == true then 
                local Axis = Object.Button.Axis
                local Lateral = (Axis=="y") and "x" or "y"
                local Direction = (Object.Button.Origin[Axis]+Object.Button["max"..Axis]>Object.Button.Origin[Axis]) and Object.Button.Origin[Axis]+Object.Button["max"..Axis] or Object.Button.Origin[Axis]-Object.Button["max"..Axis]
                Object.Position[Lateral] = Object.Button.Origin[Lateral]
                local Collosion,ObjectTable = getobjmoveenv(Object,Axis,true, Object.LinearVelocity[Axis]*DT)
                if Object.LinearVelocity[Axis]>3 and (Object.Position[Axis] < Object.Button.Origin[Axis]+Object.Button["max"..Axis] and Object.Position[Axis] > Object.Button.Origin[Axis]+Object.Button["start"..Axis]) and Collosion == false then
                    Object.Position[Axis] = Object.Position[Axis] + Object.LinearVelocity[Axis]*DT
                    Object.LinearVelocity[Axis] = (Object.LinearVelocity[Axis]>0) and Object.LinearVelocity[Axis]-Object.LinearVelocity[Axis]*(5*DT) or Object.LinearVelocity[Axis]+math.abs(Object.LinearVelocity[Axis]*(5*DT))
                    if Object.Position[Axis] > Object.Button.Origin[Axis]+Object.Button.activationDistance and Object.Button.Activated == false then 
                        Object.Button.Activated = true 
                        Object.Button.activationFunction()
                    end
                end
                local Collosion,ObjectTable = getobjmoveenv(Object,Axis,true,(Object.Button.Origin[Axis]+Object.Button['start'..Axis]-Object.Position[Axis])*DT)
                if Collosion == false then
                    Object.Button.Activated = (Object.LinearVelocity[Axis]>3) and Object.Button.Activated or false
                    Object.Position[Axis] = Object.Position[Axis] + (Object.Button.Origin[Axis]+Object.Button['start'..Axis]-Object.Position[Axis])*DT
                end
            
                
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
    

    PlayerRoot.PlayerValues.JumpCD = PlayerRoot.PlayerValues.JumpCD - DT
    if Movement.w == true and PlayerRoot.AirBorn == false and PlayerRoot.PlayerValues.JumpCD <= 0 then 
        PlayerRoot.PlayerValues.JumpCD = 0.3
        PlayerRoot.AirBorn = true 
        PlayerRoot.LinearVelocity.y = -35
    end

    if Movement.d == true then 
        PlayerRoot.LinearVelocity.x = (PlayerRoot.LinearVelocity.x+77.5*DT<25) and PlayerRoot.LinearVelocity.x+77.5*DT or PlayerRoot.LinearVelocity.x
    end
    if Movement.a == true then 
        PlayerRoot.LinearVelocity.x = (PlayerRoot.LinearVelocity.x-77.5*DT>-25) and PlayerRoot.LinearVelocity.x-77.5*DT or PlayerRoot.LinearVelocity.x
    end

    if PlayerRoot.AirBorn == false then
        PlayerRoot.PlayerValues.RideTime = 0
    end


    Functions.Update(DT)
end