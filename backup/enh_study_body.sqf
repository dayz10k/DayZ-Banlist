private ["_body", "_name", "_kills", "_killsH", "_killsB", "_humanity","_temp","_diff","_dateNow","_deathTime","_body","_name","_method","_methodStr"];
 
_body =    _this select 3;
_name =    _body getVariable["bodyName","unknown"];
_method =    _body getVariable["deathType","unknown"];
_deathTime =    _body getVariable["deathTime",-1];
_methodStr = localize format ["str_death_%1",_method];
 
 
 
//diag_log ("STUDY: deathtime " +str(_deathTime));
if (_deathTime < 0) then {
    _temp = "unknown";
} else {
    _dateNow = (DateToNumber date);
    _diff = (_dateNow - _deathTime) * 525948;
 
    _temp = "The body is freezing";
 
    if ( _diff < 30 ) then {
        _temp = "The body is cold";
    };
 
    if ( _diff < 15 ) then {
        _temp = "The body is slightly warm";
    };
 
    if ( _diff < 5 ) then {
        _temp = "The body is still warm";
    };
};
cutText [format["Their name was %1. %2. It appears there is a journal on the body.",_name,_temp], "PLAIN DOWN"];
sleep 2;
 
_body = _this select 3;
_name = _body getVariable ["bodyName","unknown"];
_kills = _body getVariable ["zombieKills",0];
_killsH = _body getVariable ["humanKills",0];
_killsB = _body getVariable ["banditKills",0];
_humanity = _body getVariable ["humanity",0];
 
cutText [format["Zombie Kills: %1, Murders: %2, Bandit Kills: %3, Humanity: %4.",_kills,_killsH,_killsB,_humanity], "PLAIN DOWN"];
sleep 5;
