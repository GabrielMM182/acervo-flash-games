function mousefollow()
{
   _root.follower._x = _xmouse;
   _root.follower._y = _ymouse;
   updateAfterEvent();
}
function mousefollow2()
{
   _root.follower2._x = _xmouse;
   _root.follower2._y = _ymouse;
   updateAfterEvent();
}
function shooting()
{
   _root.accuracynum = _root.accnum;
   _root.accuracylow = - _root.accuracynum;
   _root.accuracyhigh = _root.accuracynum * 2;
   _root.gun.accuracy.shotter1.gotoAndPlay(2);
   _root.gun.accuracy.shotter1._x = _root.gun.accuracy._x + _root.accuracylow + random(_root.accuracyhigh);
   _root.gun.accuracy.shotter1._y = _root.gun.accuracy._y + _root.accuracylow + random(_root.accuracyhigh);
   _root.mshots = _root.mshots + 1;
}
function pistolshellcall()
{
   pistolShells = _root.shellAdd.attachMovie("pistolShell","pistolShell" + _root.shellAdd.getNextHighestDepth(),_root.shellAdd.getNextHighestDepth(),{_x:_root.gun.gunsel.shellplace._x + _root.gun.gunsel._x + _root.gun._x,_y:_root.gun.gunsel.shellplace._y + _root.gun.gunsel._y + _root.gun._y,_rotation:random(40)});
}
function rifleshellcall()
{
   rifleShells = _root.shellAdd.attachMovie("rifleShell","rifleShell" + _root.shellAdd.getNextHighestDepth(),_root.shellAdd.getNextHighestDepth(),{_x:_root.gun.gunsel.shellplace._x + _root.gun.gunsel._x + _root.gun._x,_y:_root.gun.gunsel.shellplace._y + _root.gun.gunsel._y + _root.gun._y,_rotation:random(40)});
}
function bloodPuff()
{
   _root.puffAdd.attachMovie("bloodPuff","bloodPuff" + _root.puffAdd.getNextHighestDepth(),_root.puffAdd.getNextHighestDepth(),{_x:_root._x - _root.puffAdd._x - _root.gun.accuracy.shotter1.shothit._x + _root.gun.accuracy.shotter1._x + _root.gun.accuracy._x + _root.gun._x,_y:_root._y - _root.puffAdd._y - _root.gun.accuracy.shotter1.shothit._y + _root.gun.accuracy.shotter1._y + _root.gun.accuracy._y + _root.gun._y,_rotation:-30 + random(60)});
}
function groundPuff()
{
   _root.bg.puffAdd.attachMovie("dustPuff","dustPuff" + _root.bg.puffAdd.getNextHighestDepth(),_root.bg.puffAdd.getNextHighestDepth(),{_x:_root._x - _root.bg._x - _root.bg.puffAdd._x - _root.gun.accuracy.shotter1.shothit._x + _root.gun.accuracy.shotter1._x + _root.gun.accuracy._x + _root.gun._x,_y:_root._y - _root.bg._y - _root.bg.puffAdd._y - _root.gun.accuracy.shotter1.shothit._y + _root.gun.accuracy.shotter1._y + _root.gun.accuracy._y + _root.gun._y,_xscale:_root._ymouse - 130,_yscale:_root._ymouse - 130});
}
function sparkUp()
{
   _root.puffAdd.attachMovie("sparkUp","sparkUp" + _root.puffAdd.getNextHighestDepth(),_root.puffAdd.getNextHighestDepth(),{_x:_root._x - _root.puffAdd._x - _root.gun.accuracy.shotter1.shothit._x + _root.gun.accuracy.shotter1._x + _root.gun.accuracy._x + _root.gun._x,_y:_root._y - _root.puffAdd._y - _root.gun.accuracy.shotter1.shothit._y + _root.gun.accuracy.shotter1._y + _root.gun.accuracy._y + _root.gun._y,_rotation:random(360)});
   _root.health -= _root.power;
}
function sparkOut()
{
   _root.puffAdd.attachMovie("sparkOut","sparkOut" + _root.puffAdd.getNextHighestDepth(),_root.puffAdd.getNextHighestDepth(),{_x:sparkx - _root.puffAdd._x,_y:sparky - _root.puffAdd._y,_rotation:-60 + random(120)});
   sparkx = 550 + random(80);
   sparky = 190 + random(30);
}
function cursormain()
{
   _root.cursor1._x = _xmouse;
   _root.cursor1._y = _ymouse;
   updateAfterEvent();
}
stop();
stopAllSounds();
song2.start();
mkills = 0;
mcredits = 0;
grenadenum = 1;
depthNum = 1;
enemyYrandom = 1 + random(15);
enemyY = _root.bg._y + _root.bg.enemyAdd._y;
enemyX = _root.bg._x + _root.bg.enemyAdd._x;
sparkx = 550 + random(80);
sparky = 190 + random(30);
_root.pauses = false;
_root.secondarys = 50;
_root.primarys = 50;
autostore1 = 1;
mags = primarys;
smags = secondarys;
if(_root.primary == "tmp" && _root.tmphi == false)
{
   _root.magstore1 = 20;
   _root.magstorer = 20;
}
else if(_root.primary == "m14")
{
   _root.magstore1 = 20;
   _root.magstorer = 20;
}
else
{
   _root.magstore1 = 30;
   _root.magstorer = 30;
}
if(_root.secondary == "deagle")
{
   _root.magstore2 = 7;
}
else if(_root.secondary == "glock" && _root.glockhi == true)
{
   _root.magstore2 = 30;
}
else if(_root.secondary == "mac")
{
   _root.magstore2 = 20;
}
else
{
   _root.magstore2 = 12;
}
