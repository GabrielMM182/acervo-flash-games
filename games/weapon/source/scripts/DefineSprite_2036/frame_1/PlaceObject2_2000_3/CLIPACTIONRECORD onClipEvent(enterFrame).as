onClipEvent(enterFrame){
   if(this.hitTest(_root.gun.accuracy.shotter1.shothit._x + _root.gun.accuracy.shotter1._x + _root.gun.accuracy._x + _root.gun._x,_root.gun.accuracy.shotter1.shothit._y + _root.gun.accuracy.shotter1._y + _root.gun.accuracy._y + _root.gun._y,true))
   {
      _root.sparkUp();
   }
   i = 1;
   while(i <= 3)
   {
      if(this.hitTest(_root["damage" + i].hitter._x + _root["damage" + i]._x,_root["damage" + i].hitter._y + _root["damage" + i]._y))
      {
         _root.health -= 4;
      }
      i++;
   }
}
