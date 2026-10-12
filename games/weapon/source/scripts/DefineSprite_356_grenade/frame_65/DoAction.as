i = 1;
while(i <= _root.grenaderealnum)
{
   k = 1;
   while(k <= 3)
   {
      if(_root["damage" + k]._currentframe == 1)
      {
         _root["damage" + k]._x = _root._x + _root.nadeAdd._x + _root.nadeAdd["grenade" + i]._x;
         _root["damage" + k]._y = _root._y + _root.nadeAdd._y + _root.nadeAdd["grenade" + i]._y;
         _root["damage" + k].play();
      }
      k++;
   }
   i++;
}
