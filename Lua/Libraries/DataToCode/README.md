# DataToCode
Created by: https://github.com/78n
Licensed under: https://github.com/78n/Roblox/blob/main/LICENSE
___
### 📄 Info
DataToCode is a library that converts Roblox datatypes back into usable code via their constuctors
___
### 🔨 Documentation/Usage

###### Functions
| Function | Parallel Safe | Example |
| :----------- | :----------- | :----------- |
| \<**string**\> DataToCode.Convert\<Type\>(DataStructure : **Type**, format : **boolean?**) | ✔️ | DataToCode.Convert({true}, true) |
| \<**string**\> DataToCode.ConvertKnown\<Type\>(DataType : **string**, DataStructure : **Type**, format : **boolean?**) | ✔️ | DataToCode.ConvertKnown("table", {true}, true)
| \<void\> DataToCode.print(... : **...any**) | ✔️ | DataToCode.print("example", 1, Vector3.new(10, 23, 9)) |
| \<void\> DataToCode.warn(... : **...any**) | ✔️ | DataToCode.warn("example", 1, Vector3.new(10, 23, 9)) |

###### Settings
| Setting | Type | Default |
| :----------- | :----------- | :----------- |
| __tostringUnsupported | **boolean** | **false** |
| __Serializeinf | **boolean** | **false** |

###### Editables
| Library |
| :----------- |
| Methods<**string**, **function?**> |
| Signals<**string**, **string?**> |
| Services<**string**, **string?**> |
| GlobalFunctions<**string**, **function?**> |
| DefaultTypes.Vector3<**Vector3**, **string**> |
| DefaultTypes.CFrame<**CFrame**, **string**> |

All libraries present have proper newindex checks when modifying them

###### Example
```lua
local DataToCode = require("./DataToCode")
DataToCode.__Serializeinf = true
-- DataToCode.DefaultTypes.Vector3[Vector3.new(0, 0, 0)] = "Zero Vector"
-- DataToCode.GlobalFunctions.print = "function(...) game:GetService("LogService"):Print(...) end)"

local test_table = {
    Vector = Vector3.new(0, 0, 0),
    [1] = "funny String\255"..123,
    [2] = 0/0,
    [3] = math.huge,
    [5] = {
        ["inner"] = {},
        [Vector3.new(1, 1, 1)] = false
    },
    print
}

DataToCode.Convert(test_table, false) -- {"funny String\255".."123", 0/0, math.huge, print, [5] = {inner = {}, [vector.one] = false}, Vector = vector.zero}
DataToCode.Convert(test_table, true) --[[
    {
        "funny String\255".."123",
        0/0,
        math.huge,
        print,
        [5] = {
            inner = {},
            [vector.one] = false
        },
        Vector = vector.zero
    }
]]
```


### 🚧 Supported DataTypes
✔️ Implemented | ➖ Partially Implemented | ❌ Unimplemented | 🚫 Unsupported
| DataTypes | Converted to | Supported | Static/Default |
| :----------- | :----------- | :-----------: | :-----------: |
| [Axes](https://create.roblox.com/docs/reference/engine/datatypes/Axes) | Axes.new(... : **...Enum.Axis**) | ✔️ | ✔️ |
| [BrickColor](https://create.roblox.com/docs/reference/engine/datatypes/BrickColor) | BrickColor.new(Number : **number**) | ✔️ | ❌ |
| [CellId](https://devforum.roblox.com/t/nuke-the-cellid-datatype-low-priority-trivia/360115) | CellId.new() <sub>There is no reason you should even use this</sub> | 🚫 | N/A |
| [CFrame](https://create.roblox.com/docs/reference/engine/datatypes/CFrame) | CFrame.new(X : **number**, Y : **number**, Z : **number**, R00 : **number**, R01 : **number**, R02 : **number**, R10 : **number**, R11 : **number**, R12 : **number**, R20 : **number**, R21 : **number**, R22 : **number**) | ✔️ | ✔️ |
| [CatalogSearchParams](https://create.roblox.com/docs/reference/engine/datatypes/CatalogSearchParams) | N/A | ✔️ | ✔️ |
| [Color3](https://create.roblox.com/docs/reference/engine/datatypes/Color3) | Color3.new(R : **number**, G : **number**, B : **number**) | ✔️ | ❌ |
| [ColorSequence](https://create.roblox.com/docs/reference/engine/datatypes/ColorSequence) | ColorSequence.new(ColorSequence : **{ColorSequence}**) | ✔️ | N/A |
| [ColorSequenceKeypoint](https://create.roblox.com/docs/reference/engine/datatypes/ColorSequenceKeypoint) | ColorSequenceKeypoint.new(Time : **number**, Value : **Color3**) | ✔️ | N/A |
| [Content](https://create.roblox.com/docs/reference/engine/datatypes/Content) | Content.fromUri(Uri : **string**) | ✔️ | ✔️ |
| [DateTime](https://create.roblox.com/docs/reference/engine/datatypes/DateTime) | DateTime.fromUnixTimestampMillis(UnixTimestampMillis : **number**) | ✔️ | N/A |
| [DockWidgetPluginGuiInfo](https://create.roblox.com/docs/reference/engine/datatypes/DockWidgetPluginGuiInfo) | DockWidgetPluginGuiInfo.new(InitialDockState : **Enum.InitialDockState**, InitialEnabled : **boolean**, InitialEnabledShouldOverrideRestore : **boolean**, FloatingXSize : **number**, FloatingYSize : **boolean**, MinWidth : **number**, MinHeight : **number**) | ✔️ | ❌ |
| [Enum](https://create.roblox.com/docs/reference/engine/datatypes/Enum) | Enum.**\<EnumType\>** | ✔️ | ✔️ |
| [EnumItem](https://create.roblox.com/docs/reference/engine/datatypes/EnumItem) | Enum.**\<EnumType\>**.**\<EnumName\>** | ✔️ | ✔️ |
| [Enums](https://create.roblox.com/docs/reference/engine/datatypes/Enums) | Enums | ✔️ | ✔️ |
| [Faces](https://create.roblox.com/docs/reference/engine/datatypes/Faces) | Faces.new(... : **...Enum.NormalId**) | ✔️ | ✔️ |
| [FloatCurveKey](https://create.roblox.com/docs/reference/engine/datatypes/FloatCurveKey) | FloatCurveKey.new(Time : **number**, Value : **number**, Interpolation : **Enum.KeyInterpolationMode**) | ✔️ | N/A |
| [Font](https://create.roblox.com/docs/reference/engine/datatypes/Font) | Font.new(Family : **string**, Weight : **Enum.FontWeight**, Style : **Enum.FontStyle**) | ✔️ | N/A |
| [Instance](https://create.roblox.com/docs/reference/engine/datatypes/Instance) | N/A <sub>*able to retrieve Instances that are parented under game</sub> | ➖ | N/A |
| [NumberRange](https://create.roblox.com/docs/reference/engine/datatypes/NumberRange) | NumerRange.new(Min : **number**, Max : **number**) | ✔️ | N/A |
| [NumberSequence](https://create.roblox.com/docs/reference/engine/datatypes/NumberSequence) | NumberSequence.new(KeyPoints : **{NumberSequenceKeypoint}**) | ✔️ | N/A |
| [NumberSequenceKeypoint](https://create.roblox.com/docs/reference/engine/datatypes/NumberSequenceKeypoint) | NumberSequenceKeypoint.new(Time : **number**, Value : **number**, Evelope : **number**) | ✔️ | N/A |
| [OverlapParams](https://create.roblox.com/docs/reference/engine/datatypes/OverlapParams) | N/A | ✔️ | ✔️ |
| [PathWaypoint](https://create.roblox.com/docs/reference/engine/datatypes/PathWaypoint) | PathWaypoint.new(Position : **Vector3**, Action : **Enum.WaypointAction**, Label : **string**) | ✔️ | ❌ |
| [PhysicalProperties](https://create.roblox.com/docs/reference/engine/datatypes/PhysicalProperties) | PhysicalProperties.new(Density : **number**, Friction : **number**, Elasticity : **number**, FrictionWeight : **number**, ElasticityWeight : **number**) | ✔️ | N/A |
| [PluginDrag](https://create.roblox.com/docs/reference/engine/classes/Plugin#StartDrag) | PluginDrag.new(Sender : **string**, MimeType : **string**, Data : **string**, MouseIcon : **string**, DragIcon : **string**, HotSpot : **Vector2**) | ✔️ | N/A |
| [RBXScriptConnection](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection) | (nil --\[\[ RBXScriptConnection \| IsConnected: **\<IsConnected : boolean\>** ]]) | 🚫 | N/A |
| [RBXScriptSignal](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptSignal) | (nil --\[\[ RBXScriptSignal \| **\<SignalName : string>** is not supported ]]) | 🚫 | N/A |
| [Random](https://create.roblox.com/docs/reference/engine/datatypes/Random) | Random.new(--\[\[ \<Seed\> ]]) | 🚫 | N/A |
| [Ray](https://create.roblox.com/docs/reference/engine/datatypes/Ray) | Ray.new(Orgin : **Vector3**, Direction : **Vector3**) | ✔️ | ❌ |
| [RaycastParams](https://create.roblox.com/docs/reference/engine/datatypes/RaycastParams) | N/A | ✔️ | ✔️ |
| [Rect](https://create.roblox.com/docs/reference/engine/datatypes/Rect) | Rect.new(Min : **Vector2**, Max : **Vector2**) | ✔️ | ❌ |
| [Region3](https://create.roblox.com/docs/reference/engine/datatypes/Region3) | Region3.new(Min : **Vector3**, Max **Vector3**) | ✔️ | ❌ |
| [Region3int16](https://create.roblox.com/docs/reference/engine/datatypes/Region3int16) | Region3int16.new(Min : **Vector3int16**, Max : **Vector3int16**) | ✔️ | ❌ |
| [SecurityCapabilities](https://create.roblox.com/docs/reference/engine/classes/Instance#Capabilities) | SecurityCapabilities.new(... : **...Enum.SecurityCapability**) <sub>*unable to support SecurityCapabilities.fromCurrent() as CapabilityControl is not a valid Enum</sub> | ➖ | N/A |
| [SharedTable](https://create.roblox.com/docs/reference/engine/datatypes/SharedTable) | SharedTable.new(Contents : **{[string \| number] : any?\*}**) **\***<sub>Serializable data</sub> | ✔️ | ✔️ |
| [TweenInfo](https://create.roblox.com/docs/reference/engine/datatypes/TweenInfo) | TweenInfo.new(Time : **number**, EasingStyle : **Enum.EasingStyle**, EasingDirection : **Enum.EasingDirection**, RepeatCount : **number**, Reverses : **boolean**, DelayTime : **number**) | ✔️ | ❌ |
| [UDim](https://create.roblox.com/docs/reference/engine/datatypes/UDim) | UDim.new(Scale : **number**, Offset : **number**) | ✔️ | ❌ |
| [UDim2](https://create.roblox.com/docs/reference/engine/datatypes/UDim2) | UDim2.new(xScale : **number**, xOffset : **number**, yScale : **number**, yOffset : **number**) | ✔️ | ❌ |
| [Vector2](https://create.roblox.com/docs/reference/engine/datatypes/Vector2) | Vector2.new(X : **number**, Y : **number**) | ✔️ | ❌ |
| [Vector2int16](https://create.roblox.com/docs/reference/engine/datatypes/Vector2int16) | Vector2int16.new(X : **number**, Y : **number**) | ✔️ | ❌ |
| [Vector3](https://create.roblox.com/docs/reference/engine/datatypes/Vector3) | Vector3.new(X : **number**, Y : **number**, Z : **number**) | ✔️ | ✔️ |
| [Vector3int16](https://create.roblox.com/docs/reference/engine/datatypes/Vector3int16) | Vector3int16.new(X : **number**, Y : **number**, Z : **number**) | ✔️ | ❌ |
| [boolean](https://create.roblox.com/docs/luau/booleans) | **true** / **false** | ✔️ | N/A |
| [buffer](https://create.roblox.com/docs/reference/engine/libraries/buffer) | buffer.fromstring(str : **string**) | ✔️ | N/A |
| [function](https://create.roblox.com/docs/luau/functions) | N/A | 🚫 | N/A |
| [table](https://create.roblox.com/docs/luau/table) | {[any] : any?} <sub>*No support for cyclic and key tables</sub> | ✔️ | N/A |
| [nil](https://create.roblox.com/docs/luau/nil) | **nil** | ✔️ | N/A |
| [number](https://create.roblox.com/docs/luau/numbers) | **\<number\>** / **0/0** / **math.huge** \| **1/0** / **-math.huge** \| **1/0** | ✔️ | ✔️ |
| [string](https://create.roblox.com/docs/luau/strings) | **\<string\>** | ✔️ | N/A |
| [thread](https://create.roblox.com/docs/reference/engine/libraries/coroutine) | N/A | 🚫 | N/A |
| [userdata](https://create.roblox.com/docs/luau/userdata) | **newproxy(true)** / **newproxy(false)** | 🚫 | N/A |
