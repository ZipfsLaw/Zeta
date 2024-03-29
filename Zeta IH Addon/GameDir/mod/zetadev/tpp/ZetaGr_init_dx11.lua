--ZetaGr_init_dx11.lua
local this={}
function this.GetTable()
	local ret = {
		PluginShadow={
			{name="G7",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
			{name="G8E",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
			{name="Default",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
			{name="Low",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
			{name="Medium",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=1024,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
			{name="High",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
			{name="ExtraHigh",DirectionalLightShadowResolution=8192,SpotLightLightShadowResolution=4096,PointLightLightShadowResolution=8192,CascadeShadowRangeScale=2,EnableCascadeShadowBlend=1}
		},
		PluginSphericalHarmonics={
			{name="G7",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
			{name="G8E",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
			{name="Default",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
			{name="Low",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
			{name="High",DrawSphericalHarmonicsMaxCount=96,RejectionLengthBias=0},
			{name="ExtraHigh",DrawSphericalHarmonicsMaxCount=255,RejectionLengthBias=80}
		},
		PluginLocalLight={
			{name="G7",ShadowCastingStaticLocalLightMaxCount=2,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
			{name="G8E",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
			{name="Default",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
			{name="Low",ShadowCastingStaticLocalLightMaxCount=2,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
			{name="High",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
			{name="ExtraHigh",ShadowCastingStaticLocalLightMaxCount=12,ShadowCastingDynamicLocalLightMaxCount=4,DrawLocalLightMaxCount=512,LocalLightLodLevelBias=-.5,LocalLightLodMinLevel=0,RejectionLengthBias=200}
		},
		PluginModel={
			{name="G7",RejectionLengthBias=0},
			{name="G8E",RejectionLengthBias=0},
			{name="Default",RejectionLengthBias=32},
			{name="Low",RejectionLengthBias=0},
			{name="Medium",RejectionLengthBias=16},
			{name="High",RejectionLengthBias=32},
			{name="ExtraHigh",RejectionLengthBias=128}
		},
		PluginClone={
			{name="G7",RejectionLengthBias=0},
			{name="G8E",RejectionLengthBias=0},
			{name="Default",RejectionLengthBias=64},
			{name="Low",RejectionLengthBias=0},
			{name="Medium",RejectionLengthBias=32},
			{name="High",RejectionLengthBias=64},
			{name="ExtraHigh",RejectionLengthBias=250}
		},
		TextureQualitySettings={
			{name="G7",VramMBSize=700,ReduceMipmap=1},
			{name="Low",VramMBSize=700,ReduceMipmap=1},
			{name="Medium",VramMBSize=1300,ReduceMipmap=0},
			{name="Default",VramMBSize=1800,ReduceMipmap=0},
			{name="High",VramMBSize=1800,ReduceMipmap=0},
			{name="G8E",VramMBSize=1800,ReduceMipmap=0},
			{name="ExtraHigh",VramMBSize=3200,ReduceMipmap=0}
		},
		PluginDof={
			{name="G7",EnableFilter=1,QualityType=0},
			{name="G8E",EnableFilter=1,QualityType=0},
			{name="Default",EnableFilter=1,QualityType=0},
			{name="Off",EnableFilter=0,QualityType=0},
			{name="Low",EnableFilter=0,QualityType=0},
			{name="High",EnableFilter=1,QualityType=0},
			{name="ExtraHigh",EnableFilter=1,QualityType=1}
		},
		PluginFxaa={
			{name="G7",EnableFilter=1},
			{name="G8E",EnableFilter=1},
			{name="Default",EnableFilter=1},
			{name="Off",EnableFilter=0},
			{name="Low",EnableFilter=0},
			{name="High",EnableFilter=1},
			{name="ExtraHigh",EnableFilter=1}
		},
		PluginSsao={
			{name="G7",EnableFilter=1},
			{name="G8E",EnableFilter=1},
			{name="Default",EnableFilter=1},
			{name="Off",EnableFilter=0},
			{name="Low",EnableFilter=0},
			{name="High",EnableFilter=1},
			{name="ExtraHigh",EnableFilter=1}
		},
		PluginSao={
			{name="G7",EnableFilter=0},
			{name="G8E",EnableFilter=0},
			{name="Default",EnableFilter=0},
			{name="Off",EnableFilter=0},
			{name="Low",EnableFilter=0},
			{name="High",EnableFilter=0},
			{name="ExtraHigh",EnableFilter=1}
		},
		PluginMotionBlur={
			{name="G7",EnableFilter=0,BaseAmount=0},
			{name="G8E",EnableFilter=1,BaseAmount=.01},
			{name="Default",EnableFilter=1,BaseAmount=.01},
			{name="Off",EnableFilter=0,BaseAmount=0},
			{name="Low",EnableFilter=0,BaseAmount=0},
			{name="High",EnableFilter=1,BaseAmount=.01},
			{name="ExtraHigh",EnableFilter=1,BaseAmount=.01}
		},
		MotionBlurAmount={
			{name="Off",BlurAmount=0},
			{name="Small",BlurAmount=.25},
			{name="Medium",BlurAmount=.5},
			{name="Large",BlurAmount=1}
		},
		PluginToneMap={
			{name="G7",EnableBloom=1},
			{name="G8E",EnableBloom=1},
			{name="Default",EnableBloom=1},
			{name="Off",EnableBloom=0},
			{name="Low",EnableBloom=1},
			{name="High",EnableBloom=1},
			{name="ExtraHigh",EnableBloom=1}
		},
		PluginLocalReflection={
			{name="G7",EnableFilter=0,FadeOffset=0},
			{name="G8E",EnableFilter=1,FadeOffset=0},
			{name="Default",EnableFilter=1,FadeOffset=0},
			{name="Off",EnableFilter=0,FadeOffset=0},
			{name="Low",EnableFilter=0,FadeOffset=0},
			{name="High",EnableFilter=1,FadeOffset=0},
			{name="ExtraHigh",EnableFilter=1,FadeOffset=.9}
		},
		PluginSubsurfaceScatter={
			{name="G7",EnableFilter=0,FadeOffset=0},
			{name="G8E",EnableFilter=1,FadeOffset=1},
			{name="Default",EnableFilter=1,FadeOffset=1},
			{name="Off",EnableFilter=0,FadeOffset=0},
			{name="Low",EnableFilter=0,FadeOffset=0},
			{name="High",EnableFilter=1,FadeOffset=1},
			{name="ExtraHigh",EnableFilter=1,FadeOffset=1}
		}
	}
	return ret
end
function this.Reload()
	this.settingsTable = {}
	this.settingsTable = this.GetTable()
	if GrGraphicsSettingManager == nil then return nil end
	local newGraphicsSettings = ZetaIndex.ModGet("GraphicsSetting", this)
	if newGraphicsSettings ~= nil and next(newGraphicsSettings) then --Don't override function unless we have mods.
		this.settingsTable = ZetaUtil.MergeTables(this.settingsTable, newGraphicsSettings, "name")
		if ZetaHook.ContainsHook("GrGraphicsSettingManager.SetPluginSettingSelection") == false then
			local newOverride = function(e)
				ZetaHook.NativeFunction("GrGraphicsSettingManager.SetPluginSettingSelection",{allSettings={
					{settingName="PluginShadow",settingTable=this.settingsTable.PluginShadow},
					{settingName="PluginSphericalHarmonics",settingTable=this.settingsTable.PluginSphericalHarmonics},
					{settingName="PluginLocalLight",settingTable=this.settingsTable.PluginLocalLight},
					{settingName="PluginModel",settingTable=this.settingsTable.PluginModel},
					{settingName="PluginClone",settingTable=this.settingsTable.PluginClone},
					{settingName="TextureQualitySettings",settingTable=this.settingsTable.TextureQualitySettings},
					{settingName="PluginDof",settingTable=this.settingsTable.PluginDof},
					{settingName="PluginFxaa",settingTable=this.settingsTable.PluginFxaa},
					{settingName="PluginSsao",settingTable=this.settingsTable.PluginSsao},
					{settingName="PluginSao",settingTable=this.settingsTable.PluginSao},
					{settingName="PluginMotionBlur",settingTable=this.settingsTable.PluginMotionBlur},
					{settingName="MotionBlurAmount",settingTable=this.settingsTable.MotionBlurAmount},
					{settingName="PluginToneMap",settingTable=this.settingsTable.PluginToneMap},
					{settingName="PluginLocalReflection",settingTable=this.settingsTable.PluginLocalReflection},
					{settingName="PluginSubsurfaceScatter",settingTable=this.settingsTable.PluginSubsurfaceScatter},
				}})
				return 0
			end
			ZetaHook.AddHook("GrGraphicsSettingManager.SetPluginSettingSelection", newOverride)
		end
	end
	GrGraphicsSettingManager.SetPluginSettingSelection{} --Don't run until hooked
end
this.Reload() --Reload this on Library Load
return this