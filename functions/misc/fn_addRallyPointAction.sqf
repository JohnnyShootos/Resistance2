_condition = {
    (leader group _player == _player ) && (_player distance getMarkerPos "respawn_guerrila" > 1000) && (_player getVariable ['spawn_beacon_deploy_ready', true])
};
_statement = {
    params ["_target","_player","_params"];
    
	_caseType = "Land_DataTerminal_01_F";
	_player setVariable ['spawn_beacon_deploy_ready', false, true];

	//Create rallypoint terminal
	_position = _player getPos [1,(direction _player)];
	_case = createVehicle [_caseType, _position, [], 0, "CAN_COLLIDE"];
	_case setDir (direction _player);
	_case allowDamage false;
	[_case,"red","blue","green"] spawn BIS_fnc_DataTerminalColor;
	_case setVariable ["isDeployed", false, true];
	

	//Add activate action
	_condition = {
		(_player distance _target < 2) && !(_target getVariable ["isDeployed", true])
	};
	_statement = {
		params ["_target","_player","_params"];
		[_target, 3] call BIS_fnc_DataTerminalAnimate;
		_target setVariable ["isDeployed", true, true];
		
		MY_SPAWN_BEACON = [group _player, _target, (format["%1 RallyPoint",name _player])] call BIS_fnc_addRespawnPosition;
	};
	_action = ["ActivateRallyPoint","Activate Rallypoint","",_statement,_condition] call ace_interact_menu_fnc_createAction;
	_action set [7, {[0,0,0.5]}];
	[_case, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;

	//Add Packup Action
	_condition = {
		(_player distance _target < 2) && (_target getVariable ["isDeployed", false]) && (local _target)
	};
	_statement = {
		_this spawn {
			params ["_target","_player","_params"];
			[_target, 0] call BIS_fnc_DataTerminalAnimate;
			MY_SPAWN_BEACON call BIS_fnc_removeRespawnPosition;
			_player setVariable ['spawn_beacon_deploy_ready', true, true];
			sleep 4;
			deleteVehicle _target;
		};
	};
	_action = ["PackUpRallyPoint","Pack Up Rallypoint","",_statement,_condition] call ace_interact_menu_fnc_createAction;
	_action set [7, {[0,0,0.5]}];
	[_case, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;
};

_action = ["DeployRallypointObject","Deploy Rallypoint","",_statement,_condition] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;









