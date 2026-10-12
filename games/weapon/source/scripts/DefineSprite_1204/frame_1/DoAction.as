function enemyout()
{
   var _loc2_ = 1 + random(5);
   i = 1;
   while(i < 5)
   {
      if(_root.bg["enemy" + _loc2_]._currentframe == 1)
      {
         _root.bg["enemy" + _loc2_].gotoAndStop("out");
      }
      i++;
   }
}
function woodhit1()
{
   i = 1;
   while(i <= 30)
   {
      if(_root.bg["woodhit" + i]._currentframe == 1)
      {
         _root.bg["woodhit" + i].gotoAndPlay(5);
         _root.bg["woodhit" + i]._rotation = random(360);
         _root.bg["woodhit" + i]._x = _root._x - _root.bg._x + _root.gun._x + _root.gun.accuracy.shotter1._x;
         _root.bg["woodhit" + i]._y = _root._y - _root.bg._y + _root.gun._y + _root.gun.accuracy.shotter1._y;
         return i;
      }
      i++;
   }
   return 0;
}
speed = 0.4;
