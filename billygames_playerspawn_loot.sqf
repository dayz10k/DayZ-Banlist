/*
Created exclusively for ArmA2:OA - DayZ/BMRF Billy Games.
permission is required to use/alter/distribute from project leader (NotCorsair) AND the author (HARLAN).
*/

//Items to be given upon spawn
//~~~~!!!!REDEFINE THESE AFTER THE ITEMS ARE CREATED!!!!!~~~~~
_item1="BI";
_item2="LL";
_item3="Y";

//count of items given on spawn--but this would need some work with publicvariables
//NOT FUNCTIONAL ATM and these should probably be identified in the server monitor on startup to prevent client calls overwriting their initialization

//publicVariable countWon1;
//publicVariable countWon2;
//publicVariable countWon3;
//countWon1=0;
//countWon2=0;
//countWon3=0;


//OK to localize the maxdistribution since its not changing per player
//~~~~!!!!REDEFINE THIS NUMBER AFTER THE AMOUNT OF PLAYERS IS DEFINED!!!!!~~~~~
_maxDistr=15;

//baseline loops
_countLoop=0;
_itemWon=0;
_itemWonLast=0;


//random selection process for item
while {_countLoop<3} do {
	_itemWon=floor(random 3);
	
	//incase random gives you the same number twice, add another random evaluation to ensure player 
	//gets two different items.
	//however, this may give a slightly larger weight to items 1 and 2 (case1+4 and case 2+5)
	if (_itemWon ==_itemWonLast) then{
		_itemWon=_itemWon+(floor(random 2));

		};
	switch (_itemWon) do
		{
		//adding some commented logic for the publicvariable tracking of how many of each item were won.
		//only thing left is to add some if-then statements if we really want to limit how many of each are
		//spawned to players.
			case 1: {addMagazine player _item1;
				//countWon1=countWon1+1;
				};
			case 2: {addMagazine player _item2};
				//countWon2=countWon2+1;
				};
			case 3: {addMagazine player _item3};
				//countWon3=countWon3+1;
				};
			case 4: {addMagazine player _item1};
				//countWon1=countWon1+1;
				};
			case 5: {addMagazine player _item2};
				//countWon2=countWon1+1;
				};
		};

	_itemWonLast=_itemWon;
	_countLoop=_countLoop +1;
	};
};
