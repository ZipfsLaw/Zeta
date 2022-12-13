--ZetaCommonMotionPackage.lua
local this={}
function this.GetCommonMotionPackagePathTable()
	local ret = {
		{"DefaultCommonMotion","/Assets/tpp/pack/player/motion/player2_resident_motion.fpk","/Assets/tpp/motion/motion_graph/player2/TppPlayer2_layers.mog"}
	}
	return ret
end
function this.GetCommonMtarPathTable()
	local ret = {
		{"/Assets/tpp/motion/mtar/player2/player2_resident.mtar","/Assets/tpp/motion/mtar/player2/TppPlayer2Facial.mtar"}
	}
	return ret
end
function this.Reload()
	this.commonMotionPackagePaths = {}
	this.commonMtarPaths = {}
	this.commonMotionPackagePaths = this.GetCommonMotionPackagePathTable()
	this.commonMtarPaths = this.GetCommonMtarPathTable()
	--Load mods
	ZetaIndex.ModFunction("CommonMotionPackagePath", this ) 
	--Register common motion packages
	if this.commonMotionPackagePaths ~= nil and next(this.commonMotionPackagePaths) then
		for i,packagePath in ipairs(this.commonMotionPackagePaths)do
			if packagePath ~= nil and next(packagePath) then
				Player.RegisterCommonMotionPackagePath(packagePath[1],packagePath[2],packagePath[3])
			end
		end
	end
	--Register Mtars
	if this.commonMtarPaths ~= nil and next(this.commonMtarPaths) then
		for i,mtarPath in ipairs(this.commonMtarPaths)do
			if mtarPath ~= nil and next(mtarPath) then
				Player.RegisterCommonMtarPath(mtarPath[1],mtarPath[2])
			end
		end
	end
end
return this