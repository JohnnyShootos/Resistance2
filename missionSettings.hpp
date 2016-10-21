TFD_ADMINS = [
	"76561197987496729",	//JohnnyShootos
	"76561198046408605"		// Jam_Toast
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
	["CT1",			8,	1,	"s_1","s_2","s_3","s_4","s_5","s_6","s_7","s_8"],
	["CT2",			8,	1,	"s_9","s_10","s_11","s_12","s_13","s_14","s_15","s_16"],
	["CT3", 		1,	1,	"s_17","s_18","s_19","s_20","s_21","s_22","s_23","s_24"],
	["XRAY", 		2,	1,	"s_25","s_26"]
];

/*
*
* startMission is used by the game logic to define the briefing phase from the play phase.
* For a 'hot start' mission set this to true.
*
*/

startMission = true;

/*
*
* scriptedPlayerKit is used to check if you are using the "playerKit.sqf" script to assign player equipment.
* set to true if you are using the script.
*
*/

scriptedPlayerKit = true;