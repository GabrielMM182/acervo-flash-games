function removeThisZombie(zombieRef)
{
   if(deadZombieCount >= deadZombieCountMax)
   {
      _root[zombieRef].alphaTo(0,0.3,"linear",0,function()
      {
         removeMovieClip(_root[zombieRef]);
      }
      );
      deadZombieCount--;
   }
}
deadZombieCount = 0;
deadZombieCountMax = 5;
removeZombieDelay = 8000;
