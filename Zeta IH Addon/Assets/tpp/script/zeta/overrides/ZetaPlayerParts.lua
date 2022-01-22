--ZetaPlayerParts.lua
local this={}

--Updated Caplag's list of player parts
function this.GetTable()
	local SnakeTable = {
		{0,"/Assets/tpp/pack/player/parts/plparts_normal.fpk","/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna0_main0_def_v00.fv2"},
		{1,"/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk","/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts","/Assets/tpp/fova/chara/sna/sna0_main1_def_v00.fv2"},
		{2,"/Assets/tpp/pack/player/parts/plparts_gz_suit.fpk","/Assets/tpp/parts/chara/sna/sna2_main1_def_v00.parts","/Assets/tpp/fova/chara/sna/sna2_main1_def_v00.fv2"},
		{3,"/Assets/tpp/pack/player/parts/plparts_hospital.fpk","/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna1_main0_def_v00.fv2"},
		{4,"/Assets/tpp/pack/player/parts/plparts_mgs1.fpk","/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna6_main0_def_v00.fv2"},
		{5,"/Assets/tpp/pack/player/parts/plparts_ninja.fpk","/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts","/Assets/tpp/fova/chara/nin/nin0_main0_def_v00.fv2"},
		{6,"/Assets/tpp/pack/player/parts/plparts_raiden.fpk","/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts","/Assets/tpp/fova/chara/rai/rai0_main0_def_v00.fv2"},
		{7,"/Assets/tpp/pack/player/parts/plparts_naked.fpk","/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna8_main0_def_v00.fv2"},
		{8,"/Assets/tpp/pack/player/parts/plparts_venom.fpk","/Assets/tpp/parts/chara/sna/sna4_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna4_main0_def_v00.fv2"},
		{9,"/Assets/tpp/pack/player/parts/plparts_battledress.fpk","/Assets/tpp/parts/chara/sna/sna5_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna5_main0_def_v00.fv2"},
		{10,"/Assets/tpp/pack/player/parts/plparts_parasite.fpk","/Assets/tpp/parts/chara/sna/sna7_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna7_main0_def_v00.fv2"},
		{11,"/Assets/tpp/pack/player/parts/plparts_leather.fpk","/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts","/Assets/tpp/fova/chara/sna/sna3_main1_def_v00.fv2"},
		{12,"/Assets/tpp/pack/player/parts/plparts_gold.fpk","/Assets/tpp/parts/chara/sna/sna9_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna9_main0_def_v00.fv2"},
		{13,"/Assets/tpp/pack/player/parts/plparts_silver.fpk","/Assets/tpp/parts/chara/sna/sna9_main1_def_v00.parts","/Assets/tpp/fova/chara/sna/sna9_main1_def_v00.fv2"},
		{14,"/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk","/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts","/Assets/tpp/fova/chara/avm/avm0_main0_def_v00.fv2"},
		{15,"/Assets/tpp/pack/player/parts/plparts_dla0_main0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dla0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/dla0_main0_def_v00.fv2"},
		{16,"/Assets/tpp/pack/player/parts/plparts_dla1_main0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dla1_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/dla1_main0_def_v00.fv2"},
		{17,"/Assets/tpp/pack/player/parts/plparts_dlb0_main0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dlb0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/dlb0_main0_def_v00.fv2"},
		{18,"/Assets/tpp/pack/player/parts/plparts_dld0_main0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dld0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/dld0_main0_def_v00.fv2"},
		{19,"/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dle0_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dle0_plyf0_def_v00.fv2"},
		{20,"/Assets/tpp/pack/player/parts/plparts_dle1_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dle1_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dle1_plyf0_def_v00.fv2"},
		{21,"/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dlc0_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dlc0_plyf0_def_v00.fv2"},
		{22,"/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dlc1_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dlc1_plyf0_def_v00.fv2"},
		{23,"/Assets/tpp/pack/player/parts/plparts_normal.fpk","/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna0_main0_def_v00.fv2"},
		{24,"/Assets/tpp/pack/player/parts/plparts_normal.fpk","/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna0_main0_def_v00.fv2"},
		{25,"/Assets/tpp/pack/player/parts/plparts_normal.fpk","/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna0_main0_def_v00.fv2"},
		{26,"/Assets/tpp/pack/player/parts/plparts_normal.fpk","/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna0_main0_def_v00.fv2"},
		{27,0,0,0},
	}		
	local table = {
		playerPartsTypeTable={
			SNAKE=SnakeTable,
			DD_MALE={
				{0,"/Assets/tpp/pack/player/parts/plparts_dd_male.fpk","/Assets/tpp/parts/chara/sna/dds5_main0_ply_v00.parts","/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2"},
				{1,"/Assets/tpp/pack/player/parts/plparts_dd_male.fpk","/Assets/tpp/parts/chara/sna/dds5_main0_ply_v00.parts","/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2"},
				{2,"/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk","/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna2_main0_def_v00.fv2"},
				{3,"/Assets/tpp/pack/player/parts/plparts_hospital.fpk","/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna1_main0_def_v00.fv2"},
				{4,"/Assets/tpp/pack/player/parts/plparts_mgs1.fpk","/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna6_main0_def_v00.fv2"},
				{5,"/Assets/tpp/pack/player/parts/plparts_ninja.fpk","/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts","/Assets/tpp/fova/chara/nin/nin0_main0_def_v00.fv2"},
				{6,"/Assets/tpp/pack/player/parts/plparts_raiden.fpk","/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts","/Assets/tpp/fova/chara/rai/rai0_main0_def_v00.fv2"},
				{7,"/Assets/tpp/pack/player/parts/plparts_naked.fpk","/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna8_main0_def_v00.fv2"},
				{8,"/Assets/tpp/pack/player/parts/plparts_ddm_venom.fpk","/Assets/tpp/parts/chara/sna/sna4_plym0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna4_plym0_def_v00.fv2"},
				{9,"/Assets/tpp/pack/player/parts/plparts_ddm_battledress.fpk","/Assets/tpp/parts/chara/sna/sna5_plym0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna5_plym0_def_v00.fv2"},
				{10,"/Assets/tpp/pack/player/parts/plparts_ddm_parasite.fpk","/Assets/tpp/parts/chara/sna/sna7_plym0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna7_plym0_def_v00.fv2"},
				{11,"/Assets/tpp/pack/player/parts/plparts_leather.fpk","/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts","/Assets/tpp/fova/chara/sna/sna3_main1_def_v00.fv2"},
				{12,0,0,0},
				{13,0,0,0},
				{14,"/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk","/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts","/Assets/tpp/fova/chara/avm/avm0_main0_def_v00.fv2"},
				{15,"/Assets/tpp/pack/player/parts/plparts_dla0_plym0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dla0_plym0_def_v00.parts","/Assets/tpp/fova/chara/sna/dla0_plym0_def_v00.fv2"},
				{16,"/Assets/tpp/pack/player/parts/plparts_dla1_plym0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dla1_plym0_def_v00.parts","/Assets/tpp/fova/chara/sna/dla1_plym0_def_v00.fv2"},
				{17,"/Assets/tpp/pack/player/parts/plparts_dlb0_plym0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dlb0_plym0_def_v00.parts","/Assets/tpp/fova/chara/sna/dlb0_plym0_def_v00.fv2"},
				{18,"/Assets/tpp/pack/player/parts/plparts_dld0_plym0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dld0_plym0_def_v00.parts","/Assets/tpp/fova/chara/sna/dld0_plym0_def_v00.fv2"},
				{19,0,0,0},
				{20,0,0,0},
				{21,0,0,0},
				{22,0,0,0},
				{23,"/Assets/tpp/pack/player/parts/plparts_ddm_swimwear.fpk","/Assets/tpp/parts/chara/dlf/dlf1_main0_def_v00.parts","/Assets/tpp/fova/chara/dlf/dlf1_main0_def_v00.fv2"},
				{24,"/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_g.fpk","/Assets/tpp/parts/chara/dlg/dlg1_main0_def_v00.parts","/Assets/tpp/fova/chara/dlg/dlg1_main0_def_v00.fv2"},
				{25,"/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_h.fpk","/Assets/tpp/parts/chara/dlh/dlh1_main0_def_v00.parts","/Assets/tpp/fova/chara/dlh/dlh1_main0_def_v00.fv2"},
				{26,"/Assets/tpp/pack/player/parts/plparts_dd_male.fpk","/Assets/tpp/parts/chara/sna/dds5_main0_ply_v00.parts","/Assets/tpp/fova/chara/sna/dds5_main0_ply_v00.fv2"},
				{27,0,0,0},
			},
			DD_FEMALE={
				{0,"/Assets/tpp/pack/player/parts/plparts_dd_female.fpk","/Assets/tpp/parts/chara/sna/dds6_main0_ply_v00.parts","/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2"},
				{1,"/Assets/tpp/pack/player/parts/plparts_dd_female.fpk","/Assets/tpp/parts/chara/sna/dds6_main0_ply_v00.parts","/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2"},
				{2,"/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk","/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna2_main0_def_v00.fv2"},
				{3,"/Assets/tpp/pack/player/parts/plparts_hospital.fpk","/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna1_main0_def_v00.fv2"},
				{4,"/Assets/tpp/pack/player/parts/plparts_mgs1.fpk","/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna6_main0_def_v00.fv2"},
				{5,"/Assets/tpp/pack/player/parts/plparts_ninja.fpk","/Assets/tpp/parts/chara/nin/nin0_main0_def_v00.parts","/Assets/tpp/fova/chara/nin/nin0_main0_def_v00.fv2"},
				{6,"/Assets/tpp/pack/player/parts/plparts_raiden.fpk","/Assets/tpp/parts/chara/rai/rai0_main0_def_v00.parts","/Assets/tpp/fova/chara/rai/rai0_main0_def_v00.fv2"},
				{7,"/Assets/tpp/pack/player/parts/plparts_naked.fpk","/Assets/tpp/parts/chara/sna/sna8_main0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna8_main0_def_v00.fv2"},
				{8,"/Assets/tpp/pack/player/parts/plparts_ddf_venom.fpk","/Assets/tpp/parts/chara/sna/sna4_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna4_plyf0_def_v00.fv2"},
				{9,"/Assets/tpp/pack/player/parts/plparts_ddf_battledress.fpk","/Assets/tpp/parts/chara/sna/sna5_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna5_plyf0_def_v00.fv2"},
				{10,"/Assets/tpp/pack/player/parts/plparts_ddf_parasite.fpk","/Assets/tpp/parts/chara/sna/sna7_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/sna7_plyf0_def_v00.fv2"},
				{11,"/Assets/tpp/pack/player/parts/plparts_leather.fpk","/Assets/tpp/parts/chara/sna/sna3_main1_def_v00.parts","/Assets/tpp/fova/chara/sna/sna3_main1_def_v00.fv2"},
				{12,0,0,0},
				{13,0,0,0},
				{14,"/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk","/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts","/Assets/tpp/fova/chara/avm/avm0_main0_def_v00.fv2"},
				{15,0,0,0},
				{16,0,0,0},
				{17,0,0,0},
				{18,0,0,0},
				{19,"/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dle0_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dle0_plyf0_def_v00.fv2"},
				{20,"/Assets/tpp/pack/player/parts/plparts_dle1_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dle1_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dle1_plyf0_def_v00.fv2"},
				{21,"/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dlc0_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dlc0_plyf0_def_v00.fv2"},
				{22,"/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk","/Assets/tpp/parts/chara/sna/dlc1_plyf0_def_v00.parts","/Assets/tpp/fova/chara/sna/dlc1_plyf0_def_v00.fv2"},
				{23,"/Assets/tpp/pack/player/parts/plparts_ddf_swimwear.fpk","/Assets/tpp/parts/chara/dlf/dlf0_main0_def_f_v00.parts","/Assets/tpp/fova/chara/dlf/dlf0_main0_def_f_v00.fv2"},
				{24,"/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_g.fpk","/Assets/tpp/parts/chara/dlg/dlg0_main0_def_f_v00.parts","/Assets/tpp/fova/chara/dlg/dlg0_main0_def_f_v00.fv2"},
				{25,"/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_h.fpk","/Assets/tpp/parts/chara/dlh/dlh0_main0_def_f_v00.parts","/Assets/tpp/fova/chara/dlh/dlh0_main0_def_f_v00.fv2"},
				{26,"/Assets/tpp/pack/player/parts/plparts_dd_female.fpk","/Assets/tpp/parts/chara/sna/dds6_main0_ply_v00.parts","/Assets/tpp/fova/chara/sna/dds6_main0_ply_v00.fv2"},
				{27,0,0,0},
			},
			AVATAR=SnakeTable,
			LIQUID={"/Assets/tpp/pack/player/parts/plparts_liquid.fpk","/Assets/tpp/parts/chara/lqd/lqd0_main0_ply_v00.parts","/Assets/tpp/fova/chara/lqd/lqd0_main0_ply_v00.fv2"},
			OCELOT={"/Assets/tpp/pack/player/parts/plparts_ocelot.fpk","/Assets/tpp/parts/chara/ooc/ooc0_main1_def_v00.parts","/Assets/tpp/fova/chara/ooc/ooc0_main1_def_v00.fv2"},
			QUIET={"/Assets/tpp/pack/player/parts/plparts_quiet.fpk","/Assets/tpp/parts/chara/qui/quip_main0_def_v00.parts","/Assets/tpp/fova/chara/qui/quip_main0_def_v00.fv2"},
		},
		playerArmTypeTable={
			{0,0,0},
			{1,"/Assets/tpp/pack/player/fova/plfova_sna0_arm0_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_arm0_v00.fv2"},
			{2,"/Assets/tpp/pack/player/fova/plfova_sna0_arm3_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_arm3_v00.fv2"},
			{3,"/Assets/tpp/pack/player/fova/plfova_sna0_arm4_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_arm4_v00.fv2"},
			{4,"/Assets/tpp/pack/player/fova/plfova_sna0_arm2_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_arm2_v00.fv2"},
			{5,"/Assets/tpp/pack/player/fova/plfova_sna0_arm1_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_arm1_v00.fv2"},
			{6,"/Assets/tpp/pack/player/fova/plfova_sna0_arm6_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_arm6_v00.fv2"},
			{7,"/Assets/tpp/pack/player/fova/plfova_sna0_arm7_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_arm7_v00.fv2"},
		},
		playerFaceTypeTable={
			{0,"/Assets/tpp/pack/player/fova/plfova_sna0_face0_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_face0_v00.fv2"},
			{1,"/Assets/tpp/pack/player/fova/plfova_sna0_face1_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_face1_v00.fv2"},
			{2,"/Assets/tpp/pack/player/fova/plfova_sna0_face2_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_face2_v00.fv2"},
			{3,"/Assets/tpp/pack/player/fova/plfova_sna0_face4_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_face4_v00.fv2"},
			{4,"/Assets/tpp/pack/player/fova/plfova_sna0_face5_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_face5_v00.fv2"},
			{5,"/Assets/tpp/pack/player/fova/plfova_sna0_face6_v00.fpk","/Assets/tpp/fova/chara/sna/sna0_face6_v00.fv2"},
		},
	}
	return table
end

function this.Reload(toggle)	
	local orderedList = {}
	
	if toggle == true then
		local newParts = ZetaIndex.SafeGet("LoadPlayerParts", this) 
		if newParts ~= nil and next(newParts) then
			for x,partsList in ipairs(newParts)do
				if partsList ~= nil and next(partsList) then
					for y,parts in ipairs(partsList)do
						table.insert( orderedList, parts )
					end
				end
			end		
		end
	end
	
	--Clear override
	if this.newPlayerParts ~= nil and next(this.newPlayerParts) then
		if IHH ~= nil then
			IHH.SetOverrideCharacterSystem(false)
		end	
	end
	
	--Clear certain tables
	this.playerParts = {}				
	this.curPlayerType = {}
	this.curPlayerPartsType = {}
	this.newPlayerParts = {}

	--Custom player parts
	if orderedList ~= nil and next(orderedList) then
		this.playerParts = orderedList
	end	
end

function this.CanOverridePlayerParts()
	--if gvars.ini_isTitleMode == true 
	--or gvars.ini_isReturnToTitle == true 
	--or gvars.isContinueFromTitle == true
	--then 
	--	if TppScriptVars.IsSavingOrLoading() then
	--		return false
	--	end
	--end
	
	return true
end

function this.Update()
	--Don't override during title
	local safeOverride = this.CanOverridePlayerParts()
	
	--Refresh parts 
	if safeOverride == true then
		if this.prevPlayerTypeSafe ~= nil then 
			this.ReloadPlayerPartsSafe(false)
			return nil
		end
	end
	
	--Applies on player part change and when it's safe/unsafe to override
	if this.curPlayerType ~= vars.playerType 
	or this.curPlayerPartsType ~= vars.playerPartsType 
	or this.curPlayerFaceId ~= vars.playerFaceId 
	or this.curPlayerFaceEquipId ~= vars.playerFaceEquipId 
	or this.safeOverrideActive ~= safeOverride then	
		--If any parts were found, apply them when their target parts are active
		if IHH ~= nil then
			local newOverride = false	
			local getCurrentParts = this.GetCurrentPartsList()
			if getCurrentParts ~= nil and next(getCurrentParts) then
				this.newPlayerParts = getCurrentParts
				newOverride = safeOverride --Override when it's safe
			end
			local usePlayer = {"","",""}
			local useHead = {false,"",""}
			local useHand = {false,"",""}	
			
			if newOverride == true then
				if this.playerParts ~= nil and next(this.playerParts) then								
					if this.newPlayerParts ~= nil and next(this.newPlayerParts) then						
						for i,partsList in ipairs(this.newPlayerParts)do
							--Player parts
							local playerPart = partsList[1]
							if playerPart ~= nil then
								if next(playerPart) then
									if playerPart[1] ~= nil then usePlayer[1] = playerPart[1] end 	
									if playerPart[2] ~= nil then usePlayer[2] = playerPart[2] end 
									if playerPart[3] ~= nil then usePlayer[3] = playerPart[3] end
								end
							end
							
							--Head
							local headPart = partsList[2]
							if headPart ~= nil then
								if type(headPart) == "table" then
									if next(headPart) then
										useHead[1] = true
										if headPart[1] ~= nil then useHead[2] = headPart[1] end
										if headPart[2] ~= nil then useHead[3] = headPart[2] end
									end
								else 
									useHead[1] = headPart 
									useHead[2] = ""
									useHead[3] = ""
								end
							end
							
							--Bionic arm/Left arm
							local handPart = partsList[3]
							if handPart ~= nil then			
								if type(handPart) == "table" then
									if next(handPart) then
										useHand[1] = true
										if handPart[1] ~= nil then useHand[2] = handPart[1] end
										if handPart[2] ~= nil then useHand[3] = handPart[2] end
									end
								else 
									useHand[1] = handPart 
									useHand[2] = ""
									useHand[3] = ""
								end
							end
						end	
					end
				end					
			end
			
			--Set before all for validation!
			IHH.SetPlayerTypeForPartsType(vars.playerType)
			--IHH.SetPlayerPartsTypeForPartsType(vars.playerPartsType)
			
			--Overrides current parts
			if newOverride == false then
				IHH.SetOverrideCharacterSystem(newOverride) 
			end
							
			--Body
			IHH.SetPlayerPartsFpkPath(usePlayer[1]) 	
			IHH.SetPlayerPartsPartsPath(usePlayer[2]) 
			IHH.SetSkinToneFv2Path(usePlayer[3])

			--Head
			IHH.SetUseHeadForPlayerParts(useHead[1])
			IHH.SetSnakeFaceFpkPath(useHead[2])
			IHH.SetSnakeFaceFv2Path(useHead[3])

			--Bionic hand
			IHH.SetUseBionicHandForPlayerParts(useHand[1])
			IHH.SetBionicHandFpkPath(useHand[2])
			IHH.SetBionicHandFv2Path(useHand[3])

			--Overrides current parts
			if newOverride == true then
				IHH.SetOverrideCharacterSystem(newOverride) 
			end		
			
			if safeOverride == true then
				--if this.curPlayerType == vars.playerType then
				--	this.ReloadPlayerPartsSafe(true)
				--end
				
				this.curPlayerType = vars.playerType
				this.curPlayerPartsType = vars.playerPartsType
				this.curPlayerFaceId = vars.playerFaceId
				this.curPlayerFaceEquipId = vars.playerFaceEquipId
				
				this.ReloadPlayerPartsSafe(true)
			end
			
			this.safeOverrideActive = safeOverride
		end
	end
end

function this.ReloadPlayerPartsSafe(toggle)
	if toggle == true then
		--Save current player type, temporarily switch to another player part. Prevent module from updating
		this.prevPlayerTypeSafe = vars.playerCamoType
		local newPlayerType = 0
		if this.prevPlayerTypeSafe == 0 then newPlayerType = 1 end	
		vars.playerCamoType = newPlayerType	
	else
		--Switch back to previous player type. Allow module to update.
		vars.playerCamoType = this.prevPlayerTypeSafe
		this.prevPlayerTypeSafe = nil
	end
end

function this.GetCurrentPartsList()
	local playerPartsList = {}
	if this.playerParts ~= nil then
		if next(this.playerParts) then
			local getCurrentPartsPath = this.GetPartPaths( vars.playerType, vars.playerPartsType )
			if getCurrentPartsPath ~= nil and next(getCurrentPartsPath) then
				for i,partsList in ipairs(this.playerParts)do
					local playerSelect = partsList[1]
					if playerSelect ~= nil then
						local curParts = { partsList[2], partsList[3], partsList[4],partsList[5],partsList[6] }
						local typePS = type(playerSelect)
						
						if typePS == "table" then --matches with table { playerType, playerPartsType }
							if next(playerSelect) then
								local modPlyrType = playerSelect[1] --Player Type
								if getCurrentPartsPath[1] == PlayerType[modPlyrType] then
									if getCurrentPartsPath[2] == playerSelect[2] --Player Parts Type
									or playerSelect[2] == nil then --can be nil so it always applies to playerType
										table.insert(playerPartsList,curParts)
									end
								end
							end
						elseif typePS == "number" then --Matches with playerPartType
							if getCurrentPartsPath[2] == playerSelect then				
								table.insert(playerPartsList,curParts)
							end
						elseif typePS == "string" then --Matches with FPK name.
							if playerSelect ~= "" then
								if string.match( getCurrentPartsPath[3], playerSelect ) then				
									table.insert(playerPartsList,curParts)
								end
							end
						end
					end
				end
			end
		end
	end
	
	if playerPartsList ~= nil then
		if next(playerPartsList) then
			return playerPartsList
		end
	end
	
	return nil
end

function this.GetPartPaths(plyrType,plyrPartsType)
	local playerPartsTable = this.GetTable()["playerPartsTypeTable"]
	for key,value in pairs(playerPartsTable)do
		if plyrType == PlayerType[key] then
			for i,parts in ipairs(value)do
				if plyrPartsType == parts[1] then
					--playerType, playerPartType, fpk, parts, fv2
					return { plyrType, plyrPartsType, parts[2], parts[3], parts[4] }
				end
			end
		end
	end	
	return nil
end

return this