on(press){
   _root.health -= 100;
   if(_root.health > 0)
   {
      _root.gotoAndStop(2);
   }
   else
   {
      _root.gotoAndStop(5);
   }
}
