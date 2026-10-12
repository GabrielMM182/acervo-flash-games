function enemyGenerator()
{
   delay--;
   liveZombieCount = zombiesCreated - zombiesKilled;
   if(delay <= 0 && zombiesCreated <= _root[currentLevel].zombiePool && liveZombieCount < zombieLimit)
   {
      delay = _root[currentLevel].spawnRate;
      x++;
      currentZombieType = _root[currentLevel].zombieTypes[random(_root[currentLevel].totalTypes)];
      if(_root[currentLevel][currentZombieType] > 0)
      {
         if(currentZombieType == "zombieDog")
         {
            _root.attachMovie("zombieDog","enemy" + x,x + 3);
         }
         else
         {
            _root.attachMovie("newZombie","enemy" + x,x + 3);
         }
         _root[currentLevel][currentZombieType]--;
         zombiesCreated++;
         if(_root[currentLevel][currentZombieType] <= 0)
         {
            _root[currentLevel].totalTypes--;
            removeZombieType(currentZombieType);
         }
      }
      _root["enemy" + x]._visible = false;
      _root["enemy" + x].colorTransformTo(60,0,60,0,60,0,100,0,0);
      _root["enemy" + x]._y = random(180) + 120;
      _root["enemy" + x]._x = -90;
      _root["enemy" + x].cacheAsBitmap = true;
      _root["enemy" + x]._visible = true;
      enemyOnScreen.push({ref:_root["enemy" + x],depth:_root["enemy" + x]._y});
      aliveZombies.push({ref:_root["enemy" + x],type:currentZombieType,health:_root[currentZombieType].health,speed:_root[currentZombieType].speed,damage:_root[currentZombieType].damage,depth:_root["enemy" + x]._y,idle:false,animating:false,eating:false,dead:false,proximity:0,proximityToExplosion:0,targetX:0,targetY:0,tempNum:0,beingExploded:false});
      if(currentZombieType == "zombieSlow" || currentZombieType == "zombieFast" || currentZombieType == "zombieSprint" || currentZombieType == "zombieEater")
      {
         zombieAppearance("enemy" + x);
      }
      else
      {
         zombieAppearanceCustom("enemy" + x,currentZombieType);
      }
   }
   if(zombiesCreated == _root[currentLevel].zombiePool)
   {
      delete makeEnemy.onEnterFrame;
   }
}
function removeZombieType(zombieTypeName)
{
   for(i in _root[currentLevel].zombieTypes)
   {
      if(_root[currentLevel].zombieTypes[i] == zombieTypeName)
      {
         _root[currentLevel].zombieTypes.splice(i,1);
         break;
      }
   }
}
