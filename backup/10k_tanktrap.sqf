// 6 Razors into Tanktrap by Harlan.

private["_razor1"];

player removeAction s_razor_trap;
s_razor_trap = -1;

_razor1 = {_x == "ItemTrashRazor"} count magazines player;

if ( _razor1 > 5 ) then {
  if( ("ItemTrashRazor" in magazines player)) then {
		player playActionNow "Medic";
		[player,"repair",0,false] call dayz_zombieSpeak;
		sleep 0.1;
		[player,"cook",0,false] call dayz_zombieSpeak;
		_id = [player,70,true,(getPosATL player)] spawn player_alertZombies;
		sleep 4;

		for "_x" from 1 to 6 do {
			if( _razor1 > 0 ) then
			{
				player removeMagazine "ItemTrashRazor";
				_razor1 = _razor1 - 1;
			}
		};

		player addMagazine "ItemTankTrap";
		sleep 1;
		cutText ["You have successfully made a tank trap from 6 razors!", "PLAIN DOWN"];
	};
};
