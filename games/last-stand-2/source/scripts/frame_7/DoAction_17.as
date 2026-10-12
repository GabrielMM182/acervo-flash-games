function removeParentGameOverRetry()
{
   _root.cleanUpScreen();
   _root.retryLevelAgain();
   removeMovieClip(_root.gameOver);
}
function retryLevelAgain()
{
   hero.isAlive = true;
   mainChar.gotoAndStop("alive");
   wall.health = startOfLevelWallHealth;
   checkWallStatus();
   retryLevel = true;
   stopTimer();
}
var startOfLevelWallHealth = 8000;
