_root.mag--;
_root.shots++;
_root.rifleshellcall();
_root.shooting();
_root.gun.gunsel._rotation += 1.5;
if(_root.akvgrip == false)
{
   _root.accnum += 6;
   _root.gun.crosshair._xscale += 120;
   _root.gun.crosshair._yscale += 120;
   _root.gun.crosshair._alpha -= 30;
   _root.gun.gunsel._x += 5 + random(5);
   _root.gun.gunsel._y -= 5 + random(5);
}
else
{
   _root.accnum += 5.5;
   _root.gun.crosshair._xscale += 90;
   _root.gun.crosshair._yscale += 90;
   _root.gun.crosshair._alpha -= 30;
   _root.gun.gunsel._x += 3 + random(3);
   _root.gun.gunsel._y -= 3 + random(3);
}
_root.gun.gunsel.flasher.gotoAndPlay(2);
