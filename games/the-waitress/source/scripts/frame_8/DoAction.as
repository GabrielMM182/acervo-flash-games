if(!Pause)
{
   if(Scene.Cook._currentframe > 31 and Scene.Cook._currentframe <= 120)
   {
      Scene.Cook.play();
   }
   ic = 1;
   while(ic <= Cmax)
   {
      ActivateClient(ic);
      pos = eval("Scene.C" + ic)._x + Scene._x - 300;
      pan = pos / 3;
      if(pan < -100)
      {
         pan = -100;
      }
      if(pan > 100)
      {
         pan = 100;
      }
      vol = 100 - Math.abs(pos / 10);
      if(vol < 0)
      {
         vol = 0;
      }
      eval("Scene.C" + ic).Snd.setPan(pan);
      eval("Scene.C" + ic).Snd.setVolume(vol);
      ic++;
   }
   ActivateWaitress();
   PointerSymbol();
   if(Level == 1 and Scene.C1.Mode == 4)
   {
      Level = 2;
      AddClient();
   }
   if(Score > 300 and Level < 3)
   {
      Level = 3;
      AddClient();
      Ko = 2;
   }
   if(Score > 500 and Level < 4)
   {
      Level = 4;
      Ko = 3;
   }
   if(Score > 1000 and Level < 5)
   {
      Level = 5;
      AddClient();
      Ko = 4;
   }
   if(Score > 2000 and Level < 6)
   {
      Level = 6;
      Ko = 4.25;
   }
   if(Score > 3000 and Level < 7)
   {
      Level = 7;
      AddClient();
   }
   if(Score > 5000 and Level < 8)
   {
      Level = 8;
      Ko = 4.5;
   }
   if(Score > 7500 and Level < 9)
   {
      Level = 9;
      AddClient();
   }
   if(Score > 10000 and Level < 10)
   {
      Level = 10;
      Ko = 4.75;
      Lives++;
      UpdateLives();
   }
   if(Score > 12500 and Level < 11)
   {
      Level = 11;
      Ko = 5;
   }
   if(Score > 15000 and Level < 13)
   {
      Level = 13;
      AddClient();
      Lives++;
      UpdateLives();
   }
   if(Score > 17500 and Level < 14)
   {
      Level = 14;
      Ko = 5.25;
      Lives++;
      UpdateLives();
   }
   if(Score > 20000 and Level < 15)
   {
      Level = 15;
      AddClient();
      Lives++;
      UpdateLives();
   }
   if(Score > 25000 and Level < 16)
   {
      Level = 16;
      Ko = 5.5;
      Lives++;
      UpdateLives();
   }
   if(Score > 30000 and Level < 17)
   {
      Level = 17;
      Ko = 5.75;
      Lives++;
      UpdateLives();
   }
   if(Score > 40000 and Level < 18)
   {
      Level = 18;
      Ko = 6;
      Lives++;
      UpdateLives();
   }
   if(Score > 50000 and Level < 19)
   {
      Level = 19;
      Lives++;
      UpdateLives();
   }
   if(_xmouse > 500 and Scene._x > -900 and _ymouse < 250)
   {
      Scene._x -= (_xmouse - 500) / 4;
   }
   if(_xmouse < 100 and Scene._x < 150 and _ymouse < 250)
   {
      Scene._x -= (_xmouse - 100) / 4;
   }
   if(Scene.W.Busy)
   {
      BP._visible = true;
      Mouse.hide();
      BP._x = _xmouse;
      BP._y = _ymouse;
   }
   else
   {
      BP._visible = false;
      BP.gotoAndStop(1);
      Mouse.show();
   }
}
else
{
   if(Scene.Cook._currentframe > 31 and Scene.Cook._currentframe <= 120)
   {
      Scene.Cook.stop();
   }
   HLP._visible = true;
   Menu._visible = false;
   Scene._visible = false;
   Status._visible = false;
   Mouse.show();
}
