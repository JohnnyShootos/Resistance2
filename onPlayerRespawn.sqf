//Close the spectator if the player respawned during the mission
["Terminate"] call BIS_fnc_EGSpectator;

//Execute Player Setup sqf
_handle = [] execVM "scripts\playerSetup.sqf";
waitUntil { scriptDone _handle };

