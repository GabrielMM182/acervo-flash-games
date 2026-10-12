_root.mag--;
_root.shots++;
_root.pistolshellcall();
_root.shooting();
_root.accnum += 7;
_root.gun.crosshair._xscale += 120;
_root.gun.crosshair._yscale += 120;
_root.gun.crosshair._alpha -= 40;
_root.gun.gunsel.flasher.gotoAndPlay(2);
if(_root.automatic == false)
{
   _root.gun.gunsel._x += 10;
   _root.gun.gunsel._y -= 8;
   _root.gun.gunsel._rotation += 10;
}
if(_root.automatic == true)
{
   _root.gun.gunsel._x += random(9);
   _root.gun.gunsel._y -= random(5);
   _root.gun.gunsel._rotation += 5;
}
