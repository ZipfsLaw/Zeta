--ZetaEnemy.lua
local this={}
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local NULL_ID=GameObject.NULL_ID
local GAME_OBJECT_TYPE_SOLDIER2=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local PHASE_SNEAK=TppGameObject.PHASE_SNEAK
local PHASE_CAUTION=TppGameObject.PHASE_CAUTION
local PHASE_EVASION=TppGameObject.PHASE_EVASION
local PHASE_ALERT=TppGameObject.PHASE_ALERT
--local LIFE_STATUS=TppEnemy.LIFE_STATUS

--Control Points
function this.GetAllActiveCPs(excludeVehicles)
	local activeCPs = {}
	if mvars.ene_soldierDefine ~= nil then
		for cpName,cpTable in pairs(mvars.ene_soldierDefine)do
			if cpTable ~= nil and next(cpTable) then
				local cpId = GetGameObjectId("TppCommandPost2",cpName)
				if cpId ~= NULL_ID then
					local entry = { 
						name=cpName,
						gameObjectId=cpId,
						soldierDefine=cpTable,
						vehicle=cpTable.lrrpVehicle,
						walker=cpTable.lrrpWalker,
						travelPlan=cpTable.lrrpTravelPlan,
					}
					
					--Excludes CPs with vehicles
					if excludeVehicles == true then
						if cpTable.lrrpVehicle == nil and cpTable.lrrpWalker == nil then
							table.insert(activeCPs, entry )
						end
					else				
						table.insert(activeCPs, entry )
					end
				end
			end
		end
	end
	return activeCPs
end

--Sends commands to all CPs
function this.SendCommandToAllCPs(command, excludeVehicles)
	local allCps = ZetaEnemy.GetAllActiveCPs(excludeVehicles)
	if allCps ~= nil and next(allCps) then
		for i, cpId in pairs(allCps)do
			SendCommand( cpId.gameObjectId, command )
		end
	end
end

--CP Phases
function this.IsSneakingPhase(phase) return ( phase == PHASE_SNEAK ) end
function this.IsCautionPhase(phase) return ( phase == PHASE_CAUTION ) end
function this.IsEvasionPhase(phase) return ( phase == PHASE_EVASION ) end
function this.IsAlert(phase) return ( phase == PHASE_ALERT ) end

--Enemies
function this.GetAllActiveEnemies()
	local activeEnemies = {}
	if mvars.ene_soldierDefine ~= nil then
		for cpName,cpTable in pairs(mvars.ene_soldierDefine)do
			if cpTable ~= nil and next(cpTable) then
				for i,enemyName in ipairs(cpTable)do
					local enemyId = GetGameObjectId("TppSoldier2",enemyName)
					if enemyId ~= NULL_ID then
						local entry = { name=enemyName,cp=cpName, gameObjectId=enemyId }
						table.insert(activeEnemies, entry )
					end
				end
			end
		end
	end
	return activeEnemies
end

function this.GetEnemyName(gameObjectId)
	if this.IsGameObjectEnemy(gameObjectId) then
		local allEnemies = this.GetAllActiveEnemies()
		if allEnemies ~= nil and next(allEnemies) then
			for i, enemyId in ipairs(allEnemies)do
				if gameObjectId == enemyId.gameObjectId then
					return enemyId.name
				end
			end
		end
	end
	return ""
end

function this.GetEnemySubType(gameObjectId)
	if this.IsGameObjectEnemy(gameObjectId) then
		local soldierType=TppEnemy.GetSoldierType(gameObjectId)
		local subTypeName=TppEnemy.GetSoldierSubType(gameObjectId,soldierType)
		return subTypeName
	end
	return ""
end

function this.GetEnemyBodyId(gameObjectId)
	if this.IsGameObjectEnemy(gameObjectId) then
		local powerSettings=mvars.ene_soldierPowerSettings[gameObjectId]
		local soldierType=TppEnemy.GetSoldierType(gameObjectId)
		local subTypeName=TppEnemy.GetSoldierSubType(gameObjectId,soldierType)
		powerSettings=powerSettings or {}
		return TppEnemy.GetBodyId(gameObjectId,soldierType,subTypeName,powerSettings)
	end
	return ""
end

function this.SendCommandToAllEnemies(command)
	local allEnemies = ZetaEnemy.GetAllActiveEnemies()
	if allEnemies ~= nil and next(allEnemies) then
		for i, enemyId in pairs(allEnemies)do
			SendCommand( enemyId.gameObjectId, command )
		end
	end
end

function this.IsGameObjectEnemy(gameObjectId)
	return GetTypeIndex(gameObjectId) == GAME_OBJECT_TYPE_SOLDIER2
end

--Enemy life status
function this.GetLifeStatus(gameObjectId)
	local enemyName = this.GetEnemyName(gameObjectId)
	if enemyName ~= "" then return TppEnemy.GetLifeStatus( enemyName ) end
	return nil
end
function this.DoesLifeStatusEqual(gameObjectId, checkStatus)
	local status = this.GetLifeStatus(gameObjectId)
	if status ~= nil then return ( status == checkStatus ) end
	return false
end
function this.IsEnemyConscious(gameObjectId) return this.DoesLifeStatusEqual(gameObjectId, TppEnemy.LIFE_STATUS.NORMAL) end
function this.IsEnemyUnconscious(gameObjectId) return this.DoesLifeStatusEqual(gameObjectId, TppEnemy.LIFE_STATUS.FAINT) end
function this.IsEnemyAsleep(gameObjectId) return this.DoesLifeStatusEqual(gameObjectId, TppEnemy.LIFE_STATUS.SLEEP) end
function this.IsEnemyDead(gameObjectId) return this.DoesLifeStatusEqual(gameObjectId, TppEnemy.LIFE_STATUS.DEAD) end
function this.IsEnemyDying(gameObjectId) return this.DoesLifeStatusEqual(gameObjectId, TppEnemy.LIFE_STATUS.DYING ) end
function this.IsEnemyHeldUp(gameObjectId) return this.DoesLifeStatusEqual(gameObjectId, TppEnemy.LIFE_STATUS.HOLDUP ) end

--Enemy status
local SUPINE_HOLDUP = 3 --Tex says there's no enum for this.
function this.GetStatus(gameObjectId) return SendCommand(gameObjectId, {id="GetStatus"} ) end
function this.DoesStatusEqual(gameObjectId, checkStatus)
	local status = this.GetStatus(gameObjectId)
	if status ~= nil then return ( status == checkStatus ) end
	return false
end
function this.IsEnemyCarried(gameObjectId) return this.DoesStatusEqual(gameObjectId, EnemyState.CARRIED ) end
function this.IsEnemyNormal(gameObjectId) return this.DoesStatusEqual(gameObjectId, EnemyState.NORMAL ) end
function this.IsEnemyHeldUpStanding(gameObjectId) return this.DoesStatusEqual(gameObjectId, EnemyState.STAND_HOLDUP) end
function this.IsEnemyHeldUpSupine(gameObjectId) return this.DoesStatusEqual(gameObjectId, SUPINE_HOLDUP) end

return this