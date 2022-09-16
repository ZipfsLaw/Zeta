--ZetaDebug.Lua
local this={
	modName = "Zeta Debug",
	modDesc = "Retrieves paramters",
	modCategory = "Debug",
	modAuthor = "(ZIP)",

    --Labels
    receiverSetBaseLabels = {
        "Fire rate",
        "Aim-Assist Distance",
        "Draw Speed",
        "Unknown4",
        "Unknown5",
        "Ironsight 1",
        "Ironsight 2",
        "Reload Speed",
    },
    receiverWobblingLabels = {
       "Unknown1",
       "Unknown2",
       "Unknown3",
       "Unknown4",
       "Unknown5",
       "Unknown6",
       "Unknown7",
    },
    receiverSystemLabels = {
        "Equip Type",
        "Reticle Type",
        "Fire Mode",
        "Unknown4",
        "Unknown5",
        "Unknown6",
        "Unknown7",
        "Unknown8",
        "Unknown9",
        "Unknown10",
        "Unknown11",
        "Unknown12",
    },
    damageLabels = {
        "Attack ID",
        "Lethal Damage (UI)",
        "Unknown3",
        "Unknown4",
        "Unknown5",
        "Unknown6",
        "Unknown7",
        "Unknown8",
        "Injury Type",
        "Injury Part",
        "Unknown11",
        "Unknown12",
        "Physically Simulated",
        "Unknown14",
        "Knockback",
        "Tranquilizer",
        "Stuns",
        "Unknown18",
        "Unknown19",
        "Unknown20",
        "Fire",
        "Unknown22",
        "Gas",
        "Unknown24",
        "Unknown25",
        "Electric",
        "Unknown27",
        "Unknown28",
        "Damage Source",
        "Lethal Damage Value",
        "Non-lethal Damage Value",
        "Impact Force",
    },
    atkIDs = {
        ATK_10001 = 319,
        ATK_10004 = 320,
        ATK_10006 = 321,
        ATK_10015 = 322,
        ATK_10024 = 323,
        ATK_10035 = 324,
        ATK_1003a = 466,
        ATK_10101 = 325,
        ATK_10102 = 326,
        ATK_10105 = 327,
        ATK_10107 = 328,
        ATK_10117 = 329,
        ATK_10125 = 330,
        ATK_10134 = 331,
        ATK_10136 = 332,
        ATK_10201 = 333,
        ATK_10205 = 334,
        ATK_10214 = 335,
        ATK_10216 = 336,
        ATK_10302 = 337,
        ATK_10304 = 338,
        ATK_10306 = 339,
        ATK_10307 = 340,
        ATK_10403 = 341,
        ATK_10405 = 342,
        ATK_10407 = 343,
        ATK_10503 = 344,
        ATK_10515 = 345,
        ATK_10526 = 346,
        ATK_10603 = 347,
        ATK_10615 = 348,
        ATK_10626 = 349,
        ATK_10626_Grazed = 350,
        ATK_10637 = 351,
        ATK_10702 = 352,
        ATK_10704 = 353,
        ATK_10706 = 354,
        ATK_20002 = 355,
        ATK_20006 = 356,
        ATK_20015 = 357,
        ATK_20103 = 358,
        ATK_20116 = 359,
        ATK_20119 = 467,
        ATK_20203 = 360,
        ATK_20215 = 361,
        ATK_20225 = 362,
        ATK_20302 = 363,
        ATK_20307 = 454,
        ATK_20309 = 468,
        ATK_30001 = 364,
        ATK_30014 = 365,
        ATK_30102 = 366,
        ATK_30117 = 455,
        ATK_30119 = 469,
        ATK_30201 = 367,
        ATK_30232 = 368,
        ATK_30237 = 456,
        ATK_30239 = 470,
        ATK_30303 = 369,
        ATK_30325 = 370,
        ATK_40001 = 371,
        ATK_40004 = 372,
        ATK_40012 = 373,
        ATK_40015 = 374,
        ATK_40023 = 375,
        ATK_40032 = 376,
        ATK_40035 = 377,
        ATK_40042 = 378,
        ATK_40045 = 379,
        ATK_40102 = 380,
        ATK_40105 = 381,
        ATK_40115 = 382,
        ATK_40123 = 445,
        ATK_40126 = 383,
        ATK_40203 = 384,
        ATK_40207 = 385,
        ATK_40304 = 386,
        ATK_40306 = 387,
        ATK_50002 = 388,
        ATK_50015 = 389,
        ATK_50026 = 390,
        ATK_50026_Grazed = 391,
        ATK_50033 = 393,
        ATK_50035 = 394,
        ATK_50047 = 392,
        ATK_50102 = 395,
        ATK_50115 = 396,
        ATK_50126 = 397,
        ATK_50126_Grazed = 398,
        ATK_50133 = 400,
        ATK_50136 = 401,
        ATK_50147 = 399,
        ATK_50202 = 402,
        ATK_50215 = 403,
        ATK_50226 = 404,
        ATK_50226_Grazed = 405,
        ATK_50237 = 406,
        ATK_50303 = 407,
        ATK_60001 = 408,
        ATK_60002 = 409,
        ATK_60007 = 410,
        ATK_60013 = 411,
        ATK_60102 = 412,
        ATK_60103 = 413,
        ATK_60107 = 414,
        ATK_60114 = 415,
        ATK_60203 = 416,
        ATK_60303 = 417,
        ATK_60309 = 471,
        ATK_60315 = 418,
        ATK_60325 = 419,
        ATK_60329 = 472,
        ATK_60404 = 420,
        ATK_60405 = 421,
        ATK_60415 = 422,
        ATK_60416 = 423,
        ATK_70002 = 424,
        ATK_70009 = 473,
        ATK_70015 = 425,
        ATK_70103 = 426,
        ATK_70114 = 427,
        ATK_70125 = 474,
        ATK_70203 = 428,
        ATK_80002 = 429,
        ATK_80004 = 430,
        ATK_80006 = 431,
        ATK_80103 = 432,
        ATK_80104 = 433,
        ATK_80116 = 434,
        ATK_80119 = 475,
        ATK_80124 = 435,
        ATK_80125 = 436,
        ATK_80135 = 476,
        ATK_80203 = 437,
        ATK_80204 = 438,
        ATK_80205 = 439,
        ATK_80206 = 440,
        ATK_80209 = 477,
        ATK_80303 = 441,
        ATK_80304 = 442,
        ATK_80305 = 443,
        ATK_80306 = 444,
        ATK_ActiveDecoy = 29,
        ATK_AnimalBodyAttack = 136,
        ATK_AntitankMine = 205,
        ATK_AntitankMine_G1 = 206,
        ATK_AntitankMine_G2 = 207,
        ATK_BattleGear_BodyAttack = 161,
        ATK_BattleGear_RailGun = 162,
        ATK_BearAttack = 138,
        ATK_BearRush = 139,
        ATK_BearStandAttack = 137,
        ATK_BlastWind = 288,
        ATK_Blow = 50,
        ATK_BombAssist = 212,
        ATK_BombAssistToSahelan = 213,
        ATK_BossQuiet_sr_010 = 293,
        ATK_BrokenBridge = 126,
        ATK_BrokenPillar = 15,
        ATK_C4 = 197,
        ATK_C4_G1 = 198,
        ATK_C4_G2 = 199,
        ATK_CBoxBodyAttack = 85,
        ATK_CBoxHeadAttack = 84,
        ATK_CannonShell = 11,
        ATK_CaptureCage = 33,
        ATK_CarryThrow = 56,
        ATK_CarryThrowBound = 3,
        ATK_ChaffAssist = 25,
        ATK_Claymore = 202,
        ATK_Claymore_G1 = 203,
        ATK_Claymore_G2 = 204,
        ATK_CqcChoke = 91,
        ATK_CqcContinuous2nd = 95,
        ATK_CqcContinuousOver3Times = 96,
        ATK_CqcDashBlastPunch = 99,
        ATK_CqcDashPunch = 98,
        ATK_CqcFinish = 89,
        ATK_CqcHang = 90,
        ATK_CqcHit = 8,
        ATK_CqcHitFinish = 88,
        ATK_CqcHoldThrow = 93,
        ATK_CqcKill = 97,
        ATK_CqcThrow = 92,
        ATK_CqcThrowBehind = 9,
        ATK_CqcThrowLadder = 10,
        ATK_CqcThrowWall = 94,
        ATK_CrawlSweep = 63,
        ATK_DDogBite = 144,
        ATK_DDogBodyAttack = 147,
        ATK_DDogKnife = 145,
        ATK_DDogStunKnife = 146,
        ATK_DMine = 202,
        ATK_DMine_G1 = 203,
        ATK_DMine_G2 = 204,
        ATK_DMine_G3 = 451,
        ATK_Death = 79,
        ATK_Decoy = 28,
        ATK_DecoyHit = 175,
        ATK_DecoyRaise = 200,
        ATK_DecoyShock = 176,
        ATK_Door = 120,
        ATK_DownKick = 83,
        ATK_Dung = 110,
        ATK_Dying = 77,
        ATK_EX_gl_000 = 447,
        ATK_EX_hg_000 = 446,
        ATK_EX_hg_010 = 478,
        ATK_EX_sr_000 = 448,
        ATK_ElectricWire = 129,
        ATK_ElectromagneticNetMine = 211,
        ATK_Event = 104,
        ATK_FOB_60325 = 449,
        ATK_Faint = 75,
        ATK_FaintRecover = 101,
        ATK_Fall = 103,
        ATK_FallBoundDeath = 59,
        ATK_FallBoundFaint = 58,
        ATK_FallDeath = 78,
        ATK_FireBurn = 121,
        ATK_FlashLight = 61,
        ATK_FlashLightAttack = 62,
        ATK_FlyingDisc = 34,
        ATK_FultonDevice = 201,
        ATK_GabageBoxOpen = 134,
        ATK_GimmickBlast = 123,
        ATK_GimmickBlastHigh = 124,
        ATK_Grenade = 178,
        ATK_GrenadeHit = 174,
        ATK_Grenade_G1 = 179,
        ATK_Grenade_G2 = 180,
        ATK_Grenade_G5 = 450,
        ATK_Grenade_G6 = 457,
        ATK_Grenade_G7 = 458,
        ATK_Grenade_G8 = 459,
        ATK_Grenader_Sleep = 318,
        ATK_Grenader_Smoke = 315,
        ATK_Grenader_Stun = 316,
        ATK_Grenader_Stun_Grazed = 317,
        ATK_GuardTower = 125,
        ATK_GunCameraAttack = 133,
        ATK_HeavyPhysics = 122,
        ATK_HeliBlast = 275,
        ATK_HeliChainGun = 274,
        ATK_HeliMiniGun = 269,
        ATK_HitEvadeAction = 55,
        ATK_HoneyBee = 310,
        ATK_HorseBodyAttack = 105,
        ATK_HorseBodyAttackDeath = 109,
        ATK_HorseBodyAttackMil1 = 106,
        ATK_HorseBodyAttackMil2 = 107,
        ATK_HorseBodyAttackMil3 = 108,
        ATK_InWater = 74,
        ATK_Jehuty = 166,
        ATK_Kibidango = 35,
        ATK_KibidangoHit = 177,
        ATK_Kick = 7,
        ATK_KillRocket = 170,
        ATK_KillRocket_G1 = 171,
        ATK_KillRocket_G2 = 172,
        ATK_Knife = 4,
        ATK_KnifeSlash = 53,
        ATK_KnifeSlashStun = 54,
        ATK_LargeFlame = 72,
        ATK_LifeRecover = 100,
        ATK_LightVehicleDrop = 119,
        ATK_LightVehicleHit = 113,
        ATK_LiquidWeaponThrow = 47,
        ATK_LiquidWeaponThrow_Machete = 258,
        ATK_LiquidWeaponThrow_Pipe = 259,
        ATK_Liquid_BottleThrow = 252,
        ATK_Liquid_Combo1 = 253,
        ATK_Liquid_Combo2 = 254,
        ATK_Liquid_Jump = 46,
        ATK_Liquid_Jump_Machete = 255,
        ATK_Liquid_Jump_Pipe = 256,
        ATK_Liquid_Kick = 260,
        ATK_Liquid_Thrust = 257,
        ATK_Machete = 5,
        ATK_MacheteDown = 6,
        ATK_Magazine = 173,
        ATK_MiddleFlame = 71,
        ATK_MolotovCocktail = 192,
        ATK_MolotovCocktailFire = 191,
        ATK_MolotovCocktailFire_G1 = 193,
        ATK_MolotovCocktailFire_G2 = 195,
        ATK_MolotovCocktail_G1 = 194,
        ATK_MolotovCocktail_G2 = 196,
        ATK_Mortar = 282,
        ATK_MortarSleep = 283,
        ATK_MsfPunch = 135,
        ATK_Nad = 264,
        ATK_Nad0 = 263,
        ATK_NadStun = 265,
        ATK_None = 0,
        ATK_NormalFlame = 69,
        ATK_ParasiteBeam = 37,
        ATK_ParasiteBlastWall = 223,
        ATK_ParasiteBreakWall = 215,
        ATK_ParasiteCamoufMachete = 219,
        ATK_ParasiteCorrode = 44,
        ATK_ParasiteCorrodeSmoke = 222,
        ATK_ParasiteFarAttack = 40,
        ATK_ParasiteGenerateWall = 216,
        ATK_ParasiteJumpAttack = 39,
        ATK_ParasiteJumpMachete = 220,
        ATK_ParasiteMachete = 218,
        ATK_ParasiteShove = 221,
        ATK_ParasiteThrowWall = 217,
        ATK_ParasiteVehicleBreak1 = 214,
        ATK_ParasiteVehicleBreak2 = 41,
        ATK_ParasiteVehicleBreak3 = 42,
        ATK_ParasiteVehicleBreak4 = 43,
        ATK_ParasiteWeaponBreak = 38,
        ATK_Pr_ar_010 = 295,
        ATK_Pr_sg_010 = 296,
        ATK_Pr_sm_010 = 294,
        ATK_Pr_sr_010 = 297,
        ATK_Punch = 80,
        ATK_Punch1 = 81,
        ATK_Punch2 = 82,
        ATK_Push = 48,
        ATK_PushPlayer = 51,
        ATK_PushSlide = 52,
        ATK_PushSlideInterp = 1,
        ATK_PushUp = 49,
        ATK_QuietDashKill = 141,
        ATK_QuietDashStun = 142,
        ATK_QuietDeath = 143,
        ATK_Quiet_sr_010 = 290,
        ATK_Quiet_sr_020 = 291,
        ATK_Quiet_sr_030 = 292,
        ATK_SP_hg_010 = 311,
        ATK_SP_hg_020 = 312,
        ATK_SP_sg_010 = 314,
        ATK_SP_sm_010 = 313,
        ATK_Sad = 266,
        ATK_SadStun = 267,
        ATK_Sahelan_AirMine = 244,
        ATK_Sahelan_Flame = 246,
        ATK_Sahelan_FootStamp = 236,
        ATK_Sahelan_Grenade = 245,
        ATK_Sahelan_HeadVulcan = 240,
        ATK_Sahelan_JumpImpact = 239,
        ATK_Sahelan_MidleMissile = 243,
        ATK_Sahelan_ParasiteSword = 241,
        ATK_Sahelan_PileBunker = 248,
        ATK_Sahelan_RailGun = 247,
        ATK_Sahelan_RockExplosion = 250,
        ATK_Sahelan_RodAttack = 237,
        ATK_Sahelan_RodAttackImpact = 238,
        ATK_Sahelan_SmallMissile = 242,
        ATK_Sahelan_Stomp = 249,
        ATK_Sahelan_TowerBreak = 251,
        ATK_ShieldBlock = 289,
        ATK_ShieldBroken = 73,
        ATK_ShieldSlash = 66,
        ATK_ShieldSlashStun = 67,
        ATK_ShockDecoy = 30,
        ATK_ShockDecoy_G1 = 31,
        ATK_ShockDecoy_G2 = 32,
        ATK_SkullFace_hg_010 = 309,
        ATK_Sleep = 76,
        ATK_SleepGus = 286,
        ATK_SleepGusAssist = 24,
        ATK_SleepGusOccurred = 287,
        ATK_SleepRecover = 102,
        ATK_SleepingGusGrenade = 188,
        ATK_SleepingGusGrenade_G1 = 189,
        ATK_SleepingGusGrenade_G2 = 190,
        ATK_SleepingGusMine = 208,
        ATK_SleepingGusMine_G1 = 209,
        ATK_SleepingGusMine_G2 = 210,
        ATK_SmallFlame = 70,
        ATK_Smoke = 284,
        ATK_SmokeAssist = 23,
        ATK_SmokeGrenade = 181,
        ATK_SmokeOccurred = 285,
        ATK_Stab = 2,
        ATK_StepOn = 65,
        ATK_Stomp = 60,
        ATK_StunArm = 163,
        ATK_StunArmThunder = 165,
        ATK_StunArm_G1 = 164,
        ATK_StunArm_G2 = 36,
        ATK_StunGrenade = 182,
        ATK_StunGrenadeGrazed = 185,
        ATK_StunGrenadeGrazed_G1 = 186,
        ATK_StunGrenadeGrazed_G2 = 187,
        ATK_StunGrenadeGrazed_G3 = 453,
        ATK_StunGrenadeGrazed_G4 = 461,
        ATK_StunGrenadeGrazed_G5 = 463,
        ATK_StunGrenadeGrazed_G6 = 465,
        ATK_StunGrenade_G1 = 183,
        ATK_StunGrenade_G2 = 184,
        ATK_StunGrenade_G3 = 452,
        ATK_StunGrenade_G4 = 460,
        ATK_StunGrenade_G5 = 462,
        ATK_StunGrenade_G6 = 464,
        ATK_StunRocket = 167,
        ATK_StunRocket_G1 = 168,
        ATK_StunRocket_G2 = 169,
        ATK_SupineFootSweep = 64,
        ATK_SupplyCBoxHit = 86,
        ATK_SupplyCBoxHitSpecial = 87,
        ATK_SupplyFlareGrenade = 27,
        ATK_SupportHeliFlareGrenade = 26,
        ATK_TankCannon = 13,
        ATK_Tankgun_105mmRifledBoreGun = 303,
        ATK_Tankgun_120mmSmoothBoreGun = 304,
        ATK_Tankgun_125mmSmoothBoreGun = 305,
        ATK_Tankgun_12_7mmHeavyMachineGun_East = 308,
        ATK_Tankgun_12_7mmHeavyMachineGun_West = 307,
        ATK_Tankgun_20mmAutoCannon = 301,
        ATK_Tankgun_30mmAutoCannon = 302,
        ATK_Tankgun_82mmRocketPoweredProjectile = 306,
        ATK_ThrowTackle = 68,
        ATK_Turret = 261,
        ATK_TurretStun = 262,
        ATK_UavExplosion = 273,
        ATK_UavGrenade = 271,
        ATK_UavLmg = 270,
        ATK_UavSleepGusGrenade = 272,
        ATK_VehicleBlast = 117,
        ATK_VehicleCrash = 116,
        ATK_VehicleDrop = 118,
        ATK_VehicleHit = 111,
        ATK_VehicleHitBreakObstacle = 115,
        ATK_VehicleHitMiddleSpeed = 114,
        ATK_VehiclePush = 112,
        ATK_VolRideBullet = 226,
        ATK_VolRideFirewall = 227,
        ATK_VolginBodyFire = 231,
        ATK_VolginBodyFireVehicle = 232,
        ATK_VolginBodyFireVehicleCrushed = 233,
        ATK_VolginChargeExplosion = 228,
        ATK_VolginFireBullet = 234,
        ATK_VolginFirePillar = 229,
        ATK_VolginFireball = 230,
        ATK_VolginGameOver = 45,
        ATK_VolginGroundFire = 235,
        ATK_WalkerGear_BodyAttack = 156,
        ATK_WalkerGear_BodyAttackBreakObstacle = 159,
        ATK_WalkerGear_FastBodyAttack = 157,
        ATK_WalkerGear_Flame = 150,
        ATK_WalkerGear_Fulton_Bomb = 149,
        ATK_WalkerGear_HandGun_00 = 18,
        ATK_WalkerGear_HandGun_01 = 19,
        ATK_WalkerGear_HandGun_02 = 20,
        ATK_WalkerGear_HandGun_03 = 21,
        ATK_WalkerGear_HandGun_04 = 22,
        ATK_WalkerGear_Kick = 160,
        ATK_WalkerGear_Machete_Slash = 152,
        ATK_WalkerGear_Machete_Stab = 153,
        ATK_WalkerGear_MiddleSpeedBodyAttack = 158,
        ATK_WalkerGear_MiniGun = 148,
        ATK_WalkerGear_Missile = 17,
        ATK_WalkerGear_Strike = 154,
        ATK_WalkerGear_StunGun = 151,
        ATK_WalkerGear_Throw = 155,
        ATK_WarHead = 57,
        ATK_WaterFaucetSplash = 16,
        ATK_WaterTankSplash = 128,
        ATK_WaterTowerSplash = 127,
        ATK_WaterWayArch = 130,
        ATK_WaterWayPillar = 132,
        ATK_WaterWayWall = 131,
        ATK_Wav1 = 268,
        ATK_WavCannon = 12,
        ATK_WavRocket = 14,
        ATK_WolfBite = 140,
        ATK_ZombieInfection = 224,
        ATK_ZombieScratch = 225,
        ATK_mgm0_ammo0 = 299,
        ATK_mgm0_famo0 = 300,
        ATK_mgm0_mgun0 = 298,
        ATK_uth0_ammo0 = 276,
        ATK_uth0_ammo0_2 = 277,
        ATK_uth0_ammo0_3 = 278,
        ATK_uth0_ammo1 = 279,
        ATK_uth0_ammo1_2 = 280,
        ATK_uth0_ammo1_3 = 281,
    },
    damSources = {
        DAM_SOURCE_Antimaterial = 9,
        DAM_SOURCE_Arm = 14,
        DAM_SOURCE_Assault = 3,
        DAM_SOURCE_Assist = 15,
        DAM_SOURCE_Boss = 22,
        DAM_SOURCE_Cqc = 12,
        DAM_SOURCE_CqcKnife = 13,
        DAM_SOURCE_DDog = 17,
        DAM_SOURCE_DHorse = 18,
        DAM_SOURCE_Grenader = 5,
        DAM_SOURCE_Handgun = 1,
        DAM_SOURCE_Heli = 20,
        DAM_SOURCE_Machinegun = 7,
        DAM_SOURCE_Missile = 8,
        DAM_SOURCE_None = 0,
        DAM_SOURCE_Placed = 11,
        DAM_SOURCE_Quiet = 16,
        DAM_SOURCE_Shotgun = 4,
        DAM_SOURCE_Sniper = 6,
        DAM_SOURCE_Submachinegun = 2,
        DAM_SOURCE_Throwing = 10,
        DAM_SOURCE_Vehicle = 19,
        DAM_SOURCE_WalkerGear = 21,
    },
    injParts ={
        INJ_PART_ALL = 1,
        INJ_PART_ARM = 2,
        INJ_PART_LEG = 3,
        INJ_PART_NONE = 0,  
    },
    injTypes = {
        INJ_TYPE_BULLET = 3,
        INJ_TYPE_CUT = 2,
        INJ_TYPE_DISLOCATED = 1,
        INJ_TYPE_NONE = 0,
    },
    eqpTypes = {
        EQP_TYPE_Ammo = 10,
        EQP_TYPE_AmmoBox = 15,
        EQP_TYPE_Assault = 1,
        EQP_TYPE_AttackArm = 14,
        EQP_TYPE_Bullet = 11,
        EQP_TYPE_GrenadeLauncher = 7,
        EQP_TYPE_Handgun = 2,
        EQP_TYPE_Item = 17,
        EQP_TYPE_Machinegun = 6,
        EQP_TYPE_Missile = 8,
        EQP_TYPE_None = 0,
        EQP_TYPE_Placed = 13,
        EQP_TYPE_Shield = 9,
        EQP_TYPE_Shotgun = 5,
        EQP_TYPE_Sniper = 4,
        EQP_TYPE_Submachinegun = 3,
        EQP_TYPE_Throwing = 12,
        EQP_TYPE_WeaponBox = 16,
    },
    reticleTypes = {
        RETICLE_UI_ASSAULT = 1,
        RETICLE_UI_EMPLACEMENT = 11,
        RETICLE_UI_GRENADER = 5,
        RETICLE_UI_HANDGUN = 7,
        RETICLE_UI_HANDGUN_TRANQ = 8,
        RETICLE_UI_MACHINEGUN = 4,
        RETICLE_UI_MISSILE = 6,
        RETICLE_UI_NONE = 0,
        RETICLE_UI_SHOTGUN = 3,
        RETICLE_UI_SNIPER = 2,
        RETICLE_UI_SUBMACHINEGUN = 9,
        RETICLE_UI_VEHICLE = 10,
    },
    triggerTypes = {
        TRIGGER_3PBURST = 2,
        TRIGGER_COCKING = 0,
        TRIGGER_FULLAUTO = 3,
        TRIGGER_SEMIAUTO = 1,
    },
}

--UI
function this.ModMenu(menu)
	ZetaMenu.CreateModMenu(this,menu)
    ZetaMenu.AddModItemToMenu(this, menu,
    "PrintReceiverParameters",  
    "PrintReceiverParameters", 
    "Print Receiver Parameters", 
    "Prints Current Weapon Receiver Parameters.")

    ZetaMenu.CreateModMenu(this,menu, "Receiver Set Base Parameters","Modify receiver set base parameters", "IronSight")
    for i, value in ipairs(this.receiverSetBaseLabels) do
        ZetaMenu.AddModItemToMenu(this, menu,
        this.CustomOption(-8192,8192,0.01,0,function(self) 
            local ironSight = this.GetReceiverParam(3, ZetaEquipParameters.equipParameters.receiverParamSetsBase)
            if ironSight ~= nil and next(ironSight) then self:Set(ironSight[i])end
        end ),  
        "IronSightP"..i, value, "Changes value for "..value, "IronSight")
    end

    ZetaMenu.CreateModMenu(this,menu, "Receiver Set Wobbling Parameters","Modify receiver set wobbling parameters", "Wobbling")
    for i, value in ipairs(this.receiverWobblingLabels) do
        ZetaMenu.AddModItemToMenu(this, menu,
        this.CustomOption(-8192,8192,0.01,0,function(self) 
            local wobBle = this.GetReceiverParam(4, ZetaEquipParameters.equipParameters.receiverParamSetsWobbling)
            if wobBle ~= nil and next(wobBle) then self:Set(wobBle[i])end
        end ),  
        "WobblingP"..i, value, "Changes value for "..value, "Wobbling")
    end

    ZetaMenu.CreateModMenu(this, menu, "Receiver Set Systems Parameters","Modify receiver set systems parameters", "Systems")
    local systemTablesEx = {
        [1] = this.eqpTypes,
        [2] = this.reticleTypes,
        [3] = this.triggerTypes,
    }
    for i, value in ipairs(this.receiverSystemLabels) do
        local func = this.CustomOption(-8192,8192,0.01,0,
        function(self) 
            local sysParam = this.GetReceiverParam(5, ZetaEquipParameters.equipParameters.receiverParamSetsSystem)
            if sysParam ~= nil and next(sysParam) then self:Set(sysParam[i]) end
        end )
        local altTable = systemTablesEx[i]
        if altTable ~= nil and next(altTable) then
            func = this.CustomListOption( altTable,0,function(self) 
                local sysParam = this.GetReceiverParam(5, ZetaEquipParameters.equipParameters.receiverParamSetsSystem)
                if sysParam ~= nil and next(sysParam) then self:Set(sysParam[i]) end
            end )
        end
        ZetaMenu.AddModItemToMenu(this, menu, func, "SystemsP"..i, value, "Changes value for "..value, "Systems")
    end

    ZetaMenu.CreateModMenu(this,menu,"Damage Parameters","Modify weapon damage parameters", "DamageParams")
    local damTablesEx = {
        [1] = this.atkIDs,
        [9] = this.injTypes,
        [10] = this.injParts,
        [29] = this.damSources,
    }
    for i, value in ipairs(this.damageLabels) do
        local func = this.CustomOption(-8192,8192,0.01,0,
        function(self) 
            local damParam = this.GetDamageParameters()
            if damParam ~= nil and next(damParam) then self:Set(damParam[i]) end
        end )
        local altTable = damTablesEx[i]
        if altTable ~= nil and next(altTable) then
            func = this.CustomListOption( altTable,0,function(self) 
                local damParam = this.GetDamageParameters()
                if damParam ~= nil and next(damParam) then self:Set(damParam[i]) end
            end )
        end
        ZetaMenu.AddModItemToMenu(this, menu, func, "DamageParamsP"..i, value, "Changes value for "..value, "DamageParams")
    end
end

function this.CustomOption(itemMin,itemMax,itemInc,itemDefault,onSelect)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		range={min=itemMin,max=itemMax,increment=itemInc},
		default=itemDefault,
        OnChange=function()end,
		OnSelect=onSelect,
	} 
	return ret
end

function this.CustomListOption(tableToList,itemDefault,onSelect)
	local ret = {
		inMission=true,
		save=IvarProc.CATEGORY_EXTERNAL,
		settings={},
		default=itemDefault,
        OnChange=function()end,
        GetSettingText=function(self,setting)
            local curSetting = setting
            for key, value in pairs(tableToList) do
                if curSetting == value then
                    return key
                end
            end
            return ""
        end,
        OnSelect=onSelect,
	} 
	return ret
end

--Functions
function this.GetWeaponEntry(equip)
    if equip ~= nil then
        local constTable = ZetaEquipIdTable.equipIdTable
        if constTable ~= nil and next(constTable)then
            local indexOfEqp = ZetaUtil.GetIndex(equip,constTable)
            if indexOfEqp ~= nil then
                return constTable[indexOfEqp][3]
            end
        end
    end
    return nil
end

function this.GetGunBasicEntry(weapon)
    if weapon ~= nil then
        local gunBasicTable = ZetaEquipParameters.equipParameters.gunBasic
        if gunBasicTable ~= nil and next(gunBasicTable)then
            local indexOfWp = ZetaUtil.GetIndex(weapon,gunBasicTable)
            if indexOfWp ~= nil then
                return gunBasicTable[indexOfWp]
            end
        end
    end
    return nil
end

function this.GetReceiverEntry(gunBasic)
    if gunBasic ~= nil then
        local receiverTable = ZetaEquipParameters.equipParameters.receiver
        if receiverTable ~= nil and next(receiverTable)then
            local indexOfRecv = ZetaUtil.GetIndex(gunBasic[2],receiverTable)
            if indexOfRecv ~= nil then
                return receiverTable[indexOfRecv]
            end
        end
    end
    return nil
end

function this.GetReceiverParam(index, table)
    if table ~= nil and next(table) then
        local playerEquip = ZetaPlayer.GetHeldEquip()
        if playerEquip ~= nil then
            local receiver = this.GetReceiverEntry( this.GetGunBasicEntry( this.GetWeaponEntry(playerEquip) ) )
            if receiver ~= nil then
                local setBase = table[receiver[index]+1] 
                if setBase ~= nil then return setBase end
            end
        end
    end
    return nil
end

function this.GetDamageEntry(attackID)
    if attackID ~= nil then
        local damTable = ZetaDamageParameterTables.DamageParameterTable
        if damTable ~= nil and next(damTable)then
            local indexOfAtk = ZetaUtil.GetIndex(attackID,damTable)
            if indexOfAtk ~= nil then
                return damTable[indexOfAtk]
            end
        end
    end
    return nil
end

function this.GetDamageParameters()
    local playerEquip = ZetaPlayer.GetHeldEquip()
    if playerEquip ~= nil then
        local receiver = this.GetReceiverEntry( this.GetGunBasicEntry( this.GetWeaponEntry(playerEquip) ) )
        if receiver ~= nil then
            local atkID = this.GetDamageEntry(receiver[2])
            if atkID ~= nil then return atkID end
        end
    end
    return nil
end

--Print Functions
function this.PrintReceiverParameters()
    local playerEquip = ZetaPlayer.GetHeldEquip()
    if playerEquip ~= nil then
        local receiver = this.GetReceiverEntry( this.GetGunBasicEntry( this.GetWeaponEntry(playerEquip) ) )
        if receiver ~= nil then
            this.PrintTableEntries("receiverParamSetsBase: ", ZetaEquipParameters.equipParameters.receiverParamSetsBase[receiver[3]+1])
            this.PrintTableEntries("receiverParamSetsWobbling: ", ZetaEquipParameters.equipParameters.receiverParamSetsWobbling[receiver[4]+1])
            this.PrintTableEntries("receiverParamSetsSystem: ", ZetaEquipParameters.equipParameters.receiverParamSetsSystem[receiver[5]+1])
            this.PrintTableEntries("receiverParamSetsSound: ", ZetaEquipParameters.equipParameters.receiverParamSetsSound[receiver[6]+1])
        end
    end
end

function this.PrintTableEntries(modLog, entries)
    if entries ~= nil and next(entries)then
        local string = "{"
        for i,value in ipairs(entries) do --Tables returned by all mods
            string = string.."\""..value.."\","
        end
        string = string .."},"
        InfCore.Log(modLog..string,false,true)
    end
end

return this