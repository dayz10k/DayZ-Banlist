// 3 TPs into Bandage by Harlan.

private["_toiletP1"];

player removeAction s_bandage_tp;
s_bandage_tp = -1;

_toiletP1 = {_x == "ItemTrashToiletPaper"} count magazines player;

if ( _toiletP1 > 2 ) then {
  if( ("ItemTrashToiletPaper" in magazines player)) then {
		player playActionNow "Medic";
		[player,"repair",0,false] call dayz_zombieSpeak;
		sleep 0.1;
		[player,"cook",0,false] call dayz_zombieSpeak;
		_id = [player,70,true,(getPosATL player)] spawn player_alertZombies;
		sleep 4;

		for "_x" from 1 to 3 do {
			if( _toiletP1 > 0 ) then
			{
				player removeMagazine "ItemTrashToiletPaper";
				_toiletP1 = _toiletP1 - 1;
			}
		};

		player addMagazine "ItemBandage";
		sleep 1;
		cutText ["You have successfully made a bandage from 3 toilet papers!", "PLAIN DOWN"];
	};
};
