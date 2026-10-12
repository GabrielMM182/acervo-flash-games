function sunRiseCheck()
{
   remainderOfZombies = _root[currentLevel].zombiePool - zombiesKilled;
   thirdOfZombies = _root[currentLevel].zombiePool / 3.1;
   if(remainderOfZombies < thirdOfZombies && sunriseStarted == false)
   {
      trace("((((((((((((((((((((((((  SUNRISE STARTED  ))))))))))))))))))))))))))");
      _root.startSunRise();
      bgImage.dawn._visible = true;
   }
}
function startSunRise()
{
   if(sunriseStarted == false)
   {
      sunriseStarted = true;
      trace("STARTING SUNRISE");
      bgImage.dawn._alpha = 0;
      alphaSun = setInterval(alphaUpSun,500);
   }
}
function alphaUpSun()
{
   if(bgImage.dawn._alpha <= 100)
   {
      bgImage.dawn._alpha += 2;
   }
   else
   {
      trace("ooooooooooooooooooooooooooo STOPPING SUNRISE ooooooooooooooooooooooooooo");
      clearInterval(alphaSun);
   }
}
function resetSunRise()
{
   trace("))))))))))))))))) RESETTING SUNRISE (((((((((((((((((");
   sunriseStarted = false;
   clearInterval(alphaSun);
   bgImage.dawn._alpha = 0;
   bgImage.dawn._visible = false;
}
sunriseStarted = false;
bgImage.dawn._visible = false;
