local COLOR_MUL = (love.getVersion() >= 11.0) and 1 or 255
Functions = {
    getobjmoveenv = function(obj,kind,expected,data) -- Get an objects position after moving
        local Lateral = (kind=="x") and "y" or "x"
        for _,Obj in pairs(_World.Objects) do -- When I add objects
            if (Obj.Collisions == true) and (obj.Position[Lateral]/GLOBAL_DRAW_SCALE[Lateral]+obj.Size[Lateral]/GLOBAL_DRAW_SCALE[Lateral]>Obj.Position[Lateral]/GLOBAL_DRAW_SCALE[Lateral]) and (obj.Position[Lateral]/GLOBAL_DRAW_SCALE[Lateral]<Obj.Position[Lateral]/GLOBAL_DRAW_SCALE[Lateral]+Obj.Size[Lateral]/GLOBAL_DRAW_SCALE[Lateral]) then
                if (obj.Position[kind]+obj.Size[kind]/GLOBAL_DRAW_SCALE[kind]+data>obj.Position[kind]+obj.Size[kind]/GLOBAL_DRAW_SCALE[kind]) and (obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]+obj.Size[kind]/GLOBAL_DRAW_SCALE[kind]+data > Obj.Position[kind]/GLOBAL_DRAW_SCALE[kind] and Obj.Position[kind]/GLOBAL_DRAW_SCALE[kind] > obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]+obj.Size[kind]/GLOBAL_DRAW_SCALE[kind]) then
                    return true,Obj.Position[kind]-obj.Size[kind]-0.1,false,Obj
                end
                if (obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]+data<obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]) and (obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]+data < Obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]+Obj.Size[kind]/GLOBAL_DRAW_SCALE[kind] and Obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]+Obj.Size[kind]/GLOBAL_DRAW_SCALE[kind] < obj.Position[kind]/GLOBAL_DRAW_SCALE[kind]) then
                    return true,Obj.Position[kind]+Obj.Size[kind]+0.1,true,Obj
                end
            end
        end
        local rvalue = (kind == "y") and true or false --return
        return false,nil,rvalue
    end,
    Color3 = function(r,b,g,a)
        a = a or 255
        return {Red=r*(1/255),Blue=b*(1/255),Green=g*(1/255),Alpha=a*(1/255)}
    end,
    gradient = function(colors)
        local direction = colors.direction or "horizontal"
        if direction == "horizontal" then
            direction = true
        elseif direction == "vertical" then
            direction = false
        else
            error("Invalid direction '" .. tostring(direction) .. "' for gradient.  Horizontal or vertical expected.")
        end
        local result = love.image.newImageData(direction and 1 or #colors, direction and #colors or 1)
        for i, color in ipairs(colors) do
            local x, y
            if direction then
                x, y = 0, i - 1
            else
                x, y = i - 1, 0
            end
            result:setPixel(x, y, color[1], color[2], color[3], color[4] or 255)
        end
        result = love.graphics.newImage(result)
        result:setFilter('linear', 'linear')
        return result
    end,
    rectGradient = function(obj,ColorData)
        local mesh = Functions.gradient(ColorData)
        local posx = (obj.Type == "draw") and obj.DrawPosition.x or obj.DrawPosition.x
        local posy = (obj.Type == "draw") and obj.DrawPosition.y or obj.DrawPosition.y
        local width = (obj.Type == "draw") and obj.DrawSize.x or obj.Size.x
        local height = (obj.Type == "draw") and obj.DrawSize.y or obj.Size.y
        return function() return love.graphics.draw(mesh, (posx+GLOBAL_OFFSET_X)/GLOBAL_DRAW_SCALE.x, (posy+GLOBAL_OFFSET_Y)/GLOBAL_DRAW_SCALE.y, 0, (width / mesh:getWidth())/GLOBAL_DRAW_SCALE.x, (height / mesh:getHeight())/GLOBAL_DRAW_SCALE.y) end
    end
}

return Functions




