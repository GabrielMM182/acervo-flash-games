function setupWall(townName)
{
   wall = new Object();
   wall.health = location[townName].maxWallHealth;
   wall.maxHealth = location[townName].maxWallHealth;
   wall.destroyed = false;
   startOfLevelWallHealth = wall.health;
   wallAnimatedDestroyed = false;
}
function checkWallStatus()
{
   if(wall.health == wall.maxHealth || wall.health >= wall.maxHealth * 51 / 100)
   {
      _root.theWall.gotoAndStop(location[currentTownLocation].ref + "_full");
      wallAnimatedDestroyed = false;
      wall.destroyed = false;
   }
   else if(wall.health <= wall.maxHealth * 50 / 100 && wall.health >= wall.maxHealth * 1 / 100)
   {
      _root.theWall.gotoAndStop(location[currentTownLocation].ref + "_half");
      wallAnimatedDestroyed = false;
      wall.destroyed = false;
   }
   else if(wall.health <= 0 && !wallAnimatedDestroyed)
   {
      _root.theWall.gotoAndStop(location[currentTownLocation].ref + "_dead");
      wallAnimatedDestroyed = true;
   }
}
setupWall(currentTownLocation);
