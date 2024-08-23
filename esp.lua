local AkaliNotif = loadstring(game:HttpGet("https://raw.githubusercontent.com/PiterNaGitHub/PiterNaGitHub/main/text.lua"))();
local Notify = AkaliNotif.Notify;
Notify({
Description = "shutdown.";
Title = "bye.";
Duration = 15;
});
getgenv().Speed = true
getgenv().FakeMacro = true
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://413861777"
	sound.Parent = game:GetService("SoundService")
	sound:Play()
