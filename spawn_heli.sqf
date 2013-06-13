private ["_position", "_veh", "_num", "_itemType", "_itemChance", "_weights", "_index", "_iArray"];

waitUntil {!isNil "BIS_fnc_selectRandom"};

if (isDedicated) then {
  _position = [getMarkerPos "center", 0, 4000, 10, 0, 2000, 0] call BIS_fnc_findSafePos;
	_veh = createVehicle ["UH1Wreck_DZ", _position, [], 0, "CAN_COLLIDE"];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_veh];
	_veh setVariable ["ObjectID", 1, true];
	
	_num = round(random 4) + 5;
	
	dayzFire = [_veh, 2, time, false, false];
	publicVariable "dayzFire";
	if (isServer) then { nul = dayzFire spawn BIS_Effects_Burn; };

	_itemType = [["RPK_74", "weapon"], ["FN_FAL", "weapon"], ["bizon_silenced", "weapon"], ["M14_EP1", "weapon"], ["FN_FAL_ANPVS4", "weapon"], ["MakarovSD", "weapon"], ["M4A1_RCO_GL", "weapon"], ["KSVK", "weapon"], ["Mk_48_DZ", "weapon"], ["M249_DZ", "weapon"], ["BAF_L85A2_RIS_Holo", "weapon"], ["DMR", "weapon"], ["", "military"], ["", "medical"], ["MedBox0", "object"], ["M4A1_HWS_GL_SD_Camo", "weapon"], ["AmmoBoxSmall_556", "object"], ["AmmoBoxSmall_762", "object"], ["Skin_Camo1_DZ", "magazine"], ["Skin_Sniper1_DZ", "magazine"], ["G36K_camo", "weapon"]];
			_itemChance = [0.02, 0.02, 0.05, 0.05, 0.01, 0.02, 0.01, 0.01, 0.03, 0.05, 0.01, 0.1, 1, 0.5, 0.1, 0.01, 0.1, 0.1, 0.08, 0.05,0.02];

	diag_log ("DEBUG: Spawning a crashed helicopter at " + str(_position));

	waituntil {!isnil "fnc_buildWeightedArray"};

	_weights = [];
	_weights = [_itemType,_itemChance] call fnc_buildWeightedArray;

	for "_x" from 1 to _num do {
		_index = _weights call BIS_fnc_selectRandom;
		sleep 1;
		if (count _itemType > _index) then {
			_iArray = _itemType select _index;
			_iArray set [2, _position];
			_iArray set [3, 5];
			_iArray call spawn_loot;
			_nearby = _position nearObjects ["WeaponHolder", 20];
			
			{
				_x setVariable ["permaLoot", true];
			} forEach _nearBy;
		};
	};
};
