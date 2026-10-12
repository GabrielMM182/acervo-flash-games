_root.mag--;
_root.shots++;
_root.pistolshellcall();
_root.shooting();
_root.gun.gunsel._rotation += 1.5;
if(_root.umpvgrip == true)
{
   _root.accnum += 3;
   _root.gun.crosshair._xscale += 55;
   _root.gun.crosshair._yscale += 55;
   _root.gun.crosshair._alpha -= 20;
   _root.gun.gunsel._x += 1 + random(4);
   _root.gun.gunsel._y -= 1 + random(3);
}
else
{
   _root.accnum += 4;
   _root.gun.crosshair._xscale += 75;
   _root.gun.crosshair._yscale += 75;
   _root.gun.crosshair._alpha -= 25;
   _root.gun.gunsel._x += 1 + random(6);
   _root.gun.gunsel._y -= 1 + random(5);
}
_root.gun.gunsel.flasher.gotoAndPlay(2);
