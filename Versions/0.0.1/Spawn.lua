

Coroutine = {
    PriorityQueue = {},
    spawn = function(oldFunc,Priority,stopVariable)

        Priority = Priority or 1 
        stopVariable = stopVariable or true

        Coroutine.PriorityQueue[Priority] = Coroutine.PriorityQueue[Priority] or {}

        local newFunc = coroutine.create(
            function()
                while true do 
                    if oldFunc(coroutine.yield()) == stopVariable then 
                        break
                    end
                end
            end)

        local ID = #Coroutine.PriorityQueue[Priority]+1

        CoroutineObject = {
            ID = ID,
            CoroutineFunction = newFunc,
            PriorityLevel = Priority,
            ChangePriority = function(newLevel)
                table.remove(Coroutine.PriorityQueue[CoroutineObject.PriorityLevel],CoroutineObject.ID)
                CoroutineObject.ID = #Coroutine.PriorityQueue[newLevel]+1
                CoroutineObject.PriorityLevel = newLevel
                table.insert(Coroutine.PriorityQueue[newLevel],CoroutineObject)
            end,
        }

        coroutine.resume(CoroutineObject.CoroutineFunction)
        table.insert(Coroutine.PriorityQueue[Priority],CoroutineObject)
    end,
    ClearPriority = function(PriorityLevel)
        PriorityLevel = PriorityLevel or 1 
        Coroutine.PriorityQueue[PriorityLevel] = {}
    end,
    BeginLoop = function()
        for Priority,Coroutines in pairs(Coroutine.PriorityQueue) do 
            for _,CoroutineObject in pairs(Coroutines) do 
                coroutine.resume(CoroutineObject.CoroutineFunction)
                if coroutine.status(CoroutineObject.CoroutineFunction) == "dead" then 
                    table.remove(Coroutines,_)
                end
            end
        end
    end
}


return Coroutine



