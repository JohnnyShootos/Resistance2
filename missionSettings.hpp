TFD_ADMINS = [
	"76561198007514110",	//Atreus
	"76561197974803128",  	//Mortified
	"76561197996594471",	//Apex
	"76561198005613267",	//Imperator
	"76561198011140335",	//Tonny747
	"76561198052511971",	// Skillet
	"76561197987496729",	//JohnnyShootos		(for testing / debugging)
	"76561198046408605"		// Jam_Toast		(for testing / debugging)
]; publicVariable "TFD_ADMINS";

/* 
*
* TFD_ORBAT is used to assign group names and radio channels.
*
* Usage - [ "groupName" , SW Channel , SW Channel block, "name" , "name" ]
* Add one new array per group. Ensure all arrays except the final one are followed by a comma (,)
*
*/

TFD_ORBAT = [
	//groupName - sw - (ch block) - units in the group -- Channel block is optional and can be omitted
	["COY HQ",		8,	1,	"s_1","s_2"],
	["1st PLT HQ",	8,	1,	"s_5","s_6"],
	["ALPHA", 		1,	1,	"s_7","s_8","s_9","s_10","s_11","s_12"],
	["BRAVO", 		2,	1,	"s_13","s_14","s_15","s_16","s_17","s_18"],
	["CHARLIE",		3,	1,	"s_19","s_20","s_21","s_22","s_23","s_24"],
	["2nd PLT HQ",	8,	2,	"s_25","s_26"],
	["DELTA",		1,	2,	"s_27","s_28","s_29","s_30","s_31","s_32"],
	["ECHO",		2,	2,	"s_33","s_34","s_35","s_36","s_37","s_38"],
	["FOXTROT",		3,	2,	"s_39","s_40","s_41","s_42","s_43","s_44"],
	["3rd PLT HQ",	8,	3,	"s_45","s_46"],
	["GOLF",		1,	3,	"s_47","s_48","s_49","s_50","s_51","s_52"],
	["HOTEL",		2,	3,	"s_53","s_54","s_55","s_56","s_57","s_58"],
	["INDIA",		3,	3,	"s_59","s_60","s_61","s_62","s_63","s_64"],
	["N.R.M.A.",	1,	4,	"s_65","s_66","s_4"],
	["COOPER",		2,	4,	"s_67","s_68","s_3"],
	["MASH",		3,	4,	"s_69","s_70","s_71","s_72"]
];

/*
*
* startMission is used by the game logic to define the briefing phase from the play phase.
* For a 'hot start' mission set this to true.
*
*/

startMission = missionNameSpace getVariable ["startMission", false];

/*
*
* scriptedPlayerKit is used to check if you are using the "playerKit.sqf" script to assign player equipment.
* set to true if you are using the script.
*
*/

scriptedPlayerKit = false;