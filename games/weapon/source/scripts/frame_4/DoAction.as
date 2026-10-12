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
delay = 1 + random(_root.delaynum1);
delay2 = 1 + random(_root.delaynum2);
delay3 = 1 + random(_root.delaynum3);
delay4 = 1 + random(_root.delaynum4);
stick1New = 0;
stick1Placed = 0;
stick1Number = _root.enemys1;
stick2New = 0;
stick2Placed = 0;
stick2Number = _root.enemys2;
stick3New = 0;
stick3Placed = 0;
stick3Number = _root.enemys3;
stick4New = 0;
stick4Placed = 0;
stick4Number = _root.enemys4;
mkills = 0;
mcredits = 0;
grenadenum = 1;
depthNum = 1;
enemyYrandom = 1 + random(15);
enemyY = _root.bg._y + _root.bg.enemyAdd._y;
enemyX = _root.bg._x + _root.bg.enemyAdd._x;
sparkx = 550 + random(80);
sparky = 190 + random(30);
stick1left = stick1Number;
stick2left = stick2Number;
stick3left = stick3Number;
stick4left = stick4Number;
wavenumber = stick1Number + stick2Number + stick3Number + stick4Number;
_root.pauses = false;
onEnterFrame = function()
{
   if(stick1Placed < stick1Number)
   {
      stick1New++;
   }
   if(stick1New == delay)
   {
      stick1Placed++;
      stick1New = 0;
      delay = 1 + random(_root.delaynum1);
      guy = _root.bg.enemyAdd.attachMovie("Stickgun","Stick" + depthNum,enemyYrandom * 5000 + depthNum,{_x:enemyX,_y:enemyY + enemyYrandom});
      enemyYrandom = 1 + random(10);
      depthNum++;
   }
   if(stick2Placed < stick2Number)
   {
      stick2New++;
   }
   if(stick2New == delay2)
   {
      stick2Placed++;
      stick2New = 0;
      delay2 = 1 + random(_root.delaynum2);
      guy2 = _root.bg.enemyAdd.attachMovie("Stickrpg","Stick" + depthNum,enemyYrandom * 5000 + depthNum,{_x:enemyX,_y:enemyY + enemyYrandom});
      enemyYrandom = 1 + random(10);
      depthNum++;
   }
   if(stick3Placed < stick3Number)
   {
      stick3New++;
   }
   if(stick3New == delay3)
   {
      stick3Placed++;
      stick3New = 0;
      delay3 = 1 + random(_root.delaynum3);
      guy3 = _root.bg.enemyAdd.attachMovie("Stickheavy","Stick" + depthNum,enemyYrandom * 5000 + depthNum,{_x:enemyX,_y:enemyY + enemyYrandom});
      enemyYrandom = 1 + random(10);
      depthNum++;
   }
   if(stick4Placed < stick4Number)
   {
      stick4New++;
   }
   if(stick4New == delay4)
   {
      stick4Placed++;
      stick4New = 0;
      delay4 = 1 + random(_root.delaynum4);
      guy4 = _root.bg.enemyAdd.attachMovie("Sticktechnical","Stick" + depthNum,enemyYrandom * 5000 + depthNum,{_x:enemyX,_y:enemyY + enemyYrandom});
      enemyYrandom = 1 + random(10);
      depthNum++;
   }
};
if(_root.bodygear == 0)
{
   _root.ammo12 = 25;
   _root.primarys = 5;
   _root.secondarys = 5;
   _root.armor += 0;
}
else if(_root.bodygear == 1)
{
   _root.ammo12 = 25;
   _root.primarys = 5;
   _root.secondarys = 5;
   _root.armor += 5;
}
else if(_root.bodygear == 2)
{
   _root.ammo12 = 35;
   _root.primarys = 8;
   _root.secondarys = 4;
   _root.armor += 2;
}
else if(_root.bodygear == 3)
{
   _root.ammo12 = 50;
   _root.primarys = 10;
   _root.secondarys = 8;
   _root.armor += 4;
}
else if(_root.bodygear == 4)
{
   _root.ammo12 = 75;
   _root.primarys = 14;
   _root.secondarys = 10;
   _root.armor += 6;
}
if(_root.belt == 1)
{
   _root.secondarys += 4;
}
else if(_root.belt == 2)
{
   _root.secondarys += 4;
   _root.primarys += 2;
}
else if(_root.belt == 0)
{
   _root.secondarys += 0;
   _root.primarys += 0;
}
if(_root.leg2 == true)
{
   _root.primarys += 2;
}
if(_root.leg1 == true)
{
   _root.secondarys += 3;
}
if(_root.helmet == true)
{
   _root.armor += 2;
}
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
