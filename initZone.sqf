///////////////FUNCTIONS////////////////////

RADIO_TOWER_CHECK = {
	waitUntil {sleep 1; alive radio_tower};

	while {alive radio_tower} do {

		//Spawn an opfor jet
		_jetData = [[0,0,0],0,(_this select 0),east,false] call BIS_fnc_spawnVehicle;
		MAIN_AO_JET = (_jetData select 0);
		{_x setSkill 0.8} forEach (_jetData select 1);
		(_jetData select 0) flyInHeight 300;

		//Give it a waypoint at the AO
		_wp = (_jetData select 2) addWaypoint [(_this select 1), 0];
		_wp setWaypointType "SAD";
		_wp setWaypointSpeed "LIMITED";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointCombatMode "RED";
		(_jetData select 2) setCurrentWaypoint _wp;
		
		//Wait till its dead or the AO is finished and keep it fueled and full of ammo
		waitUntil {
			(_jetData select 0) setFuel 1;
			(_jetData select 0) setVehicleAmmoDef 1; 
			sleep 60; 
			(!alive (_jetData select 0)) || (!alive radio_tower)
		};
	};
	//Little bit of delay then delete the jet
	sleep 30;
	deleteVehicle MAIN_AO_JET;
};

MAIN_BASE_LOGIC = {
	_pos = _this;
	COUNTER_ATTACK = false;
	AO_CLEAR = false;
	_trg = createTrigger ["EmptyDetector", _pos, false];
	_trg setTriggerActivation ["WEST","PRESENT", true];
	_trg setTriggerArea [40,40,0,false,40];
	_trg setTriggerStatements ["this", "COUNTER_ATTACK = true;", "COUNTER_ATTACK = false"];

	MAIN_ZONE_OBJECTS pushBackUnique _trg;

	_trg = createTrigger ["EmptyDetector", _pos, false];
	_trg setTriggerActivation ["ANY","PRESENT", true];
	_trg setTriggerArea [40,40,0,false,40];
	_trg setTriggerTimeout [30,60,45,true];
	_trg setTriggerStatements ["this && COUNTER_ATTACK", "AO_CLEAR = true",""];

	MAIN_ZONE_OBJECTS pushBackUnique _trg;

	waitUntil {sleep 5; AO_CLEAR};

	{
		if (side _x == east) then {_x setSkill ["Courage", 0]};
	} forEach allUnits;

	"Enemy Forces are retreating!" remoteExec ["hint", 0];
	COUNTER_ATTACK = false;
	sleep 60;

	waitUntil {DAC_NewZone == 0};
	["z1"] call DAC_fDeleteZone;
	waitUntil {DAC_NewZone == 0};
	
	if (count CAMP_ZONE_NAMES > 0) then {
		waitUntil {DAC_NewZone == 0};
		CAMP_ZONE_NAMES call DAC_fDeleteZone;
	};

	//Wait for players to leave to clean up objects
	waitUntil {sleep 30; {_pos distance2D (position _x) < 100} count playableUnits == 0};
	if (DEBUG_MODE) then {{deleteMarker _x} forEach MARKER_TRASH;};
	{deletevehicle _x} forEach MAIN_ZONE_OBJECTS;
	{deletevehicle _x} forEach CAMP_ZONE_OBJECTS;

	sleep 30;


	[] execVM "initZone.sqf";
};

SPAWN_COMPOSITION = {
	_comp = _this call TFD_fnc_objectMapper;
	{
		if (_x getVariable "vectorUp") then {
			_x setVectorUp [0,0,1];
		} else {
			_x setVectorUp surfaceNormal position _x;
		};
		MAIN_ZONE_OBJECTS pushBackUnique _x;

		if (_x isKindOf "StaticWeapon") then {
			_crewArray = [_x, (createGroup east), false, "", "O_Soldier_F"] call BIS_fnc_spawnCrew;
			{MAIN_ZONE_OBJECTS pushBackUnique _x} forEach _crewArray;
		};
	} forEach _comp;
};

_mainBaseComp 	= call compile preprocessFileLineNumbers "scripts\deployable\zoneBaseComp.hpp";
_campComp 		= call compile preprocessFileLineNumbers "scripts\deployable\zoneCampComp.hpp";
////////////////////////////////////////////

//GC Variables
MARKER_TRASH = [];
CAMP_ZONE_NAMES = [];
CAMP_ZONE_OBJECTS = [];
MAIN_ZONE_OBJECTS = [];

//AOSIZE
_size = 750;

//Enter blacklist markernames
_blacklist = [];
{
	if ((_x find "exclusion") > -1) then {
		_blacklist pushBackUnique _x
	};
} forEach allMapMarkers;
TEST_BLACKLIST = _blacklist;

//Get map locations
_mapLocArray = _blacklist call TFD_fnc_gatherMapLocations;
TEST_LOC_ARR = _mapLocArray;

_arr = [];

//Remove empty arrays
{
	if (count _x != 0) then {_arr pushBack _x};
} forEach _mapLocArray;

_mapLocArray = _arr;

//Pick a type of location
_chosenLocArray = _mapLocArray call BIS_fnc_selectRandom;

//Choose the actual location
_chosenLocation = _chosenLocArray call BIS_fnc_selectRandom;

//Location name
_chosenLocationName = text _chosenLocation;
systemChat str _chosenLocationName;
_chosenLocationPosition = locationPosition _chosenLocation;

if (_chosenLocationName == missionNamespace getVariable ["LAST_CHOSEN_LOCATION", ""]) exitWith {[] execVM "initZone.sqf"; hint "Same Location as Last time!"};

missionNamespace setVariable ["LAST_CHOSEN_LOCATION", _chosenLocationName];

//Pick a random spot around the location chosen and keep looping till an appropriate one is found
_pos = [];
_badSpot = true;
while {_badSpot} do {
	_pos = [_chosenLocationPosition,0,1000,30,0,0.25,0] call BIS_fnc_findSafePos;

	if (_pos isEqualto ([[0,0],0,5,10,0,0,0] call BIS_fnc_findSafePos)) then {
		_badSpot = true;
		systemChat "No Suitable spot for main base";
	} else {
		_badSpot = false;
	};
};

//AO - Debug Marker
if (DEBUG_MODE) then {
	_marker = createMarker ["AOmarker", _pos];
	_marker setMarkerShape "ELLIPSE";
	_marker setMarkerSize [_size,_size];
	_marker setMarkerBrush "SolidBorder";
	_marker setMarkerColor "ColorRed";
	_marker setMarkerAlpha 0.5;
	MARKER_TRASH pushBackUnique _marker;
};

/////////////////Prepare AO DAC ZONE////////////////

_numInf = "NumberOfInfantry" call BIS_fnc_getParamValue;
_numVeh = "NumberOfVehicles" call BIS_fnc_getParamValue;
_numTnk = "NumberOfArmored" call BIS_fnc_getParamValue;
_numHel = "NumberOfHelicopter" call BIS_fnc_getParamValue;

waitUntil {DAC_NewZone == 0};
_values = ["z1",[1,0,0],[_numInf,2,(_numInf*8),8],[_numVeh,2,(_numVeh*8),8],[_numTnk,2,(_numTnk*8),8],[_numHel,5,50],[0,10,0,2,5]];
[_pos,_size,_size,0,0,_values] call DAC_fNewZone;

//Deploy Main Base Objects
[_pos, random 360, _mainBaseComp] call SPAWN_COMPOSITION;

////////////////Prepare Camp Zones//////////////////

//Camp Zones
for "_i" from 1 to 3 do {
	_angle = (120*(_i-1));	
	_posCamp = [_pos getPos [(_size*0.75),_angle],0,(_size*0.25),20,0,0.25,0] call BIS_fnc_findSafePos; 

	//Deploy Camp Zones if a legitimate position was found
	if !(_posCamp isEqualto ([[0,0],0,5,10,0,0,0] call BIS_fnc_findSafePos)) then {
		waitUntil {DAC_NewZone == 0};
		_campName = format["c%1",_i];
		CAMP_ZONE_NAMES pushBackUnique _campName;
		_values = [_campName,[1,0,0],[],[],[],[1,3,50,1,100,999,[z1]],[0,10,0,0,5]];
		[_posCamp,50,50,0,0,_values] call DAC_fNewZone;
	
	//Debug Markers
		if (DEBUG_MODE) then {
		_marker = createMarker [format["camp_marker_%1", _i], _posCamp];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "loc_Tourism";
		_marker setMarkerColor "ColorYellow";
		_marker setMarkerText format["Camp %1",_i];
		_marker setMarkerAlpha 0.75;

		MARKER_TRASH pushBackUnique _marker;
		};
	};

	sleep 1;
};

/////////////////Prepare Radio Tower/////////////////////
_posTower = [_pos,0,(_size/2),15,0,0.5,0] call BIS_fnc_findSafePos; 

if (DEBUG_MODE) then {
	_marker = createMarker ["radio_tower_marker", _posTower];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "loc_Transmitter";
	_marker setMarkerText "Radio Tower";
	_marker setMarkerAlpha 0.75;
	MARKER_TRASH pushBackUnique _marker;
};

//Create a Radio Tower
radio_tower = "Land_TTowerBig_2_F" createVehicle _posTower;
radio_tower setVectorUp [0,0,1];

MAIN_ZONE_OBJECTS pushBackUnique radio_tower;

waitUntil {alive radio_tower && DAC_NewZone == 0};

///////////////////Initialise Zone Logic////////////////

//Call in Air support for OPFOR until radio tower is destroyed (5 mins respawn after you knock it out)
["O_Plane_CAS_02_F", _pos, _size] spawn RADIO_TOWER_CHECK;

//Main Base logic
_pos spawn MAIN_BASE_LOGIC;