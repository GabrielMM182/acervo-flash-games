function checkWallStatus()
{
   if(wall.health == wall.maxHealth || wall.health >= wall.maxHealth * 91 / 100)
   {
      _root.theWall.gotoAndStop("full");
      wall.destroyed = false;
   }
   else if(wall.health <= wall.maxHealth * 90 / 100 && wall.health >= wall.maxHealth * 71 / 100)
   {
      _root.theWall.gotoAndStop("90_PERCENT");
      wall.destroyed = false;
   }
   else if(wall.health <= wall.maxHealth * 70 / 100 && wall.health >= wall.maxHealth * 51 / 100)
   {
      _root.theWall.gotoAndStop("70_PERCENT");
      wall.destroyed = false;
   }
   else if(wall.health <= wall.maxHealth * 50 / 100 && wall.health >= wall.maxHealth * 31 / 100)
   {
      _root.theWall.gotoAndStop("50_PERCENT");
      wall.destroyed = false;
   }
   else if(wall.health <= wall.maxHealth * 30 / 100 && wall.health >= wall.maxHealth * 11 / 100)
   {
      _root.theWall.gotoAndStop("30_PERCENT");
      wall.destroyed = false;
   }
   else if(wall.health <= wall.maxHealth * 10 / 100)
   {
      _root.theWall.gotoAndStop("10_PERCENT");
      wall.destroyed = false;
   }
   else if(wall.health <= 0 && !wallAnimatedDestroyed)
   {
      _root.theWall.gotoAndStop("destroyed");
   }
}
wall = new Object();
wall.health = 10000;
wall.maxHealth = 10000;
wall.destroyed = false;
startOfLevelWallHealth = wall.health;
