local this ={}
this.modName = "Advanced Graphic Settings"
this.modDesc = "Provides additional graphic settings that modify the 'Extra High' preset."
this.modCategory = "Extensions"
this.modAuthor = "(ZIP)"

--ShadowsListOption
this.shadowDirResRangeLabel = {"2px","4px","8px","16px","32px","64px","128px","256px","512px","1024px","2048px","4096px","8192px"}
this.shadowCascadeRangeLabel = {"2 cascades","3 cascades","4 cascades"}
this.shadowDirResRange = {2,4,8,16,32,64,128,256,512,1024,2048,4096,8192}
this.shadowCascadeRange = {2,3,4}

function this.ModMenu(menu)
	ZetaMenu.CreateMenu(
	menu,  
	{"ZetaUI.modCustomMenu"},
	"adGrOptions",
	"adGrSettings", 
	"Advanced Graphic Settings", 
	"Modify additional 'Extra High' graphic settings. To apply settings in-game, go to 'Graphic Settings' and select 'Ok'.")
	
	local funcReload = function()ZetaCore.ReloadGr()end	
	ZetaMenu.AddItemToMenu(
	menu, 
	ZetaMenu.ListOption(this.shadowDirResRangeLabel,12,funcReload),  
	"adGrOptions", 
	"ZetaCustomSetting", 
	"DirectionalLightShadowResolution", 
	"Dir. Light Shadow Resolution", 
	"Change shadow resolution of directional lighting.")
	
	ZetaMenu.AddItemToMenu(
	menu, 
	ZetaMenu.ListOption(this.shadowCascadeRangeLabel,2,funcReload),  
	"adGrOptions", 
	"ZetaCustomSetting", 
	"ShadowCascadeRange", 
	"Shadow Cascading Detail", 
	"Change the number of shadow cascades.")
	
	ZetaMenu.AddItemToMenu(
	menu, 
	ZetaMenu.NumberOption(128, 2048, 32, 128, funcReload),  
	"adGrOptions", 
	"ZetaCustomSetting", 
	"ModelDrawDistance", 
	"Model Draw Distance", 
	"Change the draw distance for models.")
	
	 --ZIP: Evergreen says 2560 was the stable max distance for this
	ZetaMenu.AddItemToMenu(
	menu, 
	ZetaMenu.NumberOption(250, 2560, 32, 250, funcReload),
	"adGrOptions", 
	"ZetaCustomSetting", 
	"CloneDrawDistance", 
	"Clone Draw Distance", 
	"Change the draw distance for clones.")
	
	ZetaMenu.AddItemToMenu(
	menu, 
	ZetaMenu.BoolOption(1,funcReload),  
	"adGrOptions", 
	"ZetaCustomSetting", 
	"EnableFXAA", 
	"FXAA Post Process", 
	"Toggle the FXAA post process effect.")
	
	ZetaMenu.AddItemToMenu(
	menu, 
	ZetaMenu.BoolOption(0,funcReload),  
	"adGrOptions", 
	"ZetaCustomSetting", 
	"ReduceMipmaps", 
	"Mipmap Reduction", 
	"Reduces quality of certain textures to reduce Vram usage.")
end

function this.GraphicsSetting(gr)
	--Shadows
	local shadowDetailDir = ZetaMenu.GetIvar("ZetaCustomSettingDirectionalLightShadowResolution") + 1
	local shadowCacadeDetail = ZetaMenu.GetIvar("ZetaCustomSettingShadowCascadeRange") + 1
	local highDirLight = this.shadowDirResRange[shadowDetailDir] 
	local highShadowCascade = this.shadowCascadeRange[shadowCacadeDetail]
	
	--Draw Dist 
	local modelDrawDist = ZetaMenu.GetIvar("ZetaCustomSettingModelDrawDistance") 
	local cloneDrawDist = ZetaMenu.GetIvar("ZetaCustomSettingCloneDrawDistance")
	
	--Optimization/Effects
	local newReduceMips = ZetaMenu.GetIvar("ZetaCustomSettingReduceMipmaps") 
	local newFXAA = ZetaMenu.GetIvar("ZetaCustomSettingEnableFXAA")
	
	gr.settingsTable={
      {settingName="PluginShadow",
        settingTable={
          {name="G7",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
		  {name="G8E",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
		  {name="Default",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
		  {name="Low",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
		  {name="Medium",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=1024,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
		  {name="High",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
          {name="ExtraHigh",DirectionalLightShadowResolution=highDirLight,SpotLightLightShadowResolution=4096,PointLightLightShadowResolution=8192,CascadeShadowRangeScale=highShadowCascade,EnableCascadeShadowBlend=1}
		}},
      {settingName="PluginSphericalHarmonics",
        settingTable={
          {name="G7",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
          {name="G8E",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
          {name="Default",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
          {name="Low",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},
          {name="High",DrawSphericalHarmonicsMaxCount=96,RejectionLengthBias=0},
          {name="ExtraHigh",DrawSphericalHarmonicsMaxCount=255,RejectionLengthBias=80}
        }},
      {settingName="PluginLocalLight",
        settingTable={
          {name="G7",ShadowCastingStaticLocalLightMaxCount=2,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
          {name="G8E",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
          {name="Default",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
          {name="Low",ShadowCastingStaticLocalLightMaxCount=2,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
          {name="High",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},
          {name="ExtraHigh",ShadowCastingStaticLocalLightMaxCount=12,ShadowCastingDynamicLocalLightMaxCount=4,DrawLocalLightMaxCount=512,LocalLightLodLevelBias=-.5,LocalLightLodMinLevel=0,RejectionLengthBias=200}
        }},
      {settingName="PluginModel",
        settingTable={
          {name="G7",RejectionLengthBias=0},
          {name="G8E",RejectionLengthBias=0},
          {name="Default",RejectionLengthBias=32},
          {name="Low",RejectionLengthBias=0},
          {name="Medium",RejectionLengthBias=16},
          {name="High",RejectionLengthBias=32},
          {name="ExtraHigh",RejectionLengthBias=modelDrawDist}
        }},
      {settingName="PluginClone",
        settingTable={
          {name="G7",RejectionLengthBias=0},
          {name="G8E",RejectionLengthBias=0},
          {name="Default",RejectionLengthBias=64},
          {name="Low",RejectionLengthBias=0},
          {name="Medium",RejectionLengthBias=32},
          {name="High",RejectionLengthBias=64},
          {name="ExtraHigh",RejectionLengthBias=cloneDrawDist}
        }},
      {settingName="TextureQualitySettings",
        settingTable={
          {name="G7",VramMBSize=700,ReduceMipmap=1},
          {name="Low",VramMBSize=700,ReduceMipmap=1},
          {name="Medium",VramMBSize=1300,ReduceMipmap=0},
          {name="Default",VramMBSize=1800,ReduceMipmap=0},
          {name="High",VramMBSize=1800,ReduceMipmap=0},
          {name="G8E",VramMBSize=1800,ReduceMipmap=0},
          {name="ExtraHigh",VramMBSize=3200,ReduceMipmap=newReduceMips}
        }},
      {settingName="PluginDof",
        settingTable={
          {name="G7",EnableFilter=1,QualityType=0},
          {name="G8E",EnableFilter=1,QualityType=0},
          {name="Default",EnableFilter=1,QualityType=0},
          {name="Off",EnableFilter=0,QualityType=0},
          {name="Low",EnableFilter=0,QualityType=0},
          {name="High",EnableFilter=1,QualityType=0},
          {name="ExtraHigh",EnableFilter=1,QualityType=1}
        }},
      {settingName="PluginFxaa",
        settingTable={
          {name="G7",EnableFilter=1},
          {name="G8E",EnableFilter=1},
          {name="Default",EnableFilter=1},
          {name="Off",EnableFilter=0},
          {name="Low",EnableFilter=0},
          {name="High",EnableFilter=1},
          {name="ExtraHigh",EnableFilter=newFXAA}
        }},
      {settingName="PluginSsao",
        settingTable={
          {name="G7",EnableFilter=1},
          {name="G8E",EnableFilter=1},
          {name="Default",EnableFilter=1},
          {name="Off",EnableFilter=0},
          {name="Low",EnableFilter=0},
          {name="High",EnableFilter=1},
          {name="ExtraHigh",EnableFilter=1}
        }},
      {settingName="PluginSao",
        settingTable={
          {name="G7",EnableFilter=0},
          {name="G8E",EnableFilter=0},
          {name="Default",EnableFilter=0},
          {name="Off",EnableFilter=0},
          {name="Low",EnableFilter=0},
          {name="High",EnableFilter=0},
          {name="ExtraHigh",EnableFilter=1}
        }},
      {settingName="PluginMotionBlur",
        settingTable={
          {name="G7",EnableFilter=0,BaseAmount=0},
          {name="G8E",EnableFilter=1,BaseAmount=.01},
          {name="Default",EnableFilter=1,BaseAmount=.01},
          {name="Off",EnableFilter=0,BaseAmount=0},
          {name="Low",EnableFilter=0,BaseAmount=0},
          {name="High",EnableFilter=1,BaseAmount=.01},
          {name="ExtraHigh",EnableFilter=1,BaseAmount=.01}
        }},
      {settingName="MotionBlurAmount",
        settingTable={
          {name="Off",BlurAmount=0},
          {name="Small",BlurAmount=.25},
          {name="Medium",BlurAmount=.5},
          {name="Large",BlurAmount=1}
        }},
      {settingName="PluginToneMap",
        settingTable={
          {name="G7",EnableBloom=1},
          {name="G8E",EnableBloom=1},
          {name="Default",EnableBloom=1},
          {name="Off",EnableBloom=0},
          {name="Low",EnableBloom=1},
          {name="High",EnableBloom=1},
          {name="ExtraHigh",EnableBloom=1}
        }},
      {settingName="PluginLocalReflection",
        settingTable={
          {name="G7",EnableFilter=0,FadeOffset=0},
          {name="G8E",EnableFilter=1,FadeOffset=0},
          {name="Default",EnableFilter=1,FadeOffset=0},
          {name="Off",EnableFilter=0,FadeOffset=0},
          {name="Low",EnableFilter=0,FadeOffset=0},
          {name="High",EnableFilter=1,FadeOffset=0},
          {name="ExtraHigh",EnableFilter=1,FadeOffset=.9}
        }},
      {settingName="PluginSubsurfaceScatter",
        settingTable={
          {name="G7",EnableFilter=0,FadeOffset=0},
          {name="G8E",EnableFilter=1,FadeOffset=1},
          {name="Default",EnableFilter=1,FadeOffset=1},
          {name="Off",EnableFilter=0,FadeOffset=0},
          {name="Low",EnableFilter=0,FadeOffset=0},
          {name="High",EnableFilter=1,FadeOffset=1},
          {name="ExtraHigh",EnableFilter=1,FadeOffset=1}
        }}
    }
end

return this