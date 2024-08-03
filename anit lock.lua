local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/PiterNaGitHub/PiterNaGitHub/main/text.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "antilock success executed press z to antilock report any bugs to our discord server: https://discord.gg/k93hppJwEm";
Title = "made by piter";
Duration = 15;
});
getgenv().Speed = true
getgenv().FakeMacro = true
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://413861777"
	sound.Parent = game:GetService("SoundService")
	sound:Play()
local Toggled = true

local KeyCode = 'z'
local hip = 2.50
local val = -35





function AA()
  local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
  game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z)
  game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
  game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z)
  game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip
end

game:GetService('UserInputService').InputBegan:Connect(function(Key)
  if Key.KeyCode == Enum.KeyCode[KeyCode:upper()] and not game:GetService('UserInputService'):GetFocusedTextBox() then
      if Toggled then
          Toggled = false
          game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip

      elseif not Toggled then
          Toggled = true

          while Toggled do
              AA()
              task.wait()
          end
      end
  end
end)
