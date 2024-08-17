--[[
	Chat Color Calculator can be found: C:\Users\%Username%\AppData\Local\Roblox\Versions\whateverrobloxversionitis\ExtraContent\scripts\CoreScripts\Modules\Server\ServerChat\DefaultChatModules
]]

if FakeChatStorage and FakeChatStorage.UI and FakeChatStorage.Connections then
	FakeChatStorage.UI:Destroy()
	for i,v in next, FakeChatStorage.Connections do
		v:Disconnect()
	end
end

getgenv().FakeChatStorage = {Connections = {},UI = nil}
local setthreadlevel = syn and syn.set_thread_identity or set_thread_identity or setidentity or setthreadidentity
local getthreadlevel = syn and syn.get_thread_identity or get_thread_identity or getidentity or getthreadidentity

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ChatService = game:GetService("Chat")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local rs = game:GetService('RunService')
if not Players.LocalPlayer then
	Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
end
local lp = Players.LocalPlayer
local connections = FakeChatStorage.Connections
local plrlist = {}

connections["OnJoin"] = Players.PlayerAdded:Connect(function(plr)
	plrlist[plr] = plr
end)

connections["OnLeave"] = Players.PlayerRemoving:Connect(function(plr)
	plrlist[plr] = nil
end)

for i,v in next, Players:GetPlayers() do
	plrlist[v] = v
end

local function Create(instance, properties, children)
    local obj = Instance.new(instance)

    for i, v in next, properties or {} do
        obj[i] = v
        for _, child in next, children or {} do
            child.Parent = obj;
        end
    end
    return obj;
end

local NAME_COLORS = {
	Color3.new(253/255,41/255,67/255),
	Color3.new(1/255,162/255,255/255),
	Color3.new(2/255,184/255,87/255),
	BrickColor.new("Bright violet").Color,
    BrickColor.new("Bright orange").Color,
	BrickColor.new("Bright yellow").Color,
    BrickColor.new("Light reddish violet").Color,
	BrickColor.new("Brick yellow").Color
}

local function GetNameValue(pName)
	local value = 0

	for index = 1,#pName do
		local cValue = string.byte(string.sub(pName,index,index))
		local reverseIndex = #pName - index + 1
		if #pName%2 == 1 then
			reverseIndex = reverseIndex - 1
		end
		if reverseIndex%4 >= 2 then
			cValue = - cValue
		end
		value = value + cValue
		end
	return value
end

local function nameValue(pName)
	return NAME_COLORS[(GetNameValue(pName) % #NAME_COLORS) + 1]
end

local function fakechat(plr,msg,whisper)	
	local plrname = plr.Name
			
	local data = {
		ID = math.random(),
		FromSpeaker = plr.DisplayName,
		SpeakerUserId = plr.UserId,
		OriginalChannel = whisper and "From "..plrname or "All",
		IsFiltered = true,
		MessageLength = string.len(msg),
		Message = msg,
		MessageType = "Message",
		Time = os.time()+10,
		ExtraData = plr.Team and plr.Team.TeamColor.Color or {NameColor = nameValue(plrname)}
	}

    if plr and plr.Character and plr.Character:FindFirstChild("Head") then
        ChatService:Chat(plr.Character:FindFirstChild("Head"),msg,0)
    end

    return data
end

local classtypes = {
	['me'] = function()
		return {lp}
	end,
    ["others"] = function()
		local plrlistCache = plrlist
		plrlistCache[lp] = nil
		return plrlistCache
	end,
    ["all"] = function()
		return plrlist
	end
}

local function getPlayer(str)
	local targs = {}
	if classtypes[str:lower()] then
		return classtypes[str:lower()]()
	end
	for i,v in next, plrlist do
		if v.Name:lower():sub(1, #str) == str:lower() or v.DisplayName:lower():sub(1,#str) == str:lower() then
			table.insert(targs, v)
		end
	end
	return targs
end

local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents")
local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest")
local OnMessageDoneFilteringOnClientEvent = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering").OnClientEvent

local function fireevent(signal,data)
    local old = getthreadlevel()
    setthreadlevel(4)
    firesignal(signal,data)
    setthreadlevel(old)
end

local cmdlist = {
    ["fakechat"] = function(msg,args,cmd,fakemessage)
        local target = getPlayer(args[2])
        for i,v in next, target do
            fireevent(OnMessageDoneFilteringOnClientEvent,fakechat(v,fakemessage,false))
        end
    end,
    ["fakewhisper"] = function(msg,args,cmd,fakemessage)
        local target = getPlayer(args[2])
        for i,v in next, target do
            fireevent(OnMessageDoneFilteringOnClientEvent,fakechat(v,fakemessage,true))
        end
    end
}
cmdlist["fw"] = cmdlist["fakewhisper"]
cmdlist['fc'] = cmdlist["fakechat"]

FakeChatStorage.UI = Create("ScreenGui",{ResetOnSpawn = false,Parent = (gethui and gethui()) or CoreGui:FindFirstChildWhichIsA("ScreenGui") or CoreGui})
local UI = FakeChatStorage.UI
local CmdBarBackground = Create("Frame",{Parent = UI,BackgroundColor3 = Color3.fromRGB(0,0,0),BorderSizePixel = 0,Position = UDim2.new(0.5, -210, 1, 0),Size = UDim2.new(0, 420, 0, 40)})
local Main = Create("Frame",{Parent = CmdBarBackground,BackgroundTransparency = 1,Position = UDim2.new(0, 2, 0, 2),Size = UDim2.new(1, -4, 1, -4)})
local TextBox = Create("TextBox",{Parent = Main,BackgroundColor3 = Color3.fromRGB(81,87,98),BorderSizePixel = 0,BackgroundTransparency = 0.5,Size = UDim2.new(1, 0, 1, 0),Font = Enum.Font.Ubuntu,Text = "",TextColor3 = Color3.fromRGB(200,200,200),TextScaled = true,TextSize = 14.000,TextWrapped = true})
Create("UICorner",{CornerRadius = UDim.new(0, 5),Parent = CmdBarBackground})
Create("UICorner",{CornerRadius = UDim.new(0, 5),Parent = Main})


local info = TweenInfo.new(0.5, Enum.EasingStyle.Bounce)
local show = TweenService:Create(CmdBarBackground, info, {Position = UDim2.new(0.5, -CmdBarBackground.AbsoluteSize.X/2, 0.9, -60)})
local hide = TweenService:Create(CmdBarBackground, info, {Position = UDim2.new(0.5, -CmdBarBackground.AbsoluteSize.X/2, 1, 0)})
local tweening = false

function toggle()
    if not tweening then
        tweening = true
        if CmdBarBackground.Position.X.Offset == 0 then
            hide:Play()
            TextBox:ReleaseFocus()
            TextBox.Text = ''
            hide.Completed:Wait()
        else
            show:Play()
            TextBox:CaptureFocus()
            show.Completed:Wait()
        end
        tweening = false
    end
end

TextBox.FocusLost:Connect(function(enterPressed)
    tweening = true
    if enterPressed then
        local originalstring = TextBox.Text
        local args = originalstring:split(' ')
		if args[2] then
			local cmd = args[1]:lower()
			if #cmd+#args[2]+3 <= #originalstring then
				local msg = originalstring:sub(#cmd+#args[2]+3,#originalstring)
				
				if cmdlist[cmd] then
					cmdlist[cmd](originalstring,args,cmd,msg)
				end
			end
		end
    end
    hide:Play()
    TextBox:ReleaseFocus()
    TextBox.Text = ''
    hide.Completed:Wait()
    tweening = false
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local key = input.KeyCode
            if key == (prefix or Enum.KeyCode.Quote) then
				rs.Heartbeat:Wait()
                toggle()
            end
        end
    end
end)

local a = Instance.new("Hint",CoreGui)
a.Text = "Fixed the command bar opening with every button pressed (forgot to add '()')"
task.delay(10,function()
a:Destroy()
end)
