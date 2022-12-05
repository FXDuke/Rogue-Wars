Functions = {
    getobjmoveenv = function(obj,kind,expected,data) -- Get an objects position after moving
        local Lateral = (kind=="x") and "y" or "x"
        for _,Obj in pairs(_World.Objects) do -- When I add objects
            if (Obj.Collisions == true) and (obj.Position[Lateral]+obj.Size[Lateral]>Obj.Position[Lateral]) and (obj.Position[Lateral]<Obj.Position[Lateral]+Obj.Size[Lateral]) then
                if (obj.Position[kind]+obj.Size[kind]+data>obj.Position[kind]+obj.Size[kind]) and (obj.Position[kind]+obj.Size[kind]+data > Obj.Position[kind] and Obj.Position[kind] > obj.Position[kind]+obj.Size[kind]) then
                    return true,Obj.Position[kind]-obj.Size[kind]-0.1,false,Obj
                end
                if (obj.Position[kind]+data<obj.Position[kind]) and (obj.Position[kind]+data < Obj.Position[kind]+Obj.Size[kind] and Obj.Position[kind]+Obj.Size[kind] < obj.Position[kind]) then
                    return true,Obj.Position[kind]+Obj.Size[kind]+0.1,true,Obj
                end

            end

        end
        local rvalue = (kind == "y") and true or false --return
        return false,nil,rvalue
    end
}

return Functions




