local DataTypes = {
	Axes = Axes.new(),
	BrickColor = BrickColor.Random(),
	CellId = CellId.new(),
	CFrame = CFrame.identity,
	CatalogSearchParams = CatalogSearchParams.new(),
	Color3 = Color3.new(),
	ColorSequence = ColorSequence.new(Color3.new()),
	ColorSequenceKeypoint = ColorSequenceKeypoint.new(0, Color3.new()),
	Content = Content.none,
	DateTime = DateTime.now(),
	DockWidgetPluginGuiInfo = DockWidgetPluginGuiInfo.new(),
	Enum = Enum:GetEnums()[1],
	EnumItem = Enum:GetEnums()[1]:GetEnumItems()[1],
	Enums = Enum,
	Faces = Faces.new(),
	FloatCurveKey = FloatCurveKey.new(0, 1, Enum.KeyInterpolationMode:GetEnumItems()[1]),
	Font = Font.fromEnum(Enum.Font:GetEnumItems()[1]),
	Instance = game:GetService("RunService"),
	NumberSequence = NumberSequence.new(0),
	NumberSequenceKeypoint = NumberSequenceKeypoint.new(0, 1),
	OverlapParams = OverlapParams.new(),
	PathWaypoint = PathWaypoint.new(Vector3.zero, Enum.PathWaypointAction:GetEnumItems()[1]),
	PluginDrag = PluginDrag.new(),
	RBXScriptConnection = (function()
		local Connection = game.ChildAdded:Once(function() end)
		Connection:Disconnect()
		
		return Connection
	end)(),
	RBXScriptSignal = game.ChildAdded,
	Random = Random.new(),
	Ray = Ray.new(Vector3.zero, Vector3.zero),
	RaycastParams = RaycastParams.new(),
	Rect = Rect.new(),
	Region3 = Region3.new(),
	Region3int16 = Region3int16.new(),
	SecurityCapabilities = SecurityCapabilities.fromCurrent(),
	SharedTable = SharedTable.new(),
	TweenInfo = TweenInfo.new(),
	UDim = UDim.new(),
	UDim2 = UDim2.new(),
	Vector2 = Vector2.new(),
	Vector2int16 = Vector2int16.new(),
	Vector3 = vector.zero,
	Vector3int16 = Vector3int16.new(),
	boolean = {
		["true"] = true,
		["false"] = false,
	},
	buffer = buffer.create(1),
	["function"] = {
		Lua = function() end,
		C = print
	},
	table = {
		Empty = {},
		Frozen = table.freeze({}),
		Array = {1,2,3},
		Dictionary = {
			["1"] = true,
			["2"] = true,
			["3"] = true
		},
		Mix = {
			1,
			2,
			3,
			["1"] = true,
			["2"] = true,
			["3"] = true
		},
		Cyclic = (function()
			local tbl = {}
			tbl[tbl] = tbl
			
			return tbl
		end)(),
		metatable = setmetatable({1,2,3}, {__index = {4, 5, 6}})
	},
	number = {
		int = 1,
		nan = tonumber("nan"),
		infinite = math.huge,
		negative_infinite = -math.huge
	},
	string = {
		normal = "normal string",
		special_characters = "\a\b\t\t\v\f\r",
		special_case = "\8"..4,
		UTF8 = utf8.char(256)
	},
	thread = coroutine.create(function() end),
	userdata = {
		metatable = newproxy(true),
		empty = newproxy(false)
	}
}
