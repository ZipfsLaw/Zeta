--ZetaUnlockedCustomization.lua
local this ={
	modName = "Advanced Weapon Customization",
	modDesc = "Unlocks all possible weapon customization options without instability issues. ( NOTE: You must restart the game for effects to apply! )",
	modCategory = { "Extensions", "Weapons" },
	modAuthor = "ZIP",
	modDisabledByDefault = true,
	modLoadOrder = 2, --Set above 1 so it has higher order by default
	isZetaModule = true,
	--Weapon Parts
	weaponParts = { --All parts for each part types
		barrels = {
			pistol={
				TppEquip.BA_10001,
				TppEquip.BA_10004,
				TppEquip.BA_10024,
				TppEquip.BA_10101,
				TppEquip.BA_10102,
				TppEquip.BA_10201,
				TppEquip.BA_10302,
				TppEquip.BA_10403,
				TppEquip.BA_10405,
				TppEquip.BA_10407,
				TppEquip.BA_10414,
				TppEquip.BA_10415,
				TppEquip.BA_10417,
				TppEquip.BA_10424,
				TppEquip.BA_10425,
				TppEquip.BA_10503,
				TppEquip.BA_10504,
				TppEquip.BA_10603,
				TppEquip.BA_10703,
				TppEquip.BA_10704,
				TppEquip.BA_10705,
			},
			smg={
				TppEquip.BA_20002,
				TppEquip.BA_20103,
				TppEquip.BA_20203,
				TppEquip.BA_20215,
				TppEquip.BA_20225,
			},
			assault={
				TppEquip.BA_30001,
				TppEquip.BA_30003,
				TppEquip.BA_30023,
				TppEquip.BA_30024,
				TppEquip.BA_30035,
				TppEquip.BA_30036,
				TppEquip.BA_30043,
				TppEquip.BA_30044,
				TppEquip.BA_30102,
				TppEquip.BA_30103,
				TppEquip.BA_30107,
				TppEquip.BA_30113,
				TppEquip.BA_30115,
				TppEquip.BA_30123,
				TppEquip.BA_30124,
				TppEquip.BA_30201,
				TppEquip.BA_30203,
				TppEquip.BA_30213,
				TppEquip.BA_30214,
				TppEquip.BA_30223,
				TppEquip.BA_30224,
			},
			shotgun={},
			grenade={
				TppEquip.BA_50002,
				TppEquip.BA_50102,
				TppEquip.BA_50133,
				TppEquip.BA_50202,
				TppEquip.BA_50203,
				TppEquip.BA_50204,
				TppEquip.BA_50303,
				TppEquip.BA_50305,
			},
			sniper={
				TppEquip.BA_60203,
				TppEquip.BA_60205,
				TppEquip.BA_60303,
				TppEquip.BA_60305,
			},
			heavy={
				TppEquip.BA_70002,
				TppEquip.BA_70004,
				TppEquip.BA_70006,
				TppEquip.BA_70024,
				TppEquip.BA_70103,
				TppEquip.BA_70105,
				TppEquip.BA_70106,
				TppEquip.BA_70116,
				TppEquip.BA_70203,
				TppEquip.BA_70205,
				TppEquip.BA_70207,
			},
			launcher={},
		},
		magazines = {
			TppEquip.AM_30001,
			TppEquip.AM_30003,
			TppEquip.AM_30014,
			TppEquip.AM_30034,
			TppEquip.AM_30043,
			TppEquip.AM_30047,
			TppEquip.AM_30054,
			TppEquip.AM_30055,
			TppEquip.AM_30102,
			TppEquip.AM_30103,
			TppEquip.AM_30123,
			TppEquip.AM_30125,
			TppEquip.AM_30201,
			TppEquip.AM_30203,
			TppEquip.AM_30223,
			TppEquip.AM_30225,
			TppEquip.AM_30232,
			TppEquip.AM_30303,
			TppEquip.AM_30305,
			TppEquip.AM_30306,
			TppEquip.AM_30325,
			TppEquip.AM_70002,
			TppEquip.AM_70003,
			TppEquip.AM_70005,
			TppEquip.AM_70103,
			TppEquip.AM_70104,
			TppEquip.AM_70105,
			TppEquip.AM_70114,
			TppEquip.AM_70115,
			TppEquip.AM_70116,
			TppEquip.AM_70125,
			TppEquip.AM_70126,
			TppEquip.AM_70127,
			TppEquip.AM_70203,
			TppEquip.AM_70204,
			TppEquip.AM_70205,
			TppEquip.AM_60001,
			TppEquip.AM_60007,
			TppEquip.AM_60013,
			TppEquip.AM_60102,
			TppEquip.AM_60107,
			TppEquip.AM_60114,
			TppEquip.AM_60203,
			TppEquip.AM_60303,
			TppEquip.AM_60315,
			TppEquip.AM_60325,
			TppEquip.AM_60404,
			TppEquip.AM_60406,
			TppEquip.AM_60415,
			TppEquip.AM_60417,
			TppEquip.AM_40001,
			TppEquip.AM_40004,
			TppEquip.AM_40012,
			TppEquip.AM_40015,
			TppEquip.AM_40023,
			TppEquip.AM_40102,
			TppEquip.AM_40105,
			TppEquip.AM_40115,
			TppEquip.AM_40123,
			TppEquip.AM_40126,
			TppEquip.AM_40133,
			TppEquip.AM_40135,
			TppEquip.AM_40136,
			TppEquip.AM_40143,
			TppEquip.AM_40203,
			TppEquip.AM_40204,
			TppEquip.AM_40206,
			TppEquip.AM_40304,
			TppEquip.AM_50002,
			TppEquip.AM_50015,
			TppEquip.AM_50026,
			TppEquip.AM_50047,
			TppEquip.AM_50033,
			TppEquip.AM_50035,
			TppEquip.AM_50102,
			TppEquip.AM_50115,
			TppEquip.AM_50126,
			TppEquip.AM_50147,
			TppEquip.AM_50136,
			TppEquip.AM_50202,
			TppEquip.AM_50215,
			TppEquip.AM_50226,
			TppEquip.AM_50237,
			TppEquip.AM_50303,
			TppEquip.AM_50304,
			TppEquip.AM_50306,
			TppEquip.AM_10001,
			TppEquip.AM_10003,
			TppEquip.AM_10015,
			TppEquip.AM_10015_0,
			TppEquip.AM_1003a,
			TppEquip.AM_10101,
			TppEquip.AM_10103,
			TppEquip.AM_10125,
			TppEquip.AM_10125_0,
			TppEquip.AM_10134,
			TppEquip.AM_10134_0,
			TppEquip.AM_10201,
			TppEquip.AM_10203,
			TppEquip.AM_10214,
			TppEquip.AM_10214_0,
			TppEquip.AM_10302,
			TppEquip.AM_10303,
			TppEquip.AM_10305,
			TppEquip.AM_10403,
			TppEquip.AM_10404,
			TppEquip.AM_10405,
			TppEquip.AM_10407,
			TppEquip.AM_10503,
			TppEquip.AM_10515,
			TppEquip.AM_10526,
			TppEquip.AM_10603,
			TppEquip.AM_10615,
			TppEquip.AM_10626,
			TppEquip.AM_10637,
			TppEquip.AM_10703,
			TppEquip.AM_10704,
			TppEquip.AM_10705,
			TppEquip.AM_20002,
			TppEquip.AM_20003,
			TppEquip.AM_20005,
			TppEquip.AM_20103,
			TppEquip.AM_20104,
			TppEquip.AM_20105,
			TppEquip.AM_20106,
			TppEquip.AM_20116,
			TppEquip.AM_20116_0,
			TppEquip.AM_20116_1,
			TppEquip.AM_20203,
			TppEquip.AM_20206,
			TppEquip.AM_20302,
			TppEquip.AM_20303,
			TppEquip.AM_20304,
			TppEquip.AM_20305,
			TppEquip.AM_80002,
			TppEquip.AM_80004,
			TppEquip.AM_80006,
			TppEquip.AM_80103,
			TppEquip.AM_80104,
			TppEquip.AM_80105,
			TppEquip.AM_80116,
			TppEquip.AM_80119,
			TppEquip.AM_8011a,
			TppEquip.AM_8011b,
			TppEquip.AM_80124,
			TppEquip.AM_80125,
			TppEquip.AM_80126,
			TppEquip.AM_80135,
			TppEquip.AM_80136,
			TppEquip.AM_80138,
			TppEquip.AM_8013a,
			TppEquip.AM_8013b,
			TppEquip.AM_80203,
			TppEquip.AM_80204,
			TppEquip.AM_80205,
			TppEquip.AM_80206,
			TppEquip.AM_80303,
			TppEquip.AM_80304,
			TppEquip.AM_80305,
			TppEquip.AM_80306,
		},
		stocks = {
			TppEquip.SK_20002,
			TppEquip.SK_20015,
			TppEquip.SK_20103,
			TppEquip.SK_20106,
			TppEquip.SK_20203,
			TppEquip.SK_20216,
			TppEquip.SK_30001,
			TppEquip.SK_30002,
			TppEquip.SK_30024,
			TppEquip.SK_30043,
			TppEquip.SK_30045,
			TppEquip.SK_30102,
			TppEquip.SK_30113,
			TppEquip.SK_30123,
			TppEquip.SK_30201,
			TppEquip.SK_30205,
			TppEquip.SK_30213,
			TppEquip.SK_30223,
			TppEquip.SK_40001,
			TppEquip.SK_40043,
			TppEquip.SK_40102,
			TppEquip.SK_40144,
			TppEquip.SK_40203,
			TppEquip.SK_40306,
			TppEquip.SK_50002,
			TppEquip.SK_50004,
			TppEquip.SK_50102,
			TppEquip.SK_50202,
			TppEquip.SK_50303,
			TppEquip.SK_60001,
			TppEquip.SK_60002,
			TppEquip.SK_60102,
			TppEquip.SK_60103,
			TppEquip.SK_60203,
			TppEquip.SK_60205,
			TppEquip.SK_60303,
			TppEquip.SK_60304,
			TppEquip.SK_60405,
			TppEquip.SK_70103,
			TppEquip.SK_70203,
		},
		muzzles = {
			TppEquip.MZ_30001,
			TppEquip.MZ_30023,
			TppEquip.MZ_30102,
			TppEquip.MZ_30105,
			TppEquip.MZ_30123,
			TppEquip.MZ_30201,
			TppEquip.MZ_30213,
			TppEquip.MZ_30223,
			TppEquip.MZ_30232,
			TppEquip.MZ_30303,
			TppEquip.MZ_40102,
			TppEquip.MZ_40203,
			TppEquip.MZ_40206,
			TppEquip.MZ_40304,
			TppEquip.MZ_60001,
			TppEquip.MZ_60102,
			TppEquip.MZ_60105,
			TppEquip.MZ_60203,
			TppEquip.MZ_60303,
			TppEquip.MZ_60305,
			TppEquip.MZ_60404,
			TppEquip.MZ_60405,
			TppEquip.MZ_60416,
			TppEquip.MZ_70002,
			TppEquip.MZ_70103,
			TppEquip.MZ_70106,
			TppEquip.MZ_70203,
			TppEquip.MZ_70207,
		},
		muzzleOptions = {
			TppEquip.MO_10101,
			TppEquip.MO_10105,
			TppEquip.MO_10002,
			TppEquip.MO_10004,
			TppEquip.MO_10026,
			TppEquip.MO_10202,
			TppEquip.MO_10205,
			TppEquip.MO_10306,
			TppEquip.MO_10407,
			TppEquip.MO_10425,
			TppEquip.MO_20002,
			TppEquip.MO_20005,
			TppEquip.MO_20006,
			TppEquip.MO_20204,
			TppEquip.MO_20205,
			TppEquip.MO_20206,
			TppEquip.MO_20302,
			TppEquip.MO_20307,
			TppEquip.MO_30002,
			TppEquip.MO_30005,
			TppEquip.MO_30046,
			TppEquip.MO_30025,
			TppEquip.MO_30102,
			TppEquip.MO_30105,
			TppEquip.MO_30115,
			TppEquip.MO_30117,
			TppEquip.MO_30205,
			TppEquip.MO_30235,
			TppEquip.MO_30237,
			TppEquip.MO_40104,
			TppEquip.MO_40106,
			TppEquip.MO_40306,
			TppEquip.MO_60103,
			TppEquip.MO_60106,
			TppEquip.MO_60204,
			TppEquip.MO_60206,
			TppEquip.MO_60406,
			TppEquip.MO_6040a,
			TppEquip.MO_70025,
		},
		sights = {
			TppEquip.ST_20104,
			TppEquip.ST_20205,
			TppEquip.ST_30114,
			TppEquip.ST_30202,
			TppEquip.ST_30204,
			TppEquip.ST_30303,
			TppEquip.ST_30305,
			TppEquip.ST_30306,
			TppEquip.ST_50003,
			TppEquip.ST_50133,
			TppEquip.ST_50136,
			TppEquip.ST_50303,
			TppEquip.ST_60001,
			TppEquip.ST_60004,
			TppEquip.ST_60102,
			TppEquip.ST_60105,
			TppEquip.ST_60203,
			TppEquip.ST_60303,
			TppEquip.ST_60304,
			TppEquip.ST_60407,
			TppEquip.ST_80002,
			TppEquip.ST_80103,
			TppEquip.ST_80203,
			TppEquip.ST_80303,
		},
		optionLts = {
			TppEquip.LT_10102,
			TppEquip.LT_10104,
			TppEquip.LT_30025,
			TppEquip.LT_30105,
			TppEquip.LT_40103,
		},
		optionLs = {
			TppEquip.LS_10415,
			TppEquip.LS_20004,
			TppEquip.LS_30104,
			TppEquip.LS_40034,
		},
		underBarrels = {
			TppEquip.UB_20105,
			TppEquip.UB_30005,
			TppEquip.UB_30105,
			TppEquip.UB_30304,
			TppEquip.UB_10006,
			TppEquip.UB_10107,
			TppEquip.UB_10207,
			TppEquip.UB_40043,
			TppEquip.UB_40045,
			TppEquip.UB_40144,
			TppEquip.UB_50002,
			TppEquip.UB_50015,
			TppEquip.UB_50026,
			TppEquip.UB_50047,
			TppEquip.UB_50033,
			TppEquip.UB_50035,
			TppEquip.UB_50102,
			TppEquip.UB_50115,
			TppEquip.UB_50126,
			TppEquip.UB_50147,
			TppEquip.UB_50133,
			TppEquip.UB_50136,
		},
		receivers ={ --All receiver IDs
			pistol={
				TppEquip.RC_10001,
				TppEquip.RC_10003,
				TppEquip.RC_10004,
				TppEquip.RC_10006,
				TppEquip.RC_10015,
				TppEquip.RC_10024,
				TppEquip.RC_10035,
				TppEquip.RC_1003a,
				TppEquip.RC_10101,
				TppEquip.RC_10102,
				TppEquip.RC_10105,
				TppEquip.RC_10107,
				TppEquip.RC_10117,
				TppEquip.RC_10125,
				TppEquip.RC_10134,
				TppEquip.RC_10136,
				TppEquip.RC_10201,
				TppEquip.RC_10203,
				TppEquip.RC_10205,
				TppEquip.RC_10214,
				TppEquip.RC_10216,
				TppEquip.RC_10302,
				TppEquip.RC_10303,
				TppEquip.RC_10304,
				TppEquip.RC_10306,
				TppEquip.RC_10307,
				TppEquip.RC_10403,
				TppEquip.RC_10405,
				TppEquip.RC_10407,
				TppEquip.RC_10503,
				TppEquip.RC_10504,
				TppEquip.RC_10515,
				TppEquip.RC_10526,
				TppEquip.RC_10603,
				TppEquip.RC_10604,
				TppEquip.RC_10615,
				TppEquip.RC_10626,
				TppEquip.RC_10637,
				TppEquip.RC_10703,
				TppEquip.RC_10704,
				TppEquip.RC_10705,
			},
			smg={
				TppEquip.RC_20002,
				TppEquip.RC_20004,
				TppEquip.RC_20006,
				TppEquip.RC_20015,
				TppEquip.RC_20103,
				TppEquip.RC_20104,
				TppEquip.RC_20105,
				TppEquip.RC_20116,
				TppEquip.RC_20119,
				TppEquip.RC_20203,
				TppEquip.RC_20204,
				TppEquip.RC_20205,
				TppEquip.RC_20215,
				TppEquip.RC_20225,
				TppEquip.RC_20302,
				TppEquip.RC_20303,
				TppEquip.RC_20304,
				TppEquip.RC_20307,
				TppEquip.RC_20309,
			},
			assault={
				TppEquip.RC_30001,
				TppEquip.RC_30003,
				TppEquip.RC_30005,
				TppEquip.RC_30014,
				TppEquip.RC_30016,
				TppEquip.RC_30034,
				TppEquip.RC_30101,
				TppEquip.RC_30102,
				TppEquip.RC_30104,
				TppEquip.RC_30117,
				TppEquip.RC_30119,
				TppEquip.RC_30201,
				TppEquip.RC_30202,
				TppEquip.RC_30232,
				TppEquip.RC_30233,
				TppEquip.RC_30235,
				TppEquip.RC_30237,
				TppEquip.RC_30239,
				TppEquip.RC_30303,
				TppEquip.RC_30305,
				TppEquip.RC_30306,
				TppEquip.RC_30325,
				TppEquip.RC_30327,
			},
			shotgun={
				TppEquip.RC_40001,
				TppEquip.RC_40002,
				TppEquip.RC_40003,
				TppEquip.RC_40004,
				TppEquip.RC_40012,
				TppEquip.RC_40013,
				TppEquip.RC_40014,
				TppEquip.RC_40015,
				TppEquip.RC_40023,
				TppEquip.RC_40024,
				TppEquip.RC_40025,
				TppEquip.RC_40032,
				TppEquip.RC_40033,
				TppEquip.RC_40034,
				TppEquip.RC_40035,
				TppEquip.RC_40042,
				TppEquip.RC_40044,
				TppEquip.RC_40045,
				TppEquip.RC_40102,
				TppEquip.RC_40103,
				TppEquip.RC_40105,
				TppEquip.RC_40115,
				TppEquip.RC_40123,
				TppEquip.RC_40126,
				TppEquip.RC_40136,
				TppEquip.RC_40203,
				TppEquip.RC_40204,
				TppEquip.RC_40207,
				TppEquip.RC_40304,
				TppEquip.RC_40305,
				TppEquip.RC_40306,
				TppEquip.RC_40307,
			},
			grenade={
				TppEquip.RC_50002,
				TppEquip.RC_50003,
				TppEquip.RC_50004,
				TppEquip.RC_50005,
				TppEquip.RC_50015,
				TppEquip.RC_50026,
				TppEquip.RC_50033,
				TppEquip.RC_50034,
				TppEquip.RC_50035,
				TppEquip.RC_50036,
				TppEquip.RC_50047,
				TppEquip.RC_50102,
				TppEquip.RC_50103,
				TppEquip.RC_50104,
				TppEquip.RC_50105,
				TppEquip.RC_50115,
				TppEquip.RC_50126,
				TppEquip.RC_50133,
				TppEquip.RC_50134,
				TppEquip.RC_50135,
				TppEquip.RC_50136,
				TppEquip.RC_50147,
				TppEquip.RC_50202,
				TppEquip.RC_50203,
				TppEquip.RC_50204,
				TppEquip.RC_50215,
				TppEquip.RC_50226,
				TppEquip.RC_50237,
				TppEquip.RC_50303,
				TppEquip.RC_50305,
			},
			sniper={
				TppEquip.RC_60001,
				TppEquip.RC_60002,
				TppEquip.RC_60007,
				TppEquip.RC_60005,
				TppEquip.RC_60012,
				TppEquip.RC_60013,
				TppEquip.RC_60016,
				TppEquip.RC_60102,
				TppEquip.RC_60103,
				TppEquip.RC_60106,
				TppEquip.RC_60107,
				TppEquip.RC_60114,
				TppEquip.RC_60117,
				TppEquip.RC_60203,
				TppEquip.RC_60206,
				TppEquip.RC_60303,
				TppEquip.RC_60306,
				TppEquip.RC_60309,
				TppEquip.RC_60315,
				TppEquip.RC_60317,
				TppEquip.RC_60325,
				TppEquip.RC_60327,
				TppEquip.RC_60329,
				TppEquip.RC_60404,
				TppEquip.RC_60405,
				TppEquip.RC_60415,
				TppEquip.RC_60416,
			},
			heavy={
				TppEquip.RC_70002,
				TppEquip.RC_70003,
				TppEquip.RC_70009,
				TppEquip.RC_70015,
				TppEquip.RC_70103,
				TppEquip.RC_70104,
				TppEquip.RC_70114,
				TppEquip.RC_70115,
				TppEquip.RC_70125,
				TppEquip.RC_70203,
				TppEquip.RC_70204,
			},
			launcher={
				TppEquip.RC_80006,
				TppEquip.RC_80105,
				TppEquip.RC_80116,
				TppEquip.RC_80119,
				TppEquip.RC_80126,
				TppEquip.RC_80135,
			}
		},
		partBlacklist = { --Corrections based on preference.
			assault={ --G44 parts don't fit on most guns.
				TppEquip.BA_30303,
				TppEquip.BA_30304,
				TppEquip.BA_30314,
				TppEquip.BA_30315,
				TppEquip.BA_30325,
				TppEquip.BA_30326,
				TppEquip.BA_30334,
				TppEquip.BA_30335,
			},
			sniper={ --Most rifle barrels look odd.
				TppEquip.BA_60001,
				TppEquip.BA_60004,
				TppEquip.BA_60005,
				TppEquip.BA_60102,
				TppEquip.BA_60105,
				TppEquip.BA_60107,
				TppEquip.BA_60404,
				TppEquip.BA_60405,
				TppEquip.BA_60407,
				TppEquip.BA_60415,
				TppEquip.BA_60416,
				TppEquip.BA_60417,
			},
			shotgun={ --Most shotgun barrels don't render/fit.
				TppEquip.BA_40001,
				TppEquip.BA_40032,
				TppEquip.BA_40034,
				TppEquip.BA_40042,
				TppEquip.BA_40043,
				TppEquip.BA_40102,
				TppEquip.BA_40103,
				TppEquip.BA_40133,
				TppEquip.BA_40134,
				TppEquip.BA_40135,
				TppEquip.BA_40143,
				TppEquip.BA_40203,
				TppEquip.BA_40205,
				TppEquip.BA_40304,
			}
		},
	},
	indexToKey = {
		"barrels",
		"magazines",
		"stocks",
		"muzzles",
		"muzzleOptions",
		"sights",
		"sights",
		"optionLts",
		"optionLs",
		"underBarrels",
	},
	limitedList={
		"assault",
		"heavy",
		"sniper",
		"shotgun",
	},
}
function this.IsLimited(slotType)
	for i, slotName in ipairs(this.limitedList) do 
		if slotName == slotType then return true end
	end
	return false
end
function this.WeaponPartsCombinationSettings(gamemodule)
	if gamemodule == nil then return nil end
	gamemodule.partCombinationTable={} --Clear all original partsIdTable
	local newWeaponPartsCombinationSettings={}
	local partSize = 16 --These functions process 17 or so parts.
	local comboSize = 40 --Max parts these functions take.
	--Receivers
	for slotType, receivers in pairs(this.weaponParts.receivers) do
		local isCurLimited = this.IsLimited(slotType)
		for x=1,#receivers,partSize+1 do 
			local subListIDs = { unpack( receivers, x, x+partSize ) }
			for y, partName in ipairs(this.indexToKey) do 
				local comboTable = this.weaponParts[partName]
				if y == 1 and isCurLimited == true then
					local newBarrels = {}
					for i, barrelID in ipairs(comboTable[slotType]) do table.insert(newBarrels,barrelID) end
					for z, slotName in ipairs(this.limitedList) do 
						if slotType ~= slotName then 					
							for i, barrelID in ipairs(comboTable[slotName] ) do table.insert(newBarrels,barrelID) end
						else
							local newSlotName = slotName
							if slotName == "shotgun" then newSlotName = "assault" end --Adds G44 barrels to shotguns ( for KAB83 )
							local blackList = this.weaponParts.partBlacklist[newSlotName]
							if blackList ~= nil and next(blackList) then
								for i, barrelID in ipairs(blackList) do table.insert(newBarrels,barrelID) end 
							end
						end
					end
					table.insert( newWeaponPartsCombinationSettings, { func=1, id=subListIDs, partsType=y, partsId=newBarrels } )
				else	
					if y == 1 then 
						local newBarrels = {}
						for slotType, barrelIDs in pairs(comboTable) do 
							for i, barrelID in ipairs(barrelIDs) do table.insert(newBarrels,barrelID) end
						end
						for slotType, barrelIDs in pairs(this.weaponParts.partBlacklist) do 
							for i, barrelID in ipairs(barrelIDs) do table.insert(newBarrels,barrelID) end
						end
						comboTable = newBarrels
					end
					for z=1,#comboTable,comboSize+1 do 
						local subListCombos = { unpack( comboTable, z, z+comboSize ) }
						local newReceiver = { func=1, id=subListIDs, partsType=y, partsId=subListCombos }
						if y > 5 then newReceiver.func = 2 end
						table.insert( newWeaponPartsCombinationSettings, newReceiver )
					end
				end
			end
			table.insert( newWeaponPartsCombinationSettings, { func=4, id=subListIDs, partsType=2, partsId=this.weaponParts.magazines} ) --Receiver with Underbarrel
		end
	end
	--Barrels
	for x=1,#this.weaponParts.barrels,partSize+1 do 
		local subListBarrels = { unpack( this.weaponParts.barrels, x, x+partSize ) }
		for y=4,10,1 do 
			local comboTable = this.weaponParts[this.indexToKey[y]]
			for z=1,#comboTable,comboSize+1 do 
				local subListCombos = { unpack( comboTable, z, z+comboSize ) }
				table.insert( newWeaponPartsCombinationSettings, { func=3, id=subListBarrels, partsType=y, partsId=subListCombos } ) --Barrel Base
			end
		end 
	end
	--Compile entries into list.
	for i,newComboSetting in ipairs(newWeaponPartsCombinationSettings)do
		local newEntry = { func=newComboSetting.func, receiverID=newComboSetting.id,partsType=newComboSetting.partsType,partsIds=newComboSetting.partsId}	
		if newEntry.func == 3 then newEntry = { func=3, barrelID=newComboSetting.id,partsType=newComboSetting.partsType,partsIds=newComboSetting.partsId} end
		table.insert( gamemodule.partCombinationTable, newEntry )
	end
	return {}
end

return this