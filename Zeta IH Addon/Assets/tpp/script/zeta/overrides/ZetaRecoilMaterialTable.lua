--ZetaRecoilMaterialTable.lua
local this={}

function this.GetRecoilMaterialsTable()
	local table={
		0,
		{"MTR_IRON_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_A",1,1},
		{"MTR_IRON_B",TppEquip.PENETRATE_LEVEL_RIFLE,"IRON_B",1,1},
		{"MTR_IRON_C",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_C",1,1},
		{"MTR_IRON_D",TppEquip.PENETRATE_LEVEL_RIFLE,"IRON_D",1,1},
		{"MTR_IRON_E",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_E",1,1},
		{"MTR_IRON_F",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_F",1,1},
		{"MTR_IRON_G",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_A",1,1},
		{"MTR_IRON_M",TppEquip.PENETRATE_LEVEL_MINIMUM,"IRON_B",1,1},
		{"MTR_IRON_N",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_A",1,1},
		{"MTR_IRON_W",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_B",1,2},
		{"MTR_PIPE_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"PIPE_A",1,1},
		{"MTR_PIPE_B",TppEquip.PENETRATE_LEVEL_RIFLE,"PIPE_B",1,1},
		{"MTR_PIPE_S",TppEquip.PENETRATE_LEVEL_AMRIFLE,"PIPE_B",1,0},
		{"MTR_TIN_A",TppEquip.PENETRATE_LEVEL_TRANQ,"TIN_A",1,1},
		{"MTR_FENC_A",TppEquip.PENETRATE_LEVEL_MINIMUM,"IRON_A",0,1},
		{"MTR_FENC_B",TppEquip.PENETRATE_LEVEL_MINIMUM,"FENC_B",0,1},
		{"MTR_FENC_F",TppEquip.PENETRATE_LEVEL_AMRIFLE,"IRON_A",1,0},
		{"MTR_CONC_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"ROCK_A",2,3},
		{"MTR_CONC_B",TppEquip.PENETRATE_LEVEL_SNIPER,"ROCK_A",2,3},
		{"MTR_BRIC_A",TppEquip.PENETRATE_LEVEL_SNIPER,"ROCK_A",2,3},
		{"MTR_PLAS_A",TppEquip.PENETRATE_LEVEL_RIFLE,"PLAS_A",3,4},
		{"MTR_PLAS_B",TppEquip.PENETRATE_LEVEL_TRANQ,"PLAS_A",3,4},
		{"MTR_PLAS_W",TppEquip.PENETRATE_LEVEL_AMRIFLE,"PLAS_A",3,5},
		{"MTR_PAPE_A",TppEquip.PENETRATE_LEVEL_TRANQ,"PAPE_B",3,6},
		{"MTR_PAPE_B",TppEquip.PENETRATE_LEVEL_TRANQ,"PAPE_B",3,6},
		{"MTR_PAPE_C",TppEquip.PENETRATE_LEVEL_RIFLE,"PAPE_B",3,6},
		{"MTR_PAPE_D",TppEquip.PENETRATE_LEVEL_TRANQ,"PAPE_B",3,7},
		{"MTR_RUBB_A",TppEquip.PENETRATE_LEVEL_TRANQ,"PLAS_A",3,6},
		{"MTR_RUBB_B",TppEquip.PENETRATE_LEVEL_AMRIFLE,"PLAS_A",3,6},
		{"MTR_CLOT_A",TppEquip.PENETRATE_LEVEL_SNIPER,"CLOT_C",3,6},
		{"MTR_CLOT_B",TppEquip.PENETRATE_LEVEL_AMRIFLE,"CLOT_C",3,6},
		{"MTR_CLOT_C",TppEquip.PENETRATE_LEVEL_TRANQ,"CLOT_C",3,6},
		{"MTR_CLOT_D",TppEquip.PENETRATE_LEVEL_MINIMUM,"CLOT_C",0,6},
		{"MTR_CLOT_E",TppEquip.PENETRATE_LEVEL_TRANQ,"CLOT_C",3,6},
		{"MTR_GLAS_A",TppEquip.PENETRATE_LEVEL_SNIPER,"GLAS_A",4,8},
		{"MTR_GLAS_B",TppEquip.PENETRATE_LEVEL_TRANQ,"GLAS_B",0,8},
		{"MTR_GLAS_C",TppEquip.PENETRATE_LEVEL_TRANQ,"GLAS_A",0,8},
		{"MTR_VINL_A",TppEquip.PENETRATE_LEVEL_TRANQ,"VINL_A",3,6},
		{"MTR_VINL_W",TppEquip.PENETRATE_LEVEL_AMRIFLE,"VINL_A",3,9},
		{"MTR_TILE_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"ROCK_A",2,3},
		{"MTR_TLRF_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"ROCK_A",2,3},
		{"MTR_ALRM_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"ALRM_A",1,1},
		{"MTR_COPS_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"",0,6},
		{"MTR_COPS_B",TppEquip.PENETRATE_LEVEL_AMRIFLE,"",0,6},
		{"MTR_BRIR_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"",0,0},
		{"MTR_BLOD_A",TppEquip.PENETRATE_LEVEL_MINIMUM,"",0,0},
		{"MTR_SOIL_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_A",0,10},
		{"MTR_SOIL_B",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_A",0,10},
		{"MTR_SOIL_C",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",0,11},
		{"MTR_SOIL_D",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",0,0},
		{"MTR_SOIL_E",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",0,11},
		{"MTR_SOIL_F",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",0,10},
		{"MTR_SOIL_G",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",0,10},
		{"MTR_SOIL_H",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",0,10},
		{"MTR_SOIL_R",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",0,10},
		{"MTR_SOIL_W",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_C",5,10},
		{"MTR_GRAV_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"GRAV_A",0,10},
		{"MTR_SAND_A",TppEquip.PENETRATE_LEVEL_SNIPER,"SOIL_A",0,11},
		{"MTR_SAND_B",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_A",3,10},
		{"MTR_SAND_C",TppEquip.PENETRATE_LEVEL_AMRIFLE,"SOIL_A",0,10},
		{"MTR_LEAF",TppEquip.PENETRATE_LEVEL_AMRIFLE,"TURF_A",0,10},
		{"MTR_RLEF",TppEquip.PENETRATE_LEVEL_MINIMUM,"",0,12},
		{"MTR_RLEF_B",TppEquip.PENETRATE_LEVEL_MINIMUM,"",0,13},
		{"MTR_WOOD_A",TppEquip.PENETRATE_LEVEL_SNIPER,"WOOD_C",6,14},
		{"MTR_WOOD_B",TppEquip.PENETRATE_LEVEL_HANDGUN,"WOOD_C",0,14},
		{"MTR_WOOD_C",TppEquip.PENETRATE_LEVEL_TRANQ,"WOOD_C",6,14},
		{"MTR_WOOD_D",TppEquip.PENETRATE_LEVEL_RIFLE,"WOOD_C",6,14},
		{"MTR_WOOD_G",TppEquip.PENETRATE_LEVEL_AMRIFLE,"WOOD_C",6,14},
		{"MTR_WOOD_M",TppEquip.PENETRATE_LEVEL_MINIMUM,"WOOD_C",6,14},
		{"MTR_WOOD_W",TppEquip.PENETRATE_LEVEL_RIFLE,"WOOD_C",6,15},
		{"MTR_FWOD_A",TppEquip.PENETRATE_LEVEL_MINIMUM,"WOOD_C",0,0},
		{"MTR_PLNT_A",TppEquip.PENETRATE_LEVEL_TRANQ,"WOOD_C",0,14},
		{"MTR_ROCK_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"ROCK_A",5,16},
		{"MTR_ROCK_B",TppEquip.PENETRATE_LEVEL_AMRIFLE,"ROCK_A",5,16},
		{"MTR_ROCK_P",TppEquip.PENETRATE_LEVEL_SNIPER,"ROCK_P",0,17},
		{"MTR_MOSS_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"ROCK_A",0,10},
		{"MTR_TURF_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"TURF_A",0,10},
		{"MTR_WATE_A",TppEquip.PENETRATE_LEVEL_MINIMUM,"WATE_A",0,18},
		{"MTR_WATE_B",TppEquip.PENETRATE_LEVEL_AMRIFLE,"WATE_A",0,19},
		{"MTR_WATE_C",TppEquip.PENETRATE_LEVEL_AMRIFLE,"WATE_A",0,18},
		{"MTR_AIR_A",TppEquip.PENETRATE_LEVEL_MINIMUM,"NONE_A",0,0},
		{"MTR_NONE_A",TppEquip.PENETRATE_LEVEL_AMRIFLE,"NONE_A",0,0}
		}
	return table
end
function this.GetBulletMarkEffectTable()
	local table={
		"",
		"fx_tpp_hitbltirn00_s0MG",
		"fx_tpp_hitbltcnc00_s0MG",
		"fx_tpp_hitbltmrk00_s0MG",
		"fx_tpp_hitbltgls00_s0MG",
		"fx_tpp_hitbltroc00_s0MG",
		"fx_tpp_hitbltwod00_s0MG"
	}
	return table
end
function this.GetRicochetEffectTable()
	local table={
		"",
		"fx_tpp_rctirn01M_s0LG",
		"fx_tpp_rctirnwtrspl01M_s0",
		"fx_tpp_rctcnc01M_s0LG",
		"fx_tpp_rctplt01M_s0",
		"fx_tpp_rctdstwtrspl01M_s0",
		"fx_tpp_rctdst02M_s0",
		"fx_tpp_rctppr01_s1",
		"fx_tpp_rctgls01M_s0LG",
		"fx_tpp_rctgnswtr01M_s0",
		"fx_tpp_rctsol01M_s0LG",
		"fx_tpp_rctmud01M_s0LG",
		"fx_tpp_rctlef01M_s0LG",
		"fx_tpp_rctlef02M_s0",
		"fx_tpp_rctwod01M_s0LG",
		"fx_tpp_rctwodwtrspl01M_s0",
		"fx_tpp_rctroc01M_s0LG",
		"fx_tpp_rctarmene01M_s0",
		"fx_tpp_rctwtr01M_s0",
		"fx_tpp_rctpdl01M_s0",
		"fx_tpp_rctgrs01M_s0LG"
	}
	return table
end

function this.Reload()
	--Clear and load vanilla table
	this.recoilMaterialsParameters={}
	this.recoilMaterialsParameters={
		RecoilMaterial=this.GetRecoilMaterialsTable(),
		BulletMarkEffect=this.GetBulletMarkEffectTable(),
		RicochetEffect=this.GetRicochetEffectTable(),
	}

	--Load mods
	ZetaIndex.ModFunction("SetRecoilMaterialTable", this ) --Passthrough
	local newRecoilMaterialsParameters = ZetaIndex.ModGet("RecoilMaterialTable", this)
	if newRecoilMaterialsParameters ~= nil and next(newRecoilMaterialsParameters) then
		this.recoilMaterialsParameters = ZetaUtil.MergeTables(this.recoilMaterialsParameters, newRecoilMaterialsParameters, true)
	end

	TppBullet.ReloadRecoilMaterials(this.recoilMaterialsParameters)
end

return this