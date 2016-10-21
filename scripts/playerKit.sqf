_type = typeOf player;

// Clothing Selection
	_uniform = "U_BG_Guerrilla_6_1";
	
	_headgear = "H_Cap_oli";
	
	_vest = "V_TacChestrig_oli_F";
	
	_bag = "B_FieldPack_oli";

// Weapons
	_glasses = goggles player;
	
// Strip
	removeAllWeapons player;
	removeAllItems player;
	removeUniform player;
	removeVest player;
	removeBackpack player;
	removeHeadgear player;

// Basic Assign
	player forceAddUniform _uniform;
	player addVest _vest;
	player addHeadgear _headgear;
	player addBackpack _bag;
	
_assignedItems = [ "ItemMap" , "ItemCompass" , "ItemWatch" , "ItemRadio" ];
	
{
	
	if ( _x in _assignedItems ) then { } else { player unlinkItem _x; };
	
} forEach assignedItems player;

{
	
	if ( _x in assignedItems player ) then { } else { player linkItem _x; };
	
} forEach _assignedItems;
	
	player addItemToUniform "ACE_MapTools";
	player addItemToUniform "ACE_morphine";
	for "_i" from 1 to 3 do { player addItemToUniform "ACE_fieldDressing"; };
	for "_i" from 1 to 2 do { player addItemToUniform "SmokeShell"; };
	for "_i" from 1 to 3 do { player addItemToUniform "HandGrenade"; };

[player] call ace_hearing_fnc_putInEarplugs;

player addGoggles _glasses;