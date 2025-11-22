local args = {
    [1] = false,
    [2] = 10000000000, -- Change how much money you want
    [3] = "Cash"
}

game:GetService("ReplicatedStorage").MoneyRequest:FireServer(unpack(args))