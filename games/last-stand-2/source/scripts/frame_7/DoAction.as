function setupLighting()
{
   for(v in friendliesOnScreen)
   {
      friendliesOnScreen[v].ref.colorTransformTo(location[currentTownLocation].brightnessLevelHero,0,location[currentTownLocation].brightnessLevelHero,0,location[currentTownLocation].brightnessLevelHero,0,100,0,0);
   }
}
