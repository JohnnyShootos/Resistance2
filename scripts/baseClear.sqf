{
	{
		hideObjectGlobal _x;
	} forEach nearestTerrainObjects [ getMarkerPos ( _x select 0 ) , ["TREE", "SMALL TREE", "BUSH" , "FOREST"], ( _x select 1 ) ];
} forEach [ [ "clearArea_1" , 20 ] , [ "clearArea_2" , 10 ] , [ "clearArea_3" , 10 ] ];