local DataTypes = require("./DataTypes")
local DataToCode = require("./DataToCode")

DataToCode.Convert(DataTypes, false) -- {DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 0, 0, 0, 0), string = {normal = "normal string", special_characters = "\a\b\t\t\v\f\r", UTF8 = "\196\128", special_case = "\b4"}, CellId = CellId.new(), CFrame = CFrame.identity, DateTime = DateTime.fromUnixTimestampMillis(1742176886935), table = {Dictionary = {["1"] = true, ["3"] = true, ["2"] = true}, Mix = {1, 2, 3, ["1"] = true, ["3"] = true, ["2"] = true}, metatable = {1, 2, 3}, Cyclic = {["<Table> (table: 0xb54d8b030589b655)"] = *** cycle table reference detected ***}, Empty = {}, Array = {1, 2, 3}, Frozen = table.freeze({})}, TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0), UDim = UDim.new(0, 0), Vector3int16 = Vector3int16.new(0, 0, 0), NumberSequence = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 0, 0)}), RBXScriptConnection = (nil --[[ RBXScriptConnection | IsConnected: false ]]), CatalogSearchParams = CatalogSearchParams.new(), Enums = Enums, Enum = Enums.AccessModifierType, Faces = Faces.new(), OverlapParams = OverlapParams.new(), number = {negative_infinite = -1/0, nan = 0/0, int = 1, infinite = 1/0}, Region3 = Region3.new(vector.zero, vector.zero), Vector2int16 = Vector2int16.new(0, 0), buffer = buffer.fromstring("\0"), boolean = {["true"] = true, ["false"] = false}, ColorSequence = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))}), PathWaypoint = PathWaypoint.new(vector.zero, Enum.PathWaypointAction.Walk, ""), thread = coroutine.create(function() end), ["function"] = {Lua = function() end, C = print}, Vector3 = vector.zero, userdata = {empty = newproxy(false), metatable = newproxy(true)}, Vector2 = Vector2.new(0, 0), UDim2 = UDim2.new(0, 0, 0, 0), Rect = Rect.new(Vector2.new(0, 0), Vector2.new(0, 0)), Random = Random.new(--[[ <Seed> ]]), SecurityCapabilities = SecurityCapabilities.new(Enum.SecurityCapability.RunClientScript, Enum.SecurityCapability.RunServerScript, Enum.SecurityCapability.AccessOutsideWrite, Enum.SecurityCapability.AssetRequire, Enum.SecurityCapability.LoadString, Enum.SecurityCapability.ScriptGlobals, Enum.SecurityCapability.CreateInstances, Enum.SecurityCapability.Basic, Enum.SecurityCapability.Audio, Enum.SecurityCapability.DataStore, Enum.SecurityCapability.Network, Enum.SecurityCapability.Physics, Enum.SecurityCapability.UI, Enum.SecurityCapability.CSG, Enum.SecurityCapability.Chat, Enum.SecurityCapability.Animation, Enum.SecurityCapability.Avatar, Enum.SecurityCapability.Input, Enum.SecurityCapability.Environment, Enum.SecurityCapability.RemoteEvent, Enum.SecurityCapability.LegacySound, Enum.SecurityCapability.Players, --[[ CapabilityControl ]]), RBXScriptSignal = (nil --[[ RBXScriptSignal | ChildAdded is not supported ]]), FloatCurveKey = FloatCurveKey.new(0, 1, Enum.KeyInterpolationMode.Constant), Region3int16 = Region3int16.new(Vector3int16.new(0, 0, 0), Vector3int16.new(0, 0, 0)), SharedTable = SharedTable.new(), Instance = game:GetService("RunService"), EnumItem = Enum.AccessModifierType.Allow, RaycastParams = RaycastParams.new(), NumberSequenceKeypoint = NumberSequenceKeypoint.new(0, 1, 0), Ray = Ray.new(vector.zero, vector.zero), Font = Font.new("rbxasset://fonts/families/LegacyArial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal), BrickColor = BrickColor.new(310), PluginDrag = PluginDrag.new("", "", "", "", "", Vector2.new(0, 0)), Content = Content.none, Axes = Axes.new(), ColorSequenceKeypoint = ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), Color3 = Color3.new(0, 0, 0)}
DataToCode.Convert(DataTypes, true) --[[
  {
  	DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(Enum.InitialDockState.Right, false, false, 0, 0, 0, 0),
  	string = {
  		normal = "normal string",
  		special_characters = "\a\b\t\t\v\f\r",
  		UTF8 = "\196\128",
  		special_case = "\b4"
  	},
  	CellId = CellId.new(),
  	CFrame = CFrame.identity,
  	DateTime = DateTime.fromUnixTimestampMillis(1742176886935),
  	table = {
  		Dictionary = {
  			["1"] = true,
  			["3"] = true,
  			["2"] = true
  		},
  		Mix = {
  			1,
  			2,
  			3,
  			["1"] = true,
  			["3"] = true,
  			["2"] = true
  		},
  		metatable = {
  			1,
  			2,
  			3
  		},
  		Cyclic = {
  			["<Table> (table: 0xb54d8b030589b655)"] = *** cycle table reference detected ***
  		},
  		Empty = {},
  		Array = {
  			1,
  			2,
  			3
  		},
  		Frozen = table.freeze({})
  	},
  	TweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0),
  	UDim = UDim.new(0, 0),
  	Vector3int16 = Vector3int16.new(0, 0, 0),
  	NumberSequence = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 0, 0)}),
  	RBXScriptConnection = (nil --[[ RBXScriptConnection | IsConnected: false ]]),
  	CatalogSearchParams = CatalogSearchParams.new(),
  	Enums = Enums,
  	Enum = Enums.AccessModifierType,
  	Faces = Faces.new(),
  	OverlapParams = OverlapParams.new(),
  	number = {
  		negative_infinite = -1/0,
  		nan = 0/0,
  		int = 1,
  		infinite = 1/0
  	},
  	Region3 = Region3.new(vector.zero, vector.zero),
  	Vector2int16 = Vector2int16.new(0, 0),
  	buffer = buffer.fromstring("\0"),
  	boolean = {
  		["true"] = true,
  		["false"] = false
  	},
  	ColorSequence = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))}),
  	PathWaypoint = PathWaypoint.new(vector.zero, Enum.PathWaypointAction.Walk, ""),
  	thread = coroutine.create(function() end),
  	["function"] = {
  		Lua = function()
  			--[[
  				info = {
  					source = "ReplicatedFirst.Folder.DataTypes",
  					line = 53,
  					what = "Lua",
  					name = "Lua",
  					numparams = 0,
  					vargs = false,
  					function = function: 0xf0b1a46ebb006425
  				}
  			]]
  		end,
  		C = print
  	},
  	Vector3 = vector.zero,
  	userdata = {
  		empty = newproxy(false),
  		metatable = newproxy(true)
  	},
  	Vector2 = Vector2.new(0, 0),
  	UDim2 = UDim2.new(0, 0, 0, 0),
  	Rect = Rect.new(Vector2.new(0, 0), Vector2.new(0, 0)),
  	Random = Random.new(--[[ <Seed> ]]),
  	SecurityCapabilities = SecurityCapabilities.new(Enum.SecurityCapability.RunClientScript, Enum.SecurityCapability.RunServerScript, Enum.SecurityCapability.AccessOutsideWrite, Enum.SecurityCapability.AssetRequire, Enum.SecurityCapability.LoadString, Enum.SecurityCapability.ScriptGlobals, Enum.SecurityCapability.CreateInstances, Enum.SecurityCapability.Basic, Enum.SecurityCapability.Audio, Enum.SecurityCapability.DataStore, Enum.SecurityCapability.Network, Enum.SecurityCapability.Physics, Enum.SecurityCapability.UI, Enum.SecurityCapability.CSG, Enum.SecurityCapability.Chat, Enum.SecurityCapability.Animation, Enum.SecurityCapability.Avatar, Enum.SecurityCapability.Input, Enum.SecurityCapability.Environment, Enum.SecurityCapability.RemoteEvent, Enum.SecurityCapability.LegacySound, Enum.SecurityCapability.Players, --[[ CapabilityControl ]]),
  	RBXScriptSignal = (nil --[[ RBXScriptSignal | ChildAdded is not supported ]]),
  	FloatCurveKey = FloatCurveKey.new(0, 1, Enum.KeyInterpolationMode.Constant),
  	Region3int16 = Region3int16.new(Vector3int16.new(0, 0, 0), Vector3int16.new(0, 0, 0)),
  	SharedTable = SharedTable.new(),
  	Instance = game:GetService("RunService"),
  	EnumItem = Enum.AccessModifierType.Allow,
  	RaycastParams = RaycastParams.new(),
  	NumberSequenceKeypoint = NumberSequenceKeypoint.new(0, 1, 0),
  	Ray = Ray.new(vector.zero, vector.zero),
  	Font = Font.new("rbxasset://fonts/families/LegacyArial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
  	BrickColor = BrickColor.new(310),
  	PluginDrag = PluginDrag.new("", "", "", "", "", Vector2.new(0, 0)),
  	Content = Content.none,
  	Axes = Axes.new(),
  	ColorSequenceKeypoint = ColorSequenceKeypoint.new(0, Color3.new(0, 0, 0)),
  	Color3 = Color3.new(0, 0, 0)
  }
]]
