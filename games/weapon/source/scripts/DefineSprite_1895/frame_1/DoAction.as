_root.mag--;
_root.shots++;
_root.rifleshellcall();
_root.shooting();
_root.gun.gunsel._rotation += 1;
if(_root.ak2vgrip == false)
{
   _root.accnum += 5;
   _root.gun.crosshair._xscale += 100;
   _root.gun.crosshair._yscale += 100;
   _root.gun.crosshair._alpha -= 30;
   _root.gun.gunsel._x += 4 + random(4);
   _root.gun.gunsel._y -= 4 + random(4);
}
else
{
   _root.accnum += 4;
   _root.gun.crosshair._xscale += 70;
   _root.gun.crosshair._yscale += 70;
   _root.gun.crosshair._alpha -= 30;
   _root.gun.gunsel._x += 2 + random(3);
   _root.gun.gunsel._y -= 2 + random(3);
}
_root.gun.gunsel.flasher.gotoAndPlay(2);
