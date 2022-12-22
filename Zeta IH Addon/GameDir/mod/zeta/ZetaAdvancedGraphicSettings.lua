local this ={
  modName = "Advanced Graphic Settings",
  modDesc = "Provides additional graphic settings that modify the 'Extra High' preset. To apply settings in-game, go to 'Graphic Settings' and select 'Ok'.",
  modCategory = "Extensions",
  modAuthor = "ZIP",
  modDisabledByDefault = true,
  isZetaModule = true,

  --ShadowsListOption
  shadowResRangeLabel = {"2px","4px","8px","16px","32px","64px","128px","256px","512px","1024px","2048px","4096px","8192px","16384px"},
  shadowResRange = {2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384},
  shadowCascadeRange = {2,3},
}

function this.ModMenu()
  local funcReload = function()ZetaCore.ReloadMods({force=true,reloadMods=false,reloadType=ZetaCore.ReloadType.Graphics})end	
  return{
    { --Graphics Menu
      options={
        {
          name="Shadows/Lighting",
          desc="Change shadow resolution, number of shadow-casting lights",
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
              list={"2 cascades","3 cascades"},
              default=1,
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
          }
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
          name="Clone Draw Distance", 
          desc="Change the draw distance for clones.",
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

function this.GraphicsSetting()
  local shouldBlend = 0 --Less cascades means no blending.
  local shadowCascadeRange = this.ZVar("ShadowCascadeRange") + 1
  if shadowCascadeRange == 2 then shouldBlend = 1 end
  return {
    PluginShadow={
      {
        name="ExtraHigh",
        DirectionalLightShadowResolution=this.shadowResRange[this.ZVar("DirectionalLightShadowResolution") + 1],
        SpotLightLightShadowResolution=this.shadowResRange[this.ZVar("SpotLightShadowResolution") + 1],
        PointLightLightShadowResolution=this.shadowResRange[this.ZVar("PointLightShadowResolution") + 1],
        CascadeShadowRangeScale=this.shadowCascadeRange[shadowCascadeRange],
        EnableCascadeShadowBlend=shouldBlend
      }
    },
    PluginLocalLight={
      {
        name="ExtraHigh",
        ShadowCastingStaticLocalLightMaxCount=this.ZVar("ShadowCastingStaticLightCount") ,
        ShadowCastingDynamicLocalLightMaxCount=this.ZVar("ShadowCastingDynamicLightCount"),
        DrawLocalLightMaxCount=512,LocalLightLodLevelBias=-.5,LocalLightLodMinLevel=0,RejectionLengthBias=200
      }
    },
    PluginModel={{name="ExtraHigh",RejectionLengthBias=this.ZVar("ModelDrawDistance")}},
    PluginClone={{name="ExtraHigh",RejectionLengthBias=this.ZVar("CloneDrawDistance")}},
    TextureQualitySettings={{name="ExtraHigh",VramMBSize=3200,ReduceMipmap=this.ZVar("ReduceMipmaps")}},
    PluginFxaa={{name="ExtraHigh",EnableFilter=this.ZVar("EnableFXAA")}},
  }
end

return this