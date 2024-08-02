local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/Dynissimo/main/Scripts/AkaliNotif.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "da hood macro script press x to macro my discord is removedxd report any bugs!";
Title = "made by piter";
Duration = 15;
});
getgenv().Speed = true
getgenv().FakeMacro = true
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://413861777"
	sound.Parent = game:GetService("SoundService")
	sound:Play()
              u can change ur sets here!
getgenv().prediction = 0 --------- put ur preiction here
getgenv().offset = 0 ------- put ur jump offset 0-0.10
getgenv().resolver = false -------- relosve antilocks `put "true" to trun it on`
getgenv().smoothness = 1 ------- smoothenss for ur camlock `defalut is 1`

local players = game:GetService("Players")
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()
local userinputservice = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local currentCamera = workspace.CurrentCamera

local victim = nil
local targeting = false

local function target()
local target = nil
local shortdistance = math.huge

for _, v in next, workspace:GetDescendants() do
if v.Parent and v:IsA("Model") and v ~= localplayer.Character then
if v:FindFirstChildOfClass("Humanoid") then
if v:FindFirstChildOfClass("Humanoid").Health > 0 then

pcall(function()
local worldtoviewportpoint, onscreen = currentCamera:WorldToViewportPoint(v:FindFirstChildOfClass("Humanoid").RootPart.Position or v.PrimaryPart.Position)
local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(worldtoviewportpoint.X, worldtoviewportpoint.Y)).Magnitude

if math.huge > distance and distance < shortdistance and onscreen then
target = v
shortdistance = distance
end
end)
end
end
end
end
return target and (target.PrimaryPart or target:FindFirstChildOfClass("Humanoid").RootPart) ---------- put ur aimprat here
end

userinputservice.InputBegan:Connect(function(input, processed)
if processed then
return
end

if input.KeyCode == Enum.KeyCode.C then ---------- change ur keybind here
targeting = not targeting

if targeting then
victim = target()
else
if victim ~= nil then
victim = nil
end
end
end
end)

local velocity = Vector3.new(0,0,0)
local oldpos = Vector3.new(0,0,0)

runservice.Heartbeat:Connect(function(deltaTime)
if victim and victim.Parent then
local currentpos = victim.Position
local displacement = currentpos - oldpos

local vector = displacement / deltaTime

velocity = velocity:Lerp(Vector3.new(
vector.X,
vector.Y*0.94*getgenv().offset,
vector.Z
), 0.4)

oldpos = currentpos
end
end)

runservice.RenderStepped:Connect(function()
local pos

if targeting and victim and victim.Parent then
if victim.Parent:FindFirstChildOfClass("Humanoid") then
if victim.Parent:FindFirstChildOfClass("Humanoid").Health > 0 then

if getgenv().usePrediction then
if getgenv().resolver then
pos = Vector3.new(
victim.Position.X,
victim.Position.Y,
victim.Position.Z) + (velocity * getgenv().prediction)
else
pos = Vector3.new(
victim.Position.X,
victim.Position.Y,
victim.Position.Z) + (victim.velocity * getgenv().prediction)
end
else
pos = Vector3.new(victim.Position.X,
victim.Position.Y,
victim.Position.Z)
end

currentCamera.CFrame = currentCamera.CFrame:Lerp(CFrame.new(currentCamera.CFrame.Position, pos), getgenv().smoothness)
end
end
end
end)
