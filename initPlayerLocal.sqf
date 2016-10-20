#include "missionSettings.hpp"
[ TFD_ORBAT ] call TFD_fnc_assignGroup;

[] call TFD_fnc_addRallyPointAction;

// Saving disabled without autosave.
enableSaving [false,false];

//Disable AI radio calls
enableSentences false;

