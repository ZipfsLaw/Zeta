--ZetaEquipMotionData.lua
local this={}

--Tables ( Contains vanilla stats )
function this.GetTable()
	local table={
		{TppEquip.EQP_WP_West_hg_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg00_asm.mtar"},
		{TppEquip.EQP_WP_West_hg_010_WG,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg00_asm.mtar"},
		{TppEquip.EQP_WP_West_hg_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg00_asm.mtar"},
		{TppEquip.EQP_WP_West_hg_030,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg10_asm.mtar"},
		{TppEquip.EQP_WP_East_hg_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg08_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_010_WG,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_014,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_015,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm02_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm00_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm00_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_030,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm00_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_042,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_043,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_044,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_045,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_011,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_011_FL,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_013,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg04_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_015,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg04_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg04_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_020_FL,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg04_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_023,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_024,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_025,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_030,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_010_FL,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_055,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_020_FL,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_030,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_040,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_042,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_050,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_060,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_063,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_075,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_070,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_East_ar_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar01_asm.mtar"},
		{TppEquip.EQP_WP_East_ar_010_FL,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar01_asm.mtar"},
		{TppEquip.EQP_WP_East_ar_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar01_asm.mtar"},
		{TppEquip.EQP_WP_East_ar_030,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar01_asm.mtar"},
		{TppEquip.EQP_WP_East_ar_030_FL,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar01_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_011,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr01_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_013,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_014,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr01_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_037,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_East_sr_011,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr02_asm.mtar"},
		{TppEquip.EQP_WP_East_sr_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr03_asm.mtar"},
		{TppEquip.EQP_WP_East_sr_032,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr02_asm.mtar"},
		{TppEquip.EQP_WP_East_sr_033,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr02_asm.mtar"},
		{TppEquip.EQP_WP_East_sr_034,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr02_asm.mtar"},
		{TppEquip.EQP_WP_Quiet_sr_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr02qui_asm.mtar"},
		{TppEquip.EQP_WP_Quiet_sr_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr02qui_asm.mtar"},
		{TppEquip.EQP_WP_Quiet_sr_030,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr04qui_asm.mtar"},
		{TppEquip.EQP_WP_BossQuiet_sr_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr02qui_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg03_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_023,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_024,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_021,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_030,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_East_mg_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg02_asm.mtar"},
		{TppEquip.EQP_WP_West_ms_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms02_asm.mtar"},
		{TppEquip.EQP_WP_West_ms_020,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms02_asm.mtar"},
		{TppEquip.EQP_WP_HoneyBee,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms03_asm.mtar"},
		{TppEquip.EQP_WP_Volgin_sg_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_SP_hg_010,"/Assets/tpp/motion/mtar/equip/chimera/receiver/hg06_default.mtar"},
		{TppEquip.EQP_WP_SP_hg_020,"/Assets/tpp/motion/mtar/equip/chimera/receiver/hg00_default.mtar"},
		{TppEquip.EQP_WP_SP_sm_010,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sm02_default.mtar"},
		{TppEquip.EQP_WP_SP_sg_010,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sg02_default.mtar"},
		{TppEquip.EQP_WP_EX_hg_000,"/Assets/tpp/motion/mtar/equip/chimera/receiver/hg01_default.mtar"},
		{TppEquip.EQP_WP_EX_hg_000_G01,"/Assets/tpp/motion/mtar/equip/chimera/receiver/hg01_default.mtar"},
		{TppEquip.EQP_WP_EX_hg_000_G02,"/Assets/tpp/motion/mtar/equip/chimera/receiver/hg01_default.mtar"},
		{TppEquip.EQP_WP_EX_hg_000_G03,"/Assets/tpp/motion/mtar/equip/chimera/receiver/hg01_default.mtar"},
		{TppEquip.EQP_WP_EX_hg_000_G04,"/Assets/tpp/motion/mtar/equip/chimera/receiver/hg01_default.mtar"},
		{TppEquip.EQP_WP_EX_gl_000,"/Assets/tpp/motion/mtar/equip/chimera/receiver/gl00_default.mtar"},
		{TppEquip.EQP_WP_EX_sr_000,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sr04_default.mtar"},
		{TppEquip.EQP_WP_West_sm_016,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_017,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_038,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_016,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg04_asm.mtar"},
		{TppEquip.EQP_WP_Com_sg_018,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sg04_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_027,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_047,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_048,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_037,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_Com_ms_026,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms03_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_019,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_01a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_sm_01b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_049,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_04a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_East_sm_04b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sm01_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_059,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_05a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_05b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar00_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_079,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_07a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_ar_07b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ar03_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_029,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_02a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_02b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_049,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_04a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_sr_04b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/sr00_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_039,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_03a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_West_mg_03b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/mg01_asm.mtar"},
		{TppEquip.EQP_WP_West_ms_029,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms02_asm.mtar"},
		{TppEquip.EQP_WP_West_ms_02a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms02_asm.mtar"},
		{TppEquip.EQP_WP_West_ms_02b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms02_asm.mtar"},
		{TppEquip.EQP_WP_Com_ms_029,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms03_asm.mtar"},
		{TppEquip.EQP_WP_Com_ms_02a,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms03_asm.mtar"},
		{TppEquip.EQP_WP_Com_ms_02b,"/Assets/tpp/motion/mtar/equip/chimera/assemble/ms03_asm.mtar"},
		{TppEquip.EQP_WP_EX_hg_010,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg03_asm.mtar"},
		{TppEquip.EQP_WP_EX_hg_011,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg03_asm.mtar"},
		{TppEquip.EQP_WP_EX_hg_012,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg03_asm.mtar"},
		{TppEquip.EQP_WP_EX_hg_013,"/Assets/tpp/motion/mtar/equip/chimera/assemble/hg03_asm.mtar"},
		{TppEquip.EQP_WP_60605,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sr02_default.mtar"},
		{TppEquip.EQP_WP_60606,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sr02_default.mtar"},
		{TppEquip.EQP_WP_60607,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sr02_default.mtar"},
		{TppEquip.EQP_WP_60615,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sr02_default.mtar"},
		{TppEquip.EQP_WP_60616,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sr02_default.mtar"},
		{TppEquip.EQP_WP_60617,"/Assets/tpp/motion/mtar/equip/chimera/receiver/sr02_default.mtar"},
	}
	return table
end

function this.Reload()
	--Clear and load vanilla table
	this.motionDataTable = {}
	this.motionDataTable = this.GetTable()
	
	--Load mods
	ZetaIndex.ModFunction("SetEquipMotionData", this ) --Passthrough
	local newMotionDataTable = ZetaIndex.ModGet("EquipMotionData", this)
	if newMotionDataTable ~= nil and next(newMotionDataTable) then
		this.motionDataTable = ZetaUtil.MergeParams(this.motionDataTable, newMotionDataTable, false)
	end
	TppEquip.ReloadEquipMotionData{MotionDataTable=this.motionDataTable}
end

return this