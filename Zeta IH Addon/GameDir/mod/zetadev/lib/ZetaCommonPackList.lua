--ZetaCommonPackList.lua
--Purpose: Various overrides for TppDefine, TppReinforceBlock
local ZetaCommonPackList={}

function ZetaCommonPackList.GetReinforcePacks()
	local ret ={
		[TppReinforceBlock.REINFORCE_TYPE.NONE]="",
		[TppReinforceBlock.REINFORCE_TYPE.EAST_WAV]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav.fpk",
		[TppReinforceBlock.REINFORCE_TYPE.EAST_WAV_ROCKET]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav_roc.fpk",
		[TppReinforceBlock.REINFORCE_TYPE.WEST_WAV]={
			PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_a.fpk",
			PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_b.fpk",
			PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_c.fpk"
		},
		[TppReinforceBlock.REINFORCE_TYPE.WEST_WAV_CANNON]={
			PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_a.fpk",
			PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_b.fpk",
			PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_c.fpk"
		},
		[TppReinforceBlock.REINFORCE_TYPE.EAST_TANK]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_tnk.fpk",
		[TppReinforceBlock.REINFORCE_TYPE.WEST_TANK]={
			PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_a.fpk",
			PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_b.fpk",
			PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_c.fpk"
		},
		[TppReinforceBlock.REINFORCE_TYPE.HELI]={
			AFGH={
				_DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk",
				[TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
				[TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
			},
			MAFR={
				_DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",
				[TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
				[TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
			},
			MTBS={--tex>
				_DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",
				[TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
				[TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
			}--<
		}
	}
	return ret
end

function ZetaCommonPackList.GetCommonMissionPacks()
	local ret={
		AFGH_SCRIPT="/Assets/tpp/pack/location/afgh/pack_common/afgh_script.fpk",
		MAFR_SCRIPT="/Assets/tpp/pack/location/mafr/pack_common/mafr_script.fpk",
		CYPR_SCRIPT="/Assets/tpp/pack/location/cypr/pack_common/cypr_script.fpk",
		MTBS_SCRIPT="/Assets/tpp/pack/location/mtbs/pack_common/mtbs_script.fpk",
		AFGH_MISSION_AREA="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
		MAFR_MISSION_AREA="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
		MTBS_MISSION_AREA="/Assets/tpp/pack/mission2/common/mis_com_mtbs.fpk",
		AFGH_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_afgh_hostage.fpk",
		MAFR_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage.fpk",
		MAFR_HOSTAGE_WOMAN="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk",
		HELICOPTER="/Assets/tpp/pack/mission2/common/mis_com_helicopter.fpk",
		ENEMY_HELI="/Assets/tpp/pack/mission2/common/mis_com_enemy_heli.fpk",
		ORDER_BOX="/Assets/tpp/pack/mission2/common/mis_com_order_box.fpk",
		CODETALKER="/Assets/tpp/pack/mission2/common/mis_com_codetalker.fpk",
		HUEY="/Assets/tpp/pack/mission2/common/mis_com_huey.fpk",
		LIQUID="/Assets/tpp/pack/mission2/common/mis_com_liquid.fpk",
		MANTIS="/Assets/tpp/pack/mission2/common/mis_com_mantis.fpk",
		MILLER="/Assets/tpp/pack/mission2/common/mis_com_miller.fpk",
		OCELOT="/Assets/tpp/pack/mission2/common/mis_com_ocelot.fpk",
		QUIET="/Assets/tpp/pack/mission2/common/mis_com_quiet.fpk",
		SAHELAN="/Assets/tpp/pack/mission2/common/mis_com_sahelan.fpk",
		SKULLFACE="/Assets/tpp/pack/mission2/common/mis_com_skullface.fpk",
		PF_SOLIDER="/Assets/tpp/pack/mission2/common/mis_com_pf_solider.fpk",
		SOVIET_SOLIDER="/Assets/tpp/pack/mission2/common/mis_com_soviet_solider.fpk",
		DD_SOLDIER_WAIT="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",
		VOLGIN="/Assets/tpp/pack/mission2/common/mis_com_volgin.fpk",
		WALKERGEAR="/Assets/tpp/pack/mission2/common/mis_com_walkergear.fpk",
		CHILD_SOLDIER="/Assets/tpp/pack/mission2/common/mis_com_child_soldier.fpk",
		XOF_SOLDIER="/Assets/tpp/pack/mission2/common/mis_com_xof_soldier.fpk",
		DD_SOLDIER_ATTACKER="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",
		DD_SOLDIER_SNEAKING="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",
		DD_SOLDIER_BTRDRS="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",
		DD_SOLDIER_ARMOR="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",
		FOB_HOSTAGE="/Assets/tpp/pack/mission2/common/mis_com_fob_hostage.fpk",
		DD_SOLDIER_SWIM_SUIT="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit.fpk",--RETAILPATCH: 1.10
		DD_SOLDIER_SWIM_SUIT2="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit2.fpk",--RETAILPATCH 1.0.11
		DD_SOLDIER_SWIM_SUIT3="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit3.fpk",--RETAILPATCH 1.0.11
		AFGH_DECOY="/Assets/tpp/pack/collectible/decoy/decoy_svs.fpk",
		MAFR_DECOY="/Assets/tpp/pack/collectible/decoy/decoy_pf.fpk",
		MTBS_DECOY="/Assets/tpp/pack/collectible/decoy/decoy_fob.fpk",
		BEAR="/Assets/tpp/pack/mission2/common/mis_com_bear.fpk",
		RAVEN="/Assets/tpp/pack/mission2/common/mis_com_raven.fpk",
		RAT="/Assets/tpp/pack/mission2/common/mis_com_rat.fpk",
		LYCAON="/Assets/tpp/pack/mission2/common/mis_com_lycaon.fpk",
		JACKAL="/Assets/tpp/pack/mission2/common/mis_com_jackal.fpk",
		EAST_LV="/Assets/tpp/pack/mission2/common/veh_mc_east_lv.fpk",
		EAST_TANK="/Assets/tpp/pack/mission2/common/veh_mc_east_tnk.fpk",
		EAST_TRUCK="/Assets/tpp/pack/mission2/common/veh_mc_east_trc.fpk",
		EAST_TRUCK_AMMUNITION="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_ammunition.fpk",
		EAST_TRUCK_DRUM="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_drum.fpk",
		EAST_TRUCK_GENERATOR="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_generator.fpk",
		EAST_TRUCK_MATERIAL="/Assets/tpp/pack/mission2/common/veh_mc_east_trc_crg_material.fpk",
		EAST_WAV="/Assets/tpp/pack/mission2/common/veh_mc_east_wav.fpk",
		EAST_WAV_ROCKET="/Assets/tpp/pack/mission2/common/veh_mc_east_wav_rocket.fpk",
		WEST_LV="/Assets/tpp/pack/mission2/common/veh_mc_west_lv.fpk",
		WEST_TANK="/Assets/tpp/pack/mission2/common/veh_mc_west_tnk.fpk",
		WEST_TRUCK="/Assets/tpp/pack/mission2/common/veh_mc_west_trc.fpk",
		WEST_TRUCK_CISTERN="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_crg_cistern.fpk",
		WEST_TRUCK_CONTAINER="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_crg_container.fpk",
		WEST_TRUCK_ITEMBOX="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_crg_itembox.fpk",
		WEST_TRUCK_HOOD="/Assets/tpp/pack/mission2/common/veh_mc_west_trc_hood.fpk",
		WEST_WAV="/Assets/tpp/pack/mission2/common/veh_mc_west_wav.fpk",
		WEST_WAV_CANNON="/Assets/tpp/pack/mission2/common/veh_mc_west_wav_trt_cannon.fpk",
		WEST_WAV_MACHINE_GUN="/Assets/tpp/pack/mission2/common/veh_mc_west_wav_trt_machinegun.fpk",
		AMBULANCE="/Assets/tpp/pack/mission2/common/veh_mc_ambulance.fpk",
		AVATAR_EDIT="/Assets/tpp/pack/mission2/common/mis_com_avatar_edit.fpk",
		AVATAR_ASSET_LIST={
			"/Assets/tpp/pack/player/avatar/deform/avm_dfrm_men_mtar.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type0_v00.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type1_v00.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type2_v00.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type3_v00.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type4_v00.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type5_v00.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type6_v00.fpk",
			"/Assets/tpp/pack/player/avatar/face/plfova_avm0_type7_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type0_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type1_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type2_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type3_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type4_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type5_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type6_v00.fpk",
			"/Assets/tpp/pack/player/avatar/deform/pldfrm_avm0_type7_v00.fpk",
			"/Assets/tpp/pack/player/avatar/hair/plfova_avm_hair_a0_v00.fpk",
			"/Assets/tpp/pack/player/avatar/hair/plfova_avm_hair_b0_v00.fpk",
			"/Assets/tpp/pack/player/avatar/hair/plfova_avm_hair_c0_v00.fpk",
			"/Assets/tpp/pack/player/parts/plparts_avatar_man.fpk",
			"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c00.fpk",
			"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c01.fpk",
			"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c02.fpk",
			"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c03.fpk",
			"/Assets/tpp/pack/player/avatar/body/plfova_avm0_main0_skin0_c04.fpk",
			"/Assets/tpp/pack/ui/ui_avatar_edit_men.fpk"
		}
	}
	return ret
end

function ZetaCommonPackList.Reload()	
	--Reload reinforce packs
	if TppReinforceBlock ~= nil then
		ZetaCommonPackList.reinforcePacks = {}
		ZetaCommonPackList.reinforcePacks = ZetaCommonPackList.GetReinforcePacks()
		local newReinforcePacks = ZetaIndex.ModGet("ReinforcePack", this)
		if newReinforcePacks ~= nil and next(newReinforcePacks) then
			ZetaCommonPackList.reinforcePacks = ZetaUtil.MergeTables(ZetaCommonPackList.reinforcePacks, newReinforcePacks, true)
		end
		TppReinforceBlock.REINFORCE_FPK = ZetaUtil.MergeTablesByIndex(TppReinforceBlock.REINFORCE_FPK, ZetaCommonPackList.reinforcePacks)
	end
	--Reload common mission packs with mods
	if TppDefine ~= nil then
		ZetaCommonPackList.commonMissionPacks = {}
		ZetaCommonPackList.commonMissionPacks = ZetaCommonPackList.GetCommonMissionPacks()
		local newCommonMissionPacks = ZetaIndex.ModGet("MissionCommonPack", this)
		if newCommonMissionPacks ~= nil and next(newCommonMissionPacks) then
			ZetaCommonPackList.commonMissionPacks = ZetaUtil.MergeTables(ZetaCommonPackList.commonMissionPacks, newCommonMissionPacks, true)
		end
		TppDefine.MISSION_COMMON_PACK = ZetaUtil.MergeTablesByIndex(TppDefine.MISSION_COMMON_PACK, ZetaCommonPackList.commonMissionPacks)
	end
end

return ZetaCommonPackList