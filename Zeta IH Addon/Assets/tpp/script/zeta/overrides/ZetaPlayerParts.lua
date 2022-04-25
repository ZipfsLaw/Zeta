--ZetaPlayerParts.lua
--Description: Handles IHHook's player override system
local this={}

--Updated Caplag's list of player parts
function this.GetTable()
	local SnakeTable = {
		{0,"/Assets/tpp/pack/player/parts/plparts_normal.fpk"},
		{1,"/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk"},
		{2,"/Assets/tpp/pack/player/parts/plparts_gz_suit.fpk"},
		{3,"/Assets/tpp/pack/player/parts/plparts_hospital.fpk"},
		{4,"/Assets/tpp/pack/player/parts/plparts_mgs1.fpk"},
		{5,"/Assets/tpp/pack/player/parts/plparts_ninja.fpk"},
		{6,"/Assets/tpp/pack/player/parts/plparts_raiden.fpk"},
		{7,"/Assets/tpp/pack/player/parts/plparts_naked.fpk"},
		{8,"/Assets/tpp/pack/player/parts/plparts_venom.fpk"},
		{9,"/Assets/tpp/pack/player/parts/plparts_battledress.fpk"},
		{10,"/Assets/tpp/pack/player/parts/plparts_parasite.fpk"},
		{11,"/Assets/tpp/pack/player/parts/plparts_leather.fpk"},
		{12,"/Assets/tpp/pack/player/parts/plparts_gold.fpk"},
		{13,"/Assets/tpp/pack/player/parts/plparts_silver.fpk"},
		{14,"/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk"},
		{15,"/Assets/tpp/pack/player/parts/plparts_dla0_main0_def_v00.fpk"},
		{16,"/Assets/tpp/pack/player/parts/plparts_dla1_main0_def_v00.fpk"},
		{17,"/Assets/tpp/pack/player/parts/plparts_dlb0_main0_def_v00.fpk"},
		{18,"/Assets/tpp/pack/player/parts/plparts_dld0_main0_def_v00.fpk"},
		{19,"/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk"},
		{20,"/Assets/tpp/pack/player/parts/plparts_dle1_plyf0_def_v00.fpk"},
		{21,"/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk"},
		{22,"/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk"},
		{23,"/Assets/tpp/pack/player/parts/plparts_normal.fpk"},
		{24,"/Assets/tpp/pack/player/parts/plparts_normal.fpk"},
		{25,"/Assets/tpp/pack/player/parts/plparts_normal.fpk"},
		{26,"/Assets/tpp/pack/player/parts/plparts_normal.fpk"},
		{27,0},
	}		
	local table = {
		playerPartsTypeTable={
			SNAKE=SnakeTable,
			DD_MALE={
				{0,"/Assets/tpp/pack/player/parts/plparts_dd_male.fpk"},
				{1,"/Assets/tpp/pack/player/parts/plparts_dd_male.fpk"},
				{2,"/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk"},
				{3,"/Assets/tpp/pack/player/parts/plparts_hospital.fpk"},
				{4,"/Assets/tpp/pack/player/parts/plparts_mgs1.fpk"},
				{5,"/Assets/tpp/pack/player/parts/plparts_ninja.fpk"},
				{6,"/Assets/tpp/pack/player/parts/plparts_raiden.fpk"},
				{7,"/Assets/tpp/pack/player/parts/plparts_naked.fpk"},
				{8,"/Assets/tpp/pack/player/parts/plparts_ddm_venom.fpk"},
				{9,"/Assets/tpp/pack/player/parts/plparts_ddm_battledress.fpk"},
				{10,"/Assets/tpp/pack/player/parts/plparts_ddm_parasite.fpk"},
				{11,"/Assets/tpp/pack/player/parts/plparts_leather.fpk"},
				{12,0},
				{13,0},
				{14,"/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk"},
				{15,"/Assets/tpp/pack/player/parts/plparts_dla0_plym0_def_v00.fpk"},
				{16,"/Assets/tpp/pack/player/parts/plparts_dla1_plym0_def_v00.fpk"},
				{17,"/Assets/tpp/pack/player/parts/plparts_dlb0_plym0_def_v00.fpk"},
				{18,"/Assets/tpp/pack/player/parts/plparts_dld0_plym0_def_v00.fpk"},
				{19,0},
				{20,0},
				{21,0},
				{22,0},
				{23,"/Assets/tpp/pack/player/parts/plparts_ddm_swimwear.fpk"},
				{24,"/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_g.fpk"},
				{25,"/Assets/tpp/pack/player/parts/plparts_ddm_swimwear_h.fpk"},
				{26,"/Assets/tpp/pack/player/parts/plparts_dd_male.fpk"},
				{27,0,0,0},
			},
			DD_FEMALE={
				{0,"/Assets/tpp/pack/player/parts/plparts_dd_female.fpk"},
				{1,"/Assets/tpp/pack/player/parts/plparts_dd_female.fpk"},
				{2,"/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk"},
				{3,"/Assets/tpp/pack/player/parts/plparts_hospital.fpk"},
				{4,"/Assets/tpp/pack/player/parts/plparts_mgs1.fpk"},
				{5,"/Assets/tpp/pack/player/parts/plparts_ninja.fpk"},
				{6,"/Assets/tpp/pack/player/parts/plparts_raiden.fpk"},
				{7,"/Assets/tpp/pack/player/parts/plparts_naked.fpk"},
				{8,"/Assets/tpp/pack/player/parts/plparts_ddf_venom.fpk"},
				{9,"/Assets/tpp/pack/player/parts/plparts_ddf_battledress.fpk"},
				{10,"/Assets/tpp/pack/player/parts/plparts_ddf_parasite.fpk"},
				{11,"/Assets/tpp/pack/player/parts/plparts_leather.fpk"},
				{12,0},
				{13,0},
				{14,"/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk"},
				{15,0},
				{16,0},
				{17,0},
				{18,0},
				{19,"/Assets/tpp/pack/player/parts/plparts_dle0_plyf0_def_v00.fpk"},
				{20,"/Assets/tpp/pack/player/parts/plparts_dle1_plyf0_def_v00.fpk"},
				{21,"/Assets/tpp/pack/player/parts/plparts_dlc0_plyf0_def_v00.fpk"},
				{22,"/Assets/tpp/pack/player/parts/plparts_dlc1_plyf0_def_v00.fpk"},
				{23,"/Assets/tpp/pack/player/parts/plparts_ddf_swimwear.fpk"},
				{24,"/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_g.fpk"},
				{25,"/Assets/tpp/pack/player/parts/plparts_ddf_swimwear_h.fpk"},
				{26,"/Assets/tpp/pack/player/parts/plparts_dd_female.fpk"},
				{27,0},
			},
			AVATAR=SnakeTable,
			LIQUID={"/Assets/tpp/pack/player/parts/plparts_liquid.fpk"},
			OCELOT={"/Assets/tpp/pack/player/parts/plparts_ocelot.fpk"},
			QUIET={"/Assets/tpp/pack/player/parts/plparts_quiet.fpk"},
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

function this.GetCamoTable()
	local table={
		OLIVEDRAB=0,
		SPLITTER=1,
		SQUARE=2,
		TIGERSTRIPE=3,
		GOLDTIGER=4,
		FOXTROT=5,
		WOODLAND=6,
		WETWORK=7,
		ARBANGRAY=8,
		ARBANBLUE=9,
		SANDSTORM=10,
		--REALTREE=11, --does not set
		--INVISIBLE=12, --does not set
		BLACK=13,
		PANTHER=26,
		C23=36,--WOODLAND FLECK
		C24=37,--AMBUSH
		C27=38,--SOLUM
		C29=39,--DEAD LEAF
		C30=40,--LICHEN
		C35=41,--STONE
		C38=42,--PARASITE MIST
		C39=43,--OLD ROSE
		C42=44,--BRICK RED
		C46=45,--IRON BLUE
		C49=46,--STEEL GREY
		C52=47,--TSELINOYARSK
		C16=48,--NIGHT SPLITTER
		C17=49,--RAIN
		C18=50,--GREEN TIGER STRIPE
		C19=51,--BIRCH LEAF
		C20=52,--DESERT AMBUSH
		C22=53,--DARK LEAF FLECK
		C25=54,--NIGHT BUSH
		C26=55,--GRASS
		C28=56,--RIPPLE
		C31=57,--CITRULLUS
		C32=58,--DIGITAL BUSH
		C33=59,--ZEBRA
		C36=60,--DESERT SAND
		C37=61,--STEEL KHAKI
		C40=62,--DARK RUBBER
		C41=63,--GRAY
		C43=64,--CAMOFLAGE YELLOW
		C44=65,--CAMOFLAGE GREEN
		C45=66,--IRON GREEN
		C47=67,--LIGHT RUBBER
		C48=68,--RED RUST
		C50=69,--STEEL GREEN
		C51=70,--STEEL ORANGE
		C53=71,--MUD
		C54=72,--STEEL BLUE
		C55=73,--DARK RUST
		C56=74,--CITRULLUS TWO-TONE
		C57=75,--GOLD TIGER STRIPE TWO-TONE
		C58=76,--BIRCH LEAF TWO-TONE
		C59=77,--STONE TWO-TONE
		C60=78,--KHAKI URBAN TWO-TONE
	  }
	  return table
end

function this.Reload()	
	local orderedList = {}
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
	
	--Clear override
	if this.newPlayerParts ~= nil and next(this.newPlayerParts) then
		if IhkCharacter ~= nil then
			IhkCharacter.SetOverrideCharacterSystem(false)
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
	or this.curPlayerCamoType ~= vars.playerCamoType 
	or this.safeOverrideActive ~= safeOverride then	
		--If any parts were found, apply them when their target parts are active
		if IhkCharacter ~= nil then
			local newOverride = false	
			local getCurrentParts = this.GetCurrentPartsList()
			if getCurrentParts ~= nil and next(getCurrentParts) then
				this.newPlayerParts = getCurrentParts
				newOverride = safeOverride --Override when it's safe
			end
			local usePlayer = {"","",""}
			local useHead = {false,"",""}
			local useHand = {false,"",""}	
			local useCamo = {false,"",""}

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

							--Camo
							local camoPart = partsList[4]
							if camoPart ~= nil then			
								if type(camoPart) == "table" then
									if next(camoPart) then
										useCamo[1] = true
										if camoPart[1] ~= nil then useCamo[2] = camoPart[1] end
										if camoPart[2] ~= nil then useCamo[3] = camoPart[2] end
									end
								else 
									useCamo[1] = camoPart 
									useCamo[2] = ""
									useCamo[3] = ""
								end
							end
						end	
					end
				end					
			end
			
			--Set before all for validation!
			IhkCharacter.SetPlayerTypeForPartsType(vars.playerType)
			IhkCharacter.SetPlayerPartsTypeForPartsType(vars.playerPartsType)
			
			--Overrides current parts
			if newOverride == false then
				IhkCharacter.SetOverrideCharacterSystem(newOverride) 
			end
							
			--Body
			IhkCharacter.SetPlayerPartsFpkPath(usePlayer[1]) 	
			IhkCharacter.SetPlayerPartsPartsPath(usePlayer[2]) 
			IhkCharacter.SetSkinToneFv2Path(usePlayer[3])

			--Head
			IhkCharacter.SetUseHeadForPlayerParts(useHead[1])
			IhkCharacter.SetSnakeFaceFpkPath(useHead[2])
			IhkCharacter.SetSnakeFaceFv2Path(useHead[3])

			--Bionic hand
			IhkCharacter.SetUseBionicHandForPlayerParts(useHand[1])
			IhkCharacter.SetBionicHandFpkPath(useHand[2])
			IhkCharacter.SetBionicHandFv2Path(useHand[3])

			--Camo
			IhkCharacter.SetUseCamoForPlayerParts(useCamo[1])
			IhkCharacter.SetPlayerCamoFpkPath(useCamo[2])
			IhkCharacter.SetPlayerCamoFv2Path(useCamo[3])

			--Overrides current parts
			if newOverride == true then
				IhkCharacter.SetOverrideCharacterSystem(newOverride) 
			end		
			
			if safeOverride == true then
				--if this.curPlayerType == vars.playerType then
				--	this.ReloadPlayerPartsSafe(true)
				--end
				
				this.curPlayerType = vars.playerType
				this.curPlayerPartsType = vars.playerPartsType
				this.curPlayerFaceId = vars.playerFaceId
				this.curPlayerFaceEquipId = vars.playerFaceEquipId
				this.curPlayerCamoType = vars.playerCamoType 
				
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
			local getCurrentPartsPath = this.GetPartPaths( vars.playerType, vars.playerPartsType, vars.playerCamoType )
			if getCurrentPartsPath ~= nil and next(getCurrentPartsPath) then
				for i,partsList in ipairs(this.playerParts)do
					local playerSelect = partsList[1]
					if playerSelect ~= nil then
						local curParts = { partsList[2], partsList[3], partsList[4],partsList[5],partsList[6] }
						local typePS = type(playerSelect)
						
						if typePS == "table" then --matches with table { playerType, playerPartsType }
							if next(playerSelect) then
								local modPlyrType = playerSelect[1] --Player Type
								if getCurrentPartsPath["PlayerType"] == PlayerType[modPlyrType] then
									if getCurrentPartsPath["PlayerPartsType"] == playerSelect[2] --Player Parts Type
									or playerSelect[2] == nil then --can be nil so it always applies to playerType
										if getCurrentPartsPath["CamoType"] == PlayerCamoType[playerSelect[3]] --Player Camo Type
										or playerSelect[3] == nil then --can be nil so it always applies to playerType
											table.insert(playerPartsList,curParts)
										end
									end
								end
							end
						elseif typePS == "number" then --Matches with playerPartType
							if getCurrentPartsPath["PlayerPartsType"] == playerSelect then				
								table.insert(playerPartsList,curParts)
							end
						elseif typePS == "string" then --Matches with FPK name.
							if playerSelect ~= "" then
								if string.match( getCurrentPartsPath["FpkPath"], playerSelect ) then				
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

function this.GetPartPaths(plyrType,plyrPartsType,camoType)
	local playerPartsTable = this.GetTable()["playerPartsTypeTable"]
	for key,value in pairs(playerPartsTable)do
		if plyrType == PlayerType[key] then
			for i,parts in ipairs(value)do
				if plyrPartsType == parts[1] then
					return { 
						PlayerType = plyrType, 
						PlayerPartsType = plyrPartsType,
						CamoType = camoType, 
						FpkPath = parts[2],
					} 
				end
			end
		end
	end	
	return nil
end

return this