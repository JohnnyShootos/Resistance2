#include "missionSettings.hpp"
_nul = execVM "adminpanelmk2\fn_adminPanelInit.sqf";

DEBUG_MODE = [false, true] select ("DebugMode" call BIS_fnc_getParamValue);

setTimeMultiplier ("TimeAccel" call BIS_fnc_getParamValue);

