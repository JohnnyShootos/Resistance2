//////////////////////////////
//    Dynamic-AI-Creator    //
//    Version 3.1b - 2014   //
//--------------------------//
//    DAC_Config_Camps      //
//--------------------------//
//    Script by Silola      //
//    silola@freenet.de     //
//////////////////////////////

private [
			"_CampTyp","_campBasic","_campAmmo","_campStatic","_campWall","_campObjInit",
			"_campUserObj","_campAddUnit","_campRandomObj","_Unit_Pool_C","_array"
		];
			_boxType = ["Box_NATO_Ammo_F","Box_East_Ammo_F","Box_IND_Ammo_F","Box_FIA_Ammo_F"];
			_CampTyp = _this select 0;_array = [];

switch (_CampTyp) do
{
//-------------------------------------------------------------------------------------------------------------------------
	case 0:
	{
		_campBasic     = ["Flag_CSAT_F",["FirePlace_burning_f",15,10,0],["Land_BagBunker_Tower_F",10,0,0],["Logic",10,15,0],0];
		_campAmmo      = [[(_boxType call BIS_fnc_selectRandom),20,2,0]];
		_campStatic    = [["O_HMG_01_high_F",-5,15,315,"O_Soldier_F"],["O_HMG_01_high_F",25,-15,135,"O_Soldier_F"]];
		_campAddUnit   = [];
		_campUserObj   = [];
		_campRandomObj = [];
		_campWall 	   = ["Land_Razorwire_F",[-12,20],[40,40,0],[0,1,0,1],[1,0.1],[0,0]];
		_campObjInit   = [[],[],["_x setVectorUp surfaceNormal position _x"],[],[],[],["_x setVectorUp surfaceNormal position _x"]];
	}; 
//-------------------------------------------------------------------------------------------------------------------------
	case 1:
	{
		_campBasic     = ["Flag_NATO_F",["FirePlace_burning_f",15,10,0],["Land_BagBunker_Tower_F",10,0,0],["Logic",10,15,0],0];
		_campAmmo      = [["Box_NATO_Ammo_F",20,2,0],["Box_NATO_Wps_F",20,0,0],["Box_NATO_AmmoOrd_F",20,-2,0],["Box_NATO_WpsSpecial_F",20,-4,0]];
		_campStatic    = [["B_Mortar_01_F",-7,25,0,"B_Soldier_F"],["B_Mortar_01_F",25,25,0,"B_Soldier_F"],["B_Mortar_01_F",25,-20,180,"B_Soldier_F"],["B_Mortar_01_F",-7,-20,180,"B_Soldier_F"]];
		_campAddUnit   = [];
		_campUserObj   = [];
		_campRandomObj = [];
		_campWall      = [];
		_campObjInit   = [[],[],[],[],[],[],[]];
	};
//-------------------------------------------------------------------------------------------------------------------------
	case 2:
	{
		_campBasic     = ["NULL"];
		_campAmmo      = [];
		_campStatic    = [];
		_campAddUnit   = [];
		_campUserObj   = [];
		_campRandomObj = [];
		_campWall      = [];
		_campObjInit   = [[],[],[],[],[],[],[]];
	};
//-------------------------------------------------------------------------------------------------------------------------
	Default {
				if(DAC_Basic_Value != 5) then
				{
					DAC_Basic_Value = 5;publicvariable "DAC_Basic_Value";
					hintc "Error: DAC_Config_Camps > No valid config number";
				};
				if(true) exitwith {};
			};
};

_array = [_campBasic,_campAmmo,_campStatic,_campAddUnit,_campUserObj,_campRandomObj,_campWall,_campObjInit];
_array