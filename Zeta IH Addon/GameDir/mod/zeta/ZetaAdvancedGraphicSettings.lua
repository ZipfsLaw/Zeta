local this ={
  modName = "Advanced Graphic Settings",
  modDesc = "Provides additional graphic settings that modify the 'Extra High' preset. To apply settings in-game, go to 'Graphic Settings' and select 'Ok'.",
  modCategory = "Extensions",
  modAuthor = "ZIP",
  modDisabledByDefault = true,
  isZetaModule = true,

  --ShadowsListOption
  shadowResRangeLabel = {"2px","4px","8px","16px","32px","64px","128px","256px","512px","1024px","2048px","4096px","8192px"},
  shadowResRange = {2,4,8,16,32,64,128,256,512,1024,2048,4096,8192},
  shadowCascadeRange = {2,3,4},
}

function this.ModMenu()
  local funcReload = function()ZetaCore.ReloadMods({force=true,reloadMods=false,reloadType=ZetaCore.ReloadType.Graphics})end	
  return{
    { --Graphics Menu
      options={
        {
          var="DirectionalLightShadowResolution",
          name="Dir. Light Shadow Resolution",
          desc="Change shadow resolution of directional lighting.",
          list=this.shadowResRangeLabel,
          default=12,
          func=funcReload,
        },
        {
          var="SpotLightShadowResolution",
          name="Spotlight Shadow Resolution",
          desc="Change shadow resolution of spot lighting.",
          list=this.shadowResRangeLabel,
          default=11,
          func=funcReload,
        },
        {
          var="PointLightShadowResolution",
          name="Point Light Shadow Resolution",
          desc="Change shadow resolution of point lighting.",
          list=this.shadowResRangeLabel,
          default=12,
          func=funcReload,
        },
        {
          var="ShadowCascadeRange", 
          name="Shadow Cascading Detail", 
          desc="Change the number of shadow cascades.",
          list={"2 cascades","3 cascades","4 cascades"},
          func=funcReload,
        },
        {
          var="ShadowCastingStaticLightCount", 
          name="Static Light Count", 
          desc="Change the count of static shadow casting lights.",
          default=12,
          number={min=2, max=32, inc=1},
          func=funcReload,
        },
        {
          var="ShadowCastingDynamicLightCount", 
          name="Dynamic Light Count", 
          desc="Change the count of dynamic shadow casting lights.",
          default=4,
          number={min=2, max=32, inc=1},
          func=funcReload,
        },
        {
          var="ModelDrawDistance", 
          name="Model Draw Distance", 
          desc="Change the draw distance for models.",
          default=128,
          number={min=128, max=2048, inc=32},
          func=funcReload,
        },
        {
          var="CloneDrawDistance", 
          name="Model Draw Distance", 
          desc="Clone the draw distance for clones.",
          default=250, --ZIP: Evergreen/TheSleepWalker says 2560 was the stable max distance for this
          number={min=250, max=2560, inc=32},
          func=funcReload,
        },
        {
          var="EnableFXAA", 
          name="FXAA Post Process", 
          desc="Toggle the FXAA post process effect.",
          default=1,
          func=funcReload,
        },
        {
          var="ReduceMipmaps", 
          name="Mipmap Reduction", 
          desc="Reduces quality of certain textures to reduce Vram usage.",
          func=funcReload,
        },
      }
    }
  }
end

function this.GraphicsSetting(gr)
	--Shadows
	local shadowDetailDir = ZetaVar.GetModIvar(this,"DirectionalLightShadowResolution") + 1
  local shadowDetailSpot = ZetaVar.GetModIvar(this,"SpotLightShadowResolution") + 1
  local shadowDetailPoint = ZetaVar.GetModIvar(this,"PointLightShadowResolution") + 1
  local shadowCacadeDetail = ZetaVar.GetModIvar(this, "ShadowCascadeRange") + 1
	local highDirLight = this.shadowResRange[shadowDetailDir] 
  local highSpotLight = this.shadowResRange[shadowDetailSpot] 
  local highPointLight = this.shadowResRange[shadowDetailPoint] 
	local highShadowCascade = this.shadowCascadeRange[shadowCacadeDetail]
  --Lights
  local staticLightCount = ZetaVar.GetModIvar(this, "ShadowCastingStaticLightCount") 
  local dynamicLightCount = ZetaVar.GetModIvar(this, "ShadowCastingDynamicLightCount")
	--Draw Dist 
	local modelDrawDist = ZetaVar.GetModIvar(this, "ModelDrawDistance") 
	local cloneDrawDist = ZetaVar.GetModIvar(this, "CloneDrawDistance")
	--Optimization/Effects
	local newReduceMips = ZetaVar.GetModIvar(this, "ReduceMipmaps") 
	local newFXAA = ZetaVar.GetModIvar(this, "EnableFXAA")
	
	gr.settingsTable={
      {settingName="PluginShadow",
        settingTable={
          {name="G7",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
          {name="G8E",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
          {name="Default",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
          {name="Low",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
          {name="Medium",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=1024,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
          {name="High",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},
          {name="ExtraHigh",DirectionalLightShadowResolution=highDirLight,SpotLightLightShadowResolution=highSpotLight,PointLightLightShadowResolution=highPointLight,CascadeShadowRangeScale=highShadowCascade,EnableCascadeShadowBlend=1}
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
          {name="ExtraHigh",ShadowCastingStaticLocalLightMaxCount=staticLightCount,ShadowCastingDynamicLocalLightMaxCount=dynamicLightCount,DrawLocalLightMaxCount=512,LocalLightLodLevelBias=-.5,LocalLightLodMinLevel=0,RejectionLengthBias=200}
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