-- It's not necessarily "secure" but it gets the job done as Federal said he really didnt have any plans on fixing it

local RunService = game:GetService("RunService") do
	assert(RunService:IsServer() and RunService:IsStudio(), "MoonSec V3 Encrypted Dumper must be ran on the server/in studio")
	if not pcall(loadstring, "") then
		error("Loadstring must be enabled to dump MoonSec V3 Encrypted")
	end
end

local DataToCode do
	local DataToCode_request, DataToCode_source = pcall(function()
		return game:GetService("HttpService"):GetAsync("https://raw.githubusercontent.com/78n/Roblox/refs/heads/main/Lua/Libraries/DataToCode/DataToCode.luau")
	end)
	assert(DataToCode_request, "An error occured when retrieving the DataToCode source (try saving as a plugin): "..DataToCode_source)

	local CompiledDataToCode = loadstring(DataToCode_source, "DataToCode")
	DataToCode = CompiledDataToCode()
end

local Location = game:GetService("HttpService"):GenerateGUID(false)
local ScriptEditor = game:GetService("ScriptEditorService")
local shared = shared
shared[Location] = DataToCode

function DataToCode.output(tbl)
	shared[Location] = nil
	local Serialized = DataToCode.Convert(tbl, true)
	local DisplayScript = Instance.new("LocalScript", game)
	DisplayScript.Name = "Dumped_"..math.floor(os.clock())

	ScriptEditor:UpdateSourceAsync(DisplayScript, function()
		return Serialized
	end)

	ScriptEditor:OpenScriptDocumentAsync(DisplayScript)
end

local setfenv, error, loadstring, type, info = setfenv, error, loadstring, type, debug.info -- localizing so it doesnt retrieve it from the enviornment
local CClosures = {}

local function newcclosure(func)
	CClosures[func] = "C"

	return func
end

local function islclosure(func)
	return info(func, "l") ~= -1
end

local env = getfenv()

env.setfenv = newcclosure(function(func, ...)
	if type(func) == "function" then -- This is how they check if a function is a CClosure
		error("'setfenv' cannot change environment of given object")
	end

	return setfenv(func, ...)
end)

env.debug = (function()
	local newdebug = table.clone(debug) -- They retrieve it weird

	newdebug.getinfo = newcclosure(function(func) -- Encrypted only checks the 'what'
		return {
			what = CClosures[func] or islclosure(func) and "Lua" or "C"
		}
	end)

	return newdebug
end)()

env.loadstring = newcclosure(function(code : string, chunkname : string, ...)
	if type(code) == "string" then
		local Start,End,Pattern,Constants = code:find("([%a_][%w_]*%([%a_][%w_]*%((.)%)%))")

		if Constants then
			local Start, End, Reassign, Variable, full, Constants = code:find("([^%s]([%a_][%w_]*)[%s]*=[%s]*)([%a_][%w_]*%([%a_][%w_]*%((.)%)%)).-return %2%(%.%.%.%)")

			if not Start then
				Start, End, Reassign, Variable, full, Constants = code:find("(([%a_][%w_]*)[%s]*=[%s]*)([%a_][%w_]*%([%a_][%w_]*%((.)%)%)).-return %2%(%.%.%.%)") -- very lazy fix and I'm sorry :)
			end

			code = code:sub(1, Start-1+#Reassign)..`(shared["{Location}"].output({Constants}) or function() end)`..code:sub(Start+#full+3)
		end
	end

	return loadstring(code, chunkname, ...)
end);

-- Encrypted MoonSec V3 script here
