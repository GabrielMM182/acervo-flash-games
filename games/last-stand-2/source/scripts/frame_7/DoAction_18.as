function checkPenetration()
{
   if(_root[currentWeapon].penetrates == true)
   {
      roundsOnScreen[k].penetrateCount++;
      if(roundsOnScreen[k].penetrateCount >= _root[currentWeapon].goesThrough)
      {
         enemyOnScreen[j].ref.penetrateCount.text = roundsOnScreen[k].penetrateCount;
         roundsOnScreen[k].ref.removeMovieClip();
         roundsOnScreen.splice(k,1);
         w;
      }
   }
   else
   {
      roundsOnScreen[k].ref.removeMovieClip();
      roundsOnScreen.splice(k,1);
   }
}
