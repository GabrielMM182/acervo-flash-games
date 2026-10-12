function zombieProximityCheck()
{
   var _loc2_ = {x:_root.mainChar.mainGun.barrelEnd._x,y:_root.mainChar.mainGun.barrelEnd._y};
   _root.mainChar.mainGun.barrelEnd.localToGlobal(_loc2_);
   for(v in aliveZombies)
   {
      _root.aliveZombies[v].targetX = _root.aliveZombies[v].ref._x;
      _root.aliveZombies[v].targetY = _root.aliveZombies[v].ref._y - 45;
      _root.aliveZombies[v].proximity = Math.round(Math.sqrt((_loc2_.x - _root.aliveZombies[v].targetX) * (_loc2_.x - _root.aliveZombies[v].targetX) + (_loc2_.y - _root.aliveZombies[v].targetY) * (_loc2_.y - _root.aliveZombies[v].targetY)));
      aliveZombies[v].ref.zombieProximity.text = v;
   }
}
function zombieProximitySort()
{
   _root.aliveZombies.sortOn("proximity",Array.DESCENDING,Array.NUMERIC);
}
