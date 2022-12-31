--ZetaPlayerParameters.lua
--Purpose: Any Player.* based funcs that initialize or register.
local this={}
function this.GetCamoTable()
	local ret = {
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},
		{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	}
	return ret
end
function this.GetPlayerFuncCallbackTable()
	local ret = {
		"StartCameraAnimation",
		"StartCameraAnimationNoRecover",
		"StartCameraAnimationNoRecoverNoCollsion",
		"StartCameraAnimationForSnatchWeapon",
		"StopCameraAnimation",
		"StartCureDemoEffectStart",
		"SetCameraNoise",
		"SetCameraNoiseElude",
		"SetCameraNoiseLadder",
		"SetCameraNoiseDamageBend",
		"SetCameraNoiseDamageBlow",
		"SetCameraNoiseDamageDeadStart",
		"SetCameraNoiseFallDamage",
		"SetCameraNoiseDashToWallStop",
		"SetCameraNoiseStepOn",
		"SetCameraNoiseStepDown",
		"SetCameraNoiseStepJumpEnd",
		"SetCameraNoiseStepJumpToElude",
		"SetCameraNoiseVehicleCrash",
		"SetCameraNoiseCqcHit",
		"SetCameraNoiseOnMissileFire",
		"SetCameraNoiseOnRideOnAntiAircraftGun",
		"SetCameraNoiseEndCarry",
		"SetHighSpeeCameraOnCQCDirectThrow",
		"SetHighSpeeCameraOnCQCComboFinish",
		"SetHighSpeeCameraAtCQCSnatchWeapon"
	}
	return ret
end
function this.GetPlayerCallBackScript()
	local cbScript = {
		StartCameraAnimation=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._StartCameraAnimation(unkP1,unkP2,fileSet,true,false,unkP3,false,true)
		end,
		StartCameraAnimationNoRecover=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._StartCameraAnimation(unkP1,unkP2,fileSet,false,false,unkP3,true)
		end,
		StartCameraAnimationNoRecoverNoCollsion=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._StartCameraAnimation(unkP1,unkP2,fileSet,false,true,unkP3)
		end,
		StartCameraAnimationForSnatchWeapon=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		end,
		StopCameraAnimation=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		Player.RequestToStopCameraAnimation{fileSet=fileSet}
		end,
		StartCureDemoEffectStart=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		end,
		SetCameraNoise=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(level,level,time)
		end,
		SetCameraNoiseLadder=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.2,.2,.1)
		end,
		SetCameraNoiseElude=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.2,.2,.1)
		end,
		SetCameraNoiseDamageBend=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.2)
		end,
		SetCameraNoiseDamageBlow=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.5)
		end,
		SetCameraNoiseDamageDeadStart=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.45,.45,.52)
		end,
		SetCameraNoiseFallDamage=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(1,.4,.5)
		end,
		SetCameraNoiseDashToWallStop=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.2)
		end,
		SetCameraNoiseStepOn=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.3,.3,.1)
		end,
		SetCameraNoiseStepDown=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		local levelX=0
		local levelY=0
		if(level>0)then
			levelX=level
			levelY=level*.25
		else
			levelX=.225
			levelY=.057
		end
		TppPlayer2CallbackScript._SetCameraNoise(levelX,levelY,.11)
		end,
		SetCameraNoiseStepJumpEnd=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		local levelX=0
		local levelY=0
		if(level>0)then
			levelX=level
			levelY=level*.25
		else
			levelX=.225
			levelY=.057
		end
		TppPlayer2CallbackScript._SetCameraNoise(levelX,levelY,.2)
		end,
		SetCameraNoiseStepJumpToElude=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.4,.4,.4)
		end,
		SetCameraNoiseVehicleCrash=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.5)
		end,
		SetCameraNoiseCqcHit=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		TppPlayer2CallbackScript._SetCameraNoise(.5,.5,.4)
		end,
		SetCameraNoiseEndCarry=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		local levelX=.25
		local levelY=.25
		local time=.15
		local decayRate=.05
		Player.RequestToSetCameraNoise{levelX=levelX,levelY=levelY,time=time,decayRate=decayRate}
		end,
		SetCameraNoiseOnMissileFire=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		local levelX=.5
		local levelY=.5
		local time=.75
		local decayRate=.08
		Player.RequestToSetCameraNoise{levelX=levelX,levelY=levelY,time=time,decayRate=decayRate}
		end,
		SetCameraNoiseOnRideOnAntiAircraftGun=function(unkP1,unkP2,unkP3,unkP4,unkP5,level,time,unkP8,fileSet,unkP10,unkP11)
		local levelX=.2
		local levelY=.2
		local time=.3
		local decayRate=.08
		Player.RequestToSetCameraNoise{levelX=levelX,levelY=levelY,time=time,decayRate=decayRate}
		end,
		SetNonAnimationCutInCameraFallDeath=function()
		end,
		SetHighSpeeCameraOnCQCDirectThrow=function()
		end,
		SetHighSpeeCameraOnCQCComboFinish=function()
		TppSoundDaemon.PostEvent"sfx_s_highspeed_cqc"
		TppPlayer2CallbackScript._SetHighSpeedCamera(.6,.03)
		end,
		SetHighSpeeCameraAtCQCSnatchWeapon=function()
		TppSoundDaemon.PostEvent"sfx_s_highspeed_cqc"
		TppPlayer2CallbackScript._SetHighSpeedCamera(1,.1)
		end,
		defaultStopPlayingByCollision=false,
		defaultEnableCamera={PlayerCamera.Around,PlayerCamera.Vehicle},
		defaultInterpTimeToRecoverOrientation=.24,
		defaultStopRecoverInterpByPadOperation=true,
		defaultInterpType=2,
		_StartCameraAnimation=function(unkP1,unkP2,fileSet,_recoverPreOrientation,ignoreCollisionCheckOnStart,unkP6,isRiding,unkP7)
		local startFrame=(unkP2-unkP1)+unkP6
		local recoverPreOrientation=_recoverPreOrientation
		if(((StringId.IsEqual(fileSet,"CureGunShotWoundBodyLeft")or StringId.IsEqual(fileSet,"CureGunShotWoundBodyRight"))or StringId.IsEqual(fileSet,"CureGunShotWoundBodyCrawl"))or StringId.IsEqual(fileSet,"CureGunShotWoundBodySupine"))then
			Player.SetFocusParamForCameraAnimation{aperture=3,focusDistance=.6}
		end
		Player.RequestToPlayCameraAnimation{
			fileSet=fileSet,
			startFrame=startFrame,
			ignoreCollisionCheckOnStart=ignoreCollisionCheckOnStart,
			recoverPreOrientation=recoverPreOrientation,
			isRiding=isRiding,
			stopPlayingByCollision=true,
			enableCamera=TppPlayer2CallbackScript.defaultEnableCamera,
			interpTimeToRecoverOrientation=TppPlayer2CallbackScript.defaultInterpTimeToRecoverOrientation,
			stopRecoverInterpByPadOperation=TppPlayer2CallbackScript.defaultStopRecoverInterpByPadOperation,
			interpType=TppPlayer2CallbackScript.defaultInterpType
		}
		end,
		
		_StartCameraAnimationUseFileSetName=function(unkP1,unkP2,fileSetName,_recoverPreOrientation,ignoreCollisionCheckOnStart)
		local startFrame=unkP2-unkP1
		local recoverPreOrientation=_recoverPreOrientation
		if(fileSetName=="CqcSnatchAssaultRight"or fileSetName=="CqcSnatchAssaultLeft")then
			Player.SetFocusParamForCameraAnimation{aperture=20}
		end
		Player.RequestToPlayCameraAnimation{
			fileSetName=fileSetName,
			startFrame=startFrame,
			ignoreCollisionCheckOnStart=ignoreCollisionCheckOnStart,
			recoverPreOrientation=recoverPreOrientation,
			stopPlayingByCollision=TppPlayer2CallbackScript.defaultStopPlayingByCollision,
			enableCamera=TppPlayer2CallbackScript.defaultEnableCamera,
			interpTimeToRecoverOrientation=TppPlayer2CallbackScript.defaultInterpTimeToRecoverOrientation,
			stopRecoverInterpByPadOperation=TppPlayer2CallbackScript.defaultStopRecoverInterpByPadOperation,
			interpType=TppPlayer2CallbackScript.defaultInterpType
		}
		end,
		_SetCameraNoise=function(levelX,levelY,time)
		local _levelX=levelX
		local _levelY=levelY
		local _time=time
		local decayRate=.15
		Player.RequestToSetCameraNoise{levelX=_levelX,levelY=_levelY,time=_time,decayRate=decayRate}
		end,
		_SetHighSpeedCamera=function(decayRate,timeRate)
		HighSpeedCamera.RequestEvent{
			continueTime=decayRate,
			worldTimeRate=timeRate,
			localPlayerTimeRate=timeRate,
			timeRateInterpTimeAtStart=0,
			timeRateInterpTimeAtEnd=0,
			cameraSetUpTime=0
		}
		end
	}
	return cbScript
end
function this.GetAnimPathTable()
	local ret = {
		{name="CqcStandThrowFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_f_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_f_02.cani"},recoverPreOrientation=false},
		{name="CqcStandThrowBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_b_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_b_02.cani"},recoverPreOrientation=false},
		{name="CqcStandThrowRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_r_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_r_02.cani"},recoverPreOrientation=false},
		{name="CqcStandThrowLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_l_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_thw_s_com_l_02.cani"},recoverPreOrientation=false},
		{name="CqcBehindThrowStandFrontLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_beh_l_thw_ef_01.cani"}},
		{name="CqcBehindThrowStandFrontRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_beh_r_thw_ef_01.cani"}},
		{name="CqcBehindThrowStandBackLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_beh_l_thw_eb_01.cani"}},
		{name="CqcBehindThrowStandBackRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_beh_r_thw_eb_01.cani"}},
		{name="CqcBehindThrowSquatFrontLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_beh_l_thw_ef_01.cani"}},
		{name="CqcBehindThrowSquatFrontRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_beh_r_thw_ef_01.cani"}},
		{name="CqcBehindThrowSquatBackLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_beh_l_thw_eb_01.cani"}},
		{name="CqcBehindThrowSquatBackRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_beh_r_thw_eb_01.cani"}},
		{name="CqcBehindCovetThrowSquatLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_lbh_l_thw_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_lbh_l_thw_02.cani"}},
		{name="CqcBehindCovetThrowSquatRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_lbh_r_thw_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_q_lbh_r_thw_02.cani"}},
		{name="CqcSeizeThrowFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cke_nea_thw_f_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cke_nea_thw_f_02.cani"},recoverPreOrientation=false},
		{name="CqcSeizeThrowBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cke_nea_thw_b_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cke_nea_thw_b_02.cani"},recoverPreOrientation=false},
		{name="CqcSnatchAssaultLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_hld_asr_f_01.cani"},recoverPreOrientation=false},
		{name="CqcSnatchAssaultRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_hld_asr_f_02.cani"},recoverPreOrientation=false},
		{name="CqcComboFinishFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_new_com_asr_f5_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_new_com_asr_f5_02.cani"},recoverPreOrientation=false},
		{name="CqcComboFinishBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_new_com_asr_b3_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_new_com_asr_b3_02.cani"},recoverPreOrientation=false},
		{name="CqcLadderFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_lad_r_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_lad_r_02.cani"}},
		{name="CqcLadderBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_lad_l_b_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_lad_l_b_02.cani"}},
		{name="CqcWallThrowCommon",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_com_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_com_01.cani"},recoverPreOrientation=false},
		{name="CqcWallThrowFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_f_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_f_02.cani"},recoverPreOrientation=false},
		{name="CqcWallThrowBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_b_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_b_02.cani"},recoverPreOrientation=false},
		{name="CqcWallThrowNearFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_nea_f_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_nea_f_02.cani"},recoverPreOrientation=false},
		{name="CqcWallThrowNearBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_nea_b_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_wal_atk_nea_b_02.cani"},recoverPreOrientation=false},
		{name="CounterToKnife",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cnt_knf_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cnt_knf_02.cani"}},
		{name="CounterToGunStrike",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cnt_gun_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cqc/gcam_cqc_s_cnt_gun_02.cani"}},
		{name="CounterToLiquidAttack1",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_cqc_s_cnt1_com1_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_cqc_s_cnt1_com1_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToLiquidAttack2",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_cqc_s_cnt1_com2_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_cqc_s_cnt1_com2_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToLiquidJumpAttack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_lqd_s_cnt3_jmp_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_lqd_s_cnt3_jmp_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToLiquidStrike",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_cqc_s_cnt3_tuki_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_lqd/gcam_cqc_s_cnt3_tuki_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToParasiteFogMacheteA",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu_s_cnt_lm_set_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu_s_cnt_lm_set_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToParasiteFogMacheteB",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu_s_cnt_ru_set_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu_s_cnt_ru_set_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToParasiteCommonMachete",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu_s_cnt_f_set_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu_s_cnt_f_set_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToParasiteHardMacheteA",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu3_s_cnt_rd_set_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu3_s_cnt_rd_set_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToParasiteHardMacheteB",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu3_s_cnt_lu_set_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu3_s_cnt_lu_set_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToParasiteCmoufMacheteA",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu1_s_cnt_rm_set_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu1_s_cnt_rm_set_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CounterToParasiteCmoufMacheteB",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu1_s_cnt_ld_set_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wmu/gcam_wmu1_s_cnt_ld_set_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="CureGunShotWoundBodyLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_q_bdy_cue_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_q_bdy_cue_02.cani"}},
		{name="CureGunShotWoundBodyRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_q_bdy_cue_r_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_q_bdy_cue_r_02.cani"}},
		{name="CureGunShotWoundBodyCrawl",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_c_bdy_cue_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_c_bdy_cue_02.cani"}},
		{name="CureGunShotWoundBodySupine",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_p_bdy_cue_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_p_bdy_cue_02.cani"}},
		{name="CureArmDislocationStand",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_s_arm_cue_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_s_arm_cue_02.cani"}},
		{name="CureArmDislocationSquat",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_q_arm_cue_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_q_arm_cue_02.cani"}},
		{name="CureFootDislocation",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_s_leg_cue_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_s_leg_cue_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_s_leg_cue_03.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_cue/gcam_cue_s_leg_cue_04.cani"}},
		{name="RideOnHorseFrontRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_03.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_04.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_05.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_06.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="RideOnHorseSideRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_03.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_04.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_05.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_06.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="RideOnHorseBackRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_03.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_04.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_05.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_06.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="RideOnHorseFrontLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_03.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_04.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_05.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_06.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="RideOnHorseSideLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_03.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_04.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_05.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_06.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="RideOnHorseBackLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_03.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_04.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_05.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_06.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="RideOnHorseRun",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_rn_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_rideon_rn_02.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="PlaceBearersHorseLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_l_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_l_st_02.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="PlaceBearersHorseRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_r_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_r_st_02.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="LowerBearersHorseLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_l_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_l_ed_02.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="LowerBearersHorseRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_r_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_adsn/gcam_adsn_ene_r_ed_02.cani"},recoverPreOrientation=true,keepPosition=false,interpTimeAfterFinishingToKeepPosition=2},
		{name="RideOnWalkerGear",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_wkg_s_tak_on_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_wkg_s_tak_on_02.cani"},isRiding=true},
		{name="CarryAtWalkerGear",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_wkc_s_p_st_f_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_wkc_s_p_st_f_02.cani"},isRiding=true,recoverPreOrientation=true,keepPosition=false},
		{name="WalkerGearCQCStand",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_s_cke_st_wg_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_s_cke_st_wg_02.cani"},recoverPreOrientation=true,keepPosition=false},
		{name="WalkerGearCQCSquat",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_q_cke_st_wg_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wkg/gcam_q_cke_st_wg_02.cani"},recoverPreOrientation=true,keepPosition=false},
		{name="RideOnVehicle",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_s_rde_st_r_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_s_rde_st_r_02.cani"},isRiding=true},
		{name="RideOnVehicleFromAssistantDriversSeat",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_s_rde_sid_st_l_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_s_rde_sid_st_l_02.cani"},isRiding=true},
		{name="PlaceBearersVehicleToAssistantDriversSeat",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_sid_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_sid_st_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="LowerBearersVehicleFromAssistantDriversSeat",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_sid_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_sid_ed_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="PlaceBearersVehicleFromLeftSideToRearSeatLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rel_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rel_st_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="LowerBearersVehicleFromLeftSideToRearSeatLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rel_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rel_ed_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="PlaceBearersVehicleFromRightSideToRearSeatRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rer_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rer_st_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="LowerBearersVehicleFromRightSideToRearSeatRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rer_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_rer_ed_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="PlaceBearersVehicleFromBackToRearSeatRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_r_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_r_st_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="LowerBearersVehicleFromBackToRearSeatRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_r_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_r_ed_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="PlaceBearersVehicleFromBackToRearSeatLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_l_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_l_st_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="LowerBearersVehicleFromBackToRearSeatLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_l_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_plv/gcam_plv_reb_l_ed_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="RideOnTruck",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_s_rde_drv_st_l_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_s_rde_drv_st_l_02.cani"},isRiding=true},
		{name="RideOnTruckFromAssistantDriversSeat",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_s_rde_sid2_st_l_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_s_rde_sid2_st_l_01.cani"},isRiding=true},
		{name="PlaceBearersTruckFromLeftSideToRearSeatLeft",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_sid_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_sid_st_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="LowerBearersTruckFromBackToRearSeatRight",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_sid_ed_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_nmt/gcam_nmt_sid_ed_02.cani"},ignoreCollisionCheckOnPlaying=true,ignoreCollisionCheckOnStart=true,isRiding=true},
		{name="RideOnArmoredVehicleWest",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wav/gcam_wav_s_rid_on_l_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wav/gcam_wav_s_rid_on_l_02.cani"},recoverPreOrientation=false,keepPosition=true,isRiding=true},
		{name="RideOnArmoredVehicleEast",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wav/gcam_sav_s_rid_on_l_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wav/gcam_sav_s_rid_on_l_02.cani"},recoverPreOrientation=false,keepPosition=true,isRiding=true},
		{name="RideOnHelicopter",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_uth/gcam_uth_q_rid_pos_l_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_uth/gcam_uth_q_rid_pos_l_02.cani"},isRiding=true,recoverPreOrientation=false,keepPosition=true},
		{name="GiveCharaterRideHelicopter",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_uth/gcam_cry_s_ene_uth_dwn_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_uth/gcam_cry_s_ene_uth_dwn_02.cani"},isRiding=true},
		{name="GiveCharaterRideHelicopterAndRideOn",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_uth/gcam_cry_s_ene_uth_dwn_sit_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_uth/gcam_cry_s_ene_uth_dwn_sit_02.cani"},isRiding=true,recoverPreOrientation=false,keepPosition=true},
		{name="MissionStartOnHeli",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_heli/gcam_heri_start_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_heli/gcam_heri_start_02.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_heli/gcam_heri_start_03.cani"},isRiding=true,recoverPreOrientation=false,keepPosition=true,interpTimeAfterFinishingToKeepPosition=2},
		{name="MissionStartOnHeli2",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_heli/gcam_heri_start_04.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_heli/gcam_heri_start_05.cani"},isRiding=true,recoverPreOrientation=false,keepPosition=true,interpTimeAfterFinishingToKeepPosition=2},
		{name="MissionStartOnHeli3",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_heli/gcam_heri_start_06.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_heli/gcam_heri_start_07.cani"},isRiding=true,recoverPreOrientation=false,keepPosition=true,interpTimeAfterFinishingToKeepPosition=2},
		{name="GoInsideCBox",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_box/gcam_box_s_sup_in_01.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=true,stopPlayingByCollision=false,keepPosition=true},
		{name="GoInsideTrashBox",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_st_01.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=false,ignoreCollisionCheckOnPlaying=false,keepPosition=true},
		{name="GetOutTrashBox",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_ed_01.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=false,ignoreCollisionCheckOnPlaying=false,isEnableAtAnyCameras=true},
		{name="CqcDragToTrashBox",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_cqc_tsh_q_l_cke_ef_01.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=false,ignoreCollisionCheckOnPlaying=false,isEnableAtAnyCameras=true,keepPosition=true},
		{name="GoInsideTrashBoxCarryBoth",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_cry_ed1_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_cry_ed1_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=false,ignoreCollisionCheckOnPlaying=false,isEnableAtAnyCameras=true,keepPosition=true},
		{name="GoInsideTrashBoxCarry",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_cry_ed2_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_cry_ed2_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=false,ignoreCollisionCheckOnPlaying=false,isEnableAtAnyCameras=true,keepPosition=true},
		{name="GetOutTrashBoxCarry",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_cry_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_tsh/gcam_tsh_s_cry_st_02.cani"},recoverPreOrientation=false,ignoreCollisionCheckOnStart=false,ignoreCollisionCheckOnPlaying=false,isEnableAtAnyCameras=true,keepPosition=true},
		{name="GoInsideToilet",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tle/gcam_tle_s_in_01.cani"},recoverPreOrientation=true,ignoreCollisionCheckOnStart=true,ignoreCollisionCheckOnPlaying=true,isEnableAtAnyCameras=true},
		{name="GoInsideToiletCarryBoth",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tle/gcam_tle_s_cry_ed1_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_tle/gcam_tle_s_cry_ed1_02.cani"},recoverPreOrientation=true,ignoreCollisionCheckOnStart=true,ignoreCollisionCheckOnPlaying=true,isEnableAtAnyCameras=true},
		{name="CloseToiletDoor",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tle/gcam_tle_s_cry_ed2_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_tle/gcam_tle_s_cry_ed2_02.cani"},recoverPreOrientation=true,ignoreCollisionCheckOnStart=true,ignoreCollisionCheckOnPlaying=true,isEnableAtAnyCameras=true},
		{name="TakeOutFromToilet",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_tle/gcam_tle_s_cry_s_01.cani"},recoverPreOrientation=true,ignoreCollisionCheckOnStart=true,ignoreCollisionCheckOnPlaying=true,isEnableAtAnyCameras=true},
		{name="GoInsideShower",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_swer/gcam_swer_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_swer/gcam_swer_02.cani"},recoverPreOrientation=true,ignoreCollisionCheckOnStart=true,ignoreCollisionCheckOnPlaying=true,isEnableAtAnyCameras=true},
		{name="StartCliffClimb",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_clf/gcam_clf_90_vtcl_st_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_clf/gcam_clf_90_vtcl_st_02.cani"},recoverPreOrientation=false,isEnableAtAnyCameras=true,keepPosition=true},
		{name="WolfAttackStandFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_s_atk_st_f_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_s_atk_st_f_02.cani"},recoverPreOrientation=false,isEnableAtAnyCameras=true,keepPosition=false},
		{name="WolfAttackStandBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_s_atk_st_bl_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_s_atk_st_bl_02.cani"},recoverPreOrientation=false,isEnableAtAnyCameras=true,keepPosition=false},
		{name="WolfAttackCrawlFront",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_c_atk_st_fl_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_c_atk_st_fl_02.cani"},recoverPreOrientation=false,isEnableAtAnyCameras=true,keepPosition=false},
		{name="WolfAttackCrawlBack",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_c_atk_st_bl_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_wlf/gcam_wlf_c_atk_st_bl_02.cani"},recoverPreOrientation=false,isEnableAtAnyCameras=true,keepPosition=false},
		{name="PazPhantomPainPassPhotos",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_paz/gcam_paz_give_pic_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_paz/gcam_paz_give_pic_02.cani"},recoverPreOrientation=false,isEnableAtAnyCameras=true,ignoreCollisionCheckOnStart=true,ignoreCollisionCheckOnPlaying=true,keepPosition=true},
		{name="PazPhantomPainPickUpBook",filePath={"/Assets/tpp/motion/SI_game/fani/cameras/gcam_paz/gcam_paz_give_book_01.cani","/Assets/tpp/motion/SI_game/fani/cameras/gcam_paz/gcam_paz_give_book_02.cani"},recoverPreOrientation=false,isEnableAtAnyCameras=true,ignoreCollisionCheckOnStart=true,ignoreCollisionCheckOnPlaying=true,keepPosition=true}
	}--cameraAnimationFilePaths
	return ret
end
function this.Reload()
	this.playerCamoufTable = {}
	this.playerCallbackFuncs = {}
	this.cameraAnimationFilePaths = {}
	this.playerCamoufTable = this.GetCamoTable()		
	this.playerCallBackScript = this.GetPlayerCallBackScript()
	this.playerCallbackFuncs = this.GetPlayerFuncCallbackTable()
	this.cameraAnimationFilePaths = this.GetAnimPathTable()	
	this.playerCallBackScriptPath = "/Assets/tpp/level_asset/chara/player/game_object/TppPlayer2CallbackScript.lua"
	if ZetaIndex ~= nil then --Load mods
		ZetaIndex.ModFunction("SetTppPlayer2InitializeScript", this )
		local newCameraAnimationFilePaths = ZetaIndex.ModGet("PlayerCameraAnimation", this)
		if newCameraAnimationFilePaths ~= nil and next(newCameraAnimationFilePaths) then
			this.cameraAnimationFilePaths = ZetaUtil.MergeTables(this.cameraAnimationFilePaths, newCameraAnimationFilePaths, "name")
		end
	end
	Player.InitCamoufTable(this.playerCamoufTable)
	Player.RegisterScriptFunc(this.playerCallBackScriptPath,this.playerCallbackFuncs)
	Player.RegisterCameraAnimationFilePaths(this.cameraAnimationFilePaths)
	if ZetaIndex ~= nil then ZetaIndex.ModFunction("TppPlayer2CallbackScript", this.playerCallBackScript ) end --Exposes functions of TppPlayer2CallbackScript
	TppPlayer2CallbackScript = this.playerCallBackScript --Override TppPlayer2CallbackScript global with Zeta's call back script
end
return this