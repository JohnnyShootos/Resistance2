_blackList = _this;
_worldCenter = [(worldSize/2),(worldSize/2),0];
_searchRadius = sqrt (((worldSize/2)^2) + ((worldSize/2)^2));

_return = [];
//Create arrays of all map locations by type
_NameVillageLocs = nearestLocations [_worldCenter,["NameVillage"],_searchRadius]; 
_NameCityLocs = nearestLocations [_worldCenter,["NameCity"],_searchRadius]; 
_NameCityCapitalLocs = nearestLocations [_worldCenter,["NameCityCapital"],_searchRadius]; 
_NameLocalLocs = nearestLocations [_worldCenter,["NameLocal", "Airport"],_searchRadius];

//remove capital cities in safezone
{
	_pos = _x;
	{
		if ((locationPosition _pos) inArea _x) then {
			_NameLocalLocs = _NameLocalLocs - [_pos];
		};
	} forEach _blackList;
} forEach _NameLocalLocs;
_return pushBack _NameLocalLocs;
//remove villages in safezone
{
	_pos = _x;
	{
		if ((locationPosition _pos) inArea _x) then {
			_NameVillageLocs = _NameVillageLocs - [_pos];
		};
	} forEach _blackList;
} forEach _NameVillageLocs;
_return pushBack _NameVillageLocs;
//remove cities in safezone
{
	_pos = _x;
	{
		if ((locationPosition _pos) inArea _x) then {
			_NameCityLocs = _NameCityLocs - [_pos];
		};
	} forEach _blackList;
} forEach _NameCityLocs;
_return pushBack _NameCityLocs;
//remove capital cities in safezone
{
	_pos = _x;
	{
		if ((locationPosition _pos) inArea _x) then {
			_NameCityCapitalLocs = _NameCityCapitalLocs - [_pos];
		};
	} forEach _blackList;
} forEach _NameCityCapitalLocs;
_return pushBack _NameCityCapitalLocs;

_return