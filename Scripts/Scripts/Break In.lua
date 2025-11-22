local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/hoho_lib.lua", true))()
local win = lib:Window("Fixed","Break In",Color3.new(0.333333, 0.666667, 1))
local tab = win:Tab("Main")
local label = tab:Label("Label", properties) --properties: {["Visible"] = flase}
label:NewLabel("Main", properties)
tab:Line()
tab:Button("Get Chips", function() 
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
end)
 
tab:Line() 
tab:Button("Get Cola", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("BloxyCola")
end)
 
tab:Line() 
tab:Button("Get Apple", function() 
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Apple")
end)
 
tab:Line() 
tab:Button("Get Pizza", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Pizza3")
end)
 
tab:Line() 
tab:Button("Get Cookie", function() 
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Cookie")
end) 
 
tab:Line() 
tab:Button("Get Medkit", function() 
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("MedKit")
end)
 
tab:Line()
tab:Button("Get Cure", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Cure")
end)
 
tab:Line() 
tab:Button("Get Bat(Weapon)", function() 
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Bat")
end) 
 
tab:Line() 
tab:Button("Get Teddy", function() 
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("TeddyBloxpin")
end)
 
tab:Line() 
tab:Button("Get Sword", function() 
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("LinkedSword")
end)
 
tab:Line()
tab:Button("Get Lollipop", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Lollipop")
end)
 
tab:Line()
tab:Button("Get Key", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Key")
end)
 
tab:Line()
tab:Button("Get Hammer", function()
local A_1 = true
local A_2 = "Hammer"
local Event = game:GetService("ReplicatedStorage").RemoteEvents.BasementWeapon
Event:FireServer(A_1, A_2)
end)
 
tab:Line()
tab:Button("Get Planks", function()
    game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Plank")
end)
 
local tab = win:Tab("Role")
local label = tab:Label("Label", properties)
label:NewLabel("This is only meant for lobby", properties)
tab:Line() 
tab:Button("Police", function() 
    local A_1 = "Gun"
local A_2 = true
local Event = game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole
Event:FireServer(A_1, A_2)
end) 
 
tab:Line() 
tab:Button("Swat", function() 
    local A_1 = "SwatGun"
local A_2 = true
local Event = game:GetService("ReplicatedStorage").RemoteEvents.OutsideRole
Event:FireServer(A_1, A_2)
end)
 
local tab = win:Tab("Teleport")
local label = tab:Label("Label", properties)
label:NewLabel("Teleport Section", properties)
tab:Line() 
tab:Button("Basement", function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(71, -15, -163)
end)
 
tab:Line() 
tab:Button("House", function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-36, 3, -200)
end)
 
tab:Line() 
tab:Button("Hiding Spot", function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-42.86656951904297, 6.433286666870117, -222.01171875)
end)
 
tab:Line() 
tab:Button("Attic", function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16, 35, -220)
end)
 
tab:Line() 
tab:Button("Store", function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-422, 3, -121)
end)
 
tab:Line() 
tab:Button("Sewer", function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(129, 3, -125)
end)
 
tab:Line() 
tab:Button("Boss Room", function() 
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, -287, -1480)
end)
 
local tab = win:Tab("Misc")
local label = tab:Label("Label", properties)
label:NewLabel("Misc Section", properties) 
tab:Line()
tab:Button("Kill Enemies", function()
    for i,v in pairs(game.Workspace.BadGuys:GetChildren()) do
        for i = 1, 50 do
            game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,10)
            game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,996)
            game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,9)
            game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,8)
            game:GetService("ReplicatedStorage").RemoteEvents.HitBadguy:FireServer(v,996)
        end
    end
end)
 
tab:Line()
tab:Button("Open Safe", function()            game.ReplicatedStorage.RemoteEvents.Safe:FireServer(game:GetService("Workspace").CodeNote.SurfaceGui.TextLabel.Text)
end)
 
tab:Line()
tab:Button("Heal Instantly", function()
    for i = 1, 200 do
        wait(0.005)
        local A_1 = "Cat"
        local Event = game:GetService("ReplicatedStorage").RemoteEvents.Energy
        Event:FireServer(A_1)
    end
end)
 
tab:Line()
tab:Button("Drop Tool", function(Drop)
    loadstring(game:HttpGet("https://pastebin.com/raw/ZYXmS4Sb"))(Drop) 
end)
 
tab:Line()
tab:Button("Be Friends with Cat", function()
    local Target = game:GetService("ReplicatedStorage").RemoteEvents.Cattery;
    Target:FireServer();
end)
 
local tab = win:Tab("Other")
local label = tab:Label("Label", properties)
label:NewLabel("Other Scripts", properties) 
 
tab:Line()
tab:Button("Fly Gui", function(e)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Pro69Yes/sussy-Script/main/SecuredFlyGuiv3.lua'))(e)
end)
 
tab:Line()
tab:Button("get all badge jk", function(e)
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
game.ReplicatedStorage.RemoteEvents.GiveTool:FireServer("Chips")
end)
