private ["_position", "_veh", "_num", "_itemType", "_itemChance", "_weights", "_index", "_iArray"];

waitUntil {!isNil "BIS_fnc_selectRandom"};

if (isDedicated) then {
  _position = [getMarkerPos "center", 0, 4000, 10, 0, 2000, 0] call BIS_fnc_findSafePos;
	_randomvehicle = ["Misc_cargo_cont_net1", "Misc_cargo_cont_net2", "Misc_cargo_cont_net3"] call BIS_fnc_selectRandom;
	_vehicleloottype = ["Industrial", "Military"] call BIS_fnc_selectRandom;
	_veh = createVehicle [_randomvehicle, _position, [], 0, "CAN_COLLIDE"];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor, _veh];
	_veh setVariable ["ObjectID", 1, true];

	if (_randomvehicle == "Misc_cargo_cont_net1") then { _num = round(random 3) + 3; };
	if (_randomvehicle == "Misc_cargo_cont_net2") then { _num = round(random 6) + 4; };
	if (_randomvehicle == "Misc_cargo_cont_net3") then { _num = round(random 12) + 5; };

	switch (_vehicleloottype) do {
		case "Military": {
			_itemType = [["SCAR_L_CQC", "weapon"],
						["M16A2", "weapon"], 
						["M16A2GL", "weapon"], 
						["AK_47_M", "weapon"], 
						["Sa58V_RCO_EP1", "weapon"], 
						["M4A1_Aim", "weapon"], 
						["AKS_74_kobra", "weapon"], 
						["Sa58V_CCO_EP1", "weapon"], 
						["AK_47_M", "weapon"], 
						["M1014", "weapon"], 
						["M4A1", "weapon"], 
						["UZI_EP1", "weapon"], 
						["Remington870_lamp", "weapon"], 
						["glock17_EP1", "weapon"], 
						["MP5A5", "weapon"], 
						["MP5SD", "weapon"], 
						["M4A3_CCO_EP1", "weapon"], 
						["Binocular", "weapon"], 
						["ItemFlashlightRed", "military"], 
						["ItemKnife", "military"], 
						["M60A4_EP1", "weapon"], 
						["ItemMap", "military"], 
						["DZ_British_ACU", "object"], 
						["DZ_ALICE_Pack_EP1", "object"], 
						["Skin_Camo1_DZ", "magazine"], 
						["", "medical"], 
						["", "generic"], 
						["", "military"], 
						["ItemEtool", "weapon"], 
						["ItemSandbag", "magazine"],
						["G36C_camo", "weapon], 
						["G36_C_SD_camo", "weapon"], 
						["G36A_camo", "weapon"]];
			_itemChance = [0.03, 
						   0.05, 
						   0.01, 
						   0.2, 
						   0.15, 
						   0.01, 
						   0.08, 
						   0.05, 
						   0.05, 
						   0.1, 
						   0.02, 
						   0.05, 
						   0.08, 
						   0.1, 
						   0.04, 
						   0.02, 
						   0.01, 
						   0.06, 
						   0.1, 
						   0.1, 
						   0.01, 
						   0.05, 
						   0.06, 
						   0.04, 
						   0.7, 
						   0.1, 
						   1.0, 
						   2.5, 
						   0.05,
						   0.02,
						   0.04,
						   0.02,
						   0.04];
		};
		case "Industrial": {
			_itemType = [["", "generic"], ["", "trash"], ["", "military"], ["WeaponHolder_PartGeneric", "object"], ["WeaponHolder_PartWheel", "object"], ["WeaponHolder_PartFueltank", "object"], ["WeaponHolder_PartEngine", "object"], ["WeaponHolder_PartGlass", "object"], ["WeaponHolder_PartVRotor", "object"], ["WeaponHolder_ItemJerrycan", "object"], ["WeaponHolder_ItemHatchet", "object"], ["ItemKnife", "military"], ["ItemToolbox", "weapon"], ["ItemWire", "magazine"], ["ItemTankTrap", "magazine"]];
			_itemChance = [0.18, 0.29, 0.04, 0.04, 0.05, 0.02, 0.01, 0.04, 0.01, 0.04, 0.11, 0.07, 0.02, 0.06, 0.04];	
		};
	};

	diag_log("DEBUG: Spawning a " + str(_randomvehicle) + " at " + str(_position) + " with loot type " + str(_vehicleloottype) + " and " + str(_num) + " total loot drops");

	waituntil {!isnil "fnc_buildWeightedArray"};

	_weights = [];
	_weights = [_itemType, _itemChance] call fnc_buildWeightedArray;
	
	for "_x" from 1 to _num do {
		_index = _weights call BIS_fnc_selectRandom;
		sleep 1;
		if (count _itemType > _index) then {
			_iArray = _itemType select _index;
			_iArray set [2, _position];
			_iArray set [3, 10];
			_iArray call spawn_loot;
			_nearby = _position nearObjects ["WeaponHolder", 20];
			
			{
				_x setVariable ["permaLoot", true];
			} forEach _nearBy;
		};
	};
};
