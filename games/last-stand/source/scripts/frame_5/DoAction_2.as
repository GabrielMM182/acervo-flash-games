function removeThisZombie(zombieRef)
{
   trace("CALLING REMOVE THIS ZOMBIE! WITH A TIMEOUT! " + zombieRef + " >>>>>>>>>>>>>>>???????????????????????");
   trace("DEADZOMBIES ON SCREEN: " + deadZombieCount);
   if(deadZombieCount >= deadZombieCountMax)
   {
      _root[zombieRef].alphaTo(0,0.15,"linear",0,function()
      {
         removeMovieClip(_root[zombieRef]);
      }
      );
      deadZombieCount--;
   }
}
deadZombieCount = 0;
deadZombieCountMax = 35;
removeZombieDelay = 30000;
