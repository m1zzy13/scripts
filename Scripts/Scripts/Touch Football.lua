local DrRayLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local window = DrRayLibrary:Load("Touch Football", "Default")
 
local tab = DrRayLibrary.newTab("Main", "ImageIdHere")
 
tab.newButton("bring ball", "brings ball to ur CFrame", function()
game:GetService("Workspace").FootballField.SoccerBall.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end)
 
tab.newButton("loopbring ball", "loop brings ball to ur CFrame", function()
while wait() do
game:GetService("Workspace").FootballField.SoccerBall.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
end)
 
tab.newButton("Goal A Team", "", function()
-- KickBall event because for GoalEvent work
 
local args = {
    [1] = Vector3.new(-213.62574768066406, 6.241994857788086, 117.22891235351562),
    [2] = Vector3.new(84.71153259277344, 34, 6.996870040893555),
    [3] = Vector3.new(0, -3.3757386207580566, 0),
    [4] = 3.379659414291382,
    [5] = "djhtelkds"
}
 
game:GetService("ReplicatedStorage").KickBall:FireServer(unpack(args))
 
wait(0.5)
-- GoalEvent
 
local args = {
    [1] = "A"
}
 
game:GetService("ReplicatedStorage").GoalEvent:FireServer(unpack(args))
 
end)
 
tab.newButton("Goal B Team", "", function()
-- KickBall event because for GoalEvent work
 
local args = {
    [1] = Vector3.new(-213.62574768066406, 6.241994857788086, 117.22891235351562),
    [2] = Vector3.new(84.71153259277344, 34, 6.996870040893555),
    [3] = Vector3.new(0, -3.3757386207580566, 0),
    [4] = 3.379659414291382,
    [5] = "djhtelkds"
}
 
game:GetService("ReplicatedStorage").KickBall:FireServer(unpack(args))
 
wait(0.5)
-- GoalEvent
 
local args = {
    [1] = "B"
}
 
game:GetService("ReplicatedStorage").GoalEvent:FireServer(unpack(args))
 
end)