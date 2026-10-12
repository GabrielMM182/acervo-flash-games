_root.mag--;
_root.shots++;
_root.rifleshellcall();
_root.shooting();
_root.gun.gunsel._rotation += 1;
if(_root.m4grip == false)
{
   _root.accnum += 4.5;
   _root.gun.crosshair._xscale += 100;
   _root.gun.crosshair._yscale += 100;
   _root.gun.crosshair._alpha -= 30;
   _root.gun.gunsel._x += 5 + random(5);
   _root.gun.gunsel._y -= 5 + random(5);
}
else
{
   _root.accnum += 3.5;
   _root.gun.crosshair._xscale += 70;
   _root.gun.crosshair._yscale += 70;
   _root.gun.crosshair._alpha -= 30;
   _root.gun.gunsel._x += 3 + random(6);
   _root.gun.gunsel._y -= 3 + random(6);
}
_root.gun.gunsel.flasher.gotoAndPlay(2);
