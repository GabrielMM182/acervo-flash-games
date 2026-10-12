_root.mag--;
_root.shots++;
_root.rifleshellcall();
_root.shooting();
_root.gun.gunsel._rotation += 1.5;
if(_root.g36vgrip == true)
{
   _root.accnum += 3.5;
   _root.gun.crosshair._xscale += 65;
   _root.gun.crosshair._yscale += 65;
   _root.gun.crosshair._alpha -= 20;
   _root.gun.gunsel._x += 1 + random(4);
   _root.gun.gunsel._y -= 1 + random(4);
}
else
{
   _root.accnum += 4.5;
   _root.gun.crosshair._xscale += 85;
   _root.gun.crosshair._yscale += 85;
   _root.gun.crosshair._alpha -= 25;
   _root.gun.gunsel._x += 2 + random(3);
   _root.gun.gunsel._y -= 2 + random(3);
}
_root.gun.gunsel.flasher.gotoAndPlay(2);
