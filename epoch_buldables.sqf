===============
cfgVehicles
===============
//http://dayzsuperhive.co.uk/uploads/3/0/3/2/3032704/5005685_orig.jpg
class Pile_of_wood;
class woodpile_DZ: Pile_of_wood
        {
                armor = 200;
                scope = 2;
                offset[] = {0,2.5,1};
                displayName = "Woodpile";
                vehicleClass = "Fortifications";
                transportMaxMagazines = 10;
                transportMaxWeapons = 0;
                transportMaxBackpacks = 0;
                constructioncount = 2;
                class transportmagazines
                {
                        class _xx_PartWoodPile
                        {
                                magazine = "PartWoodPile";
                                count = 10;
                        };
                };
        };
		
		
		
===============
cfgMagazines
===============




class woodpile_kit: CA_Magazine
        {
                scope = 2;
                count = 1;
                type = 256;
                displayName = "Woodpile";
                descriptionShort = "Woodpile: A buildable object that stores woodpiles. Comes pre-stocked with 10 piles of wood.";
                model = "\z\addons\dayz_epoch\models\supply_crate.p3d";
                picture = "\z\addons\dayz_epoch\pictures\equip_wooden_crate_ca.paa";
                weight = 25;
                class ItemActions
                {
                        class Build
                        {
                                text = $STR_ACTIONS_BUILD;
                                script = "spawn player_build;";
                                require[] = {"ItemEtool","ItemToolbox"};
                                create = "woodpile_DZ";
                        };
                };
        };
		
		
===========
class ItemCorrugated : CA_Magazine

						class Crafting3
                        {
                                text = $STR_EPOCH_PLAYER_xxx;
                                script = ";['Crafting3','CfgMagazines', _id] spawn player_craftItem;";
                                neednearby[] = {"workshop"};
                                requiretools[] = {"ItemToolbox","ItemCrowbar"};
                                output[] = {{"woodpile_kit",1}};
                                input[] = {{"ItemCorrugated",1},{"PartWoodLumber",6}};
                        };
