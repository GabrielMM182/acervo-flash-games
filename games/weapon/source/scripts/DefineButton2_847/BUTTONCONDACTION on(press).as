on(press){
   if(_root.mp5sdbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 400)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 400 && _root.mp5sdbuy == 0)
   {
      _root.mp5sdbuy = 1;
      _root.credits -= 400;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("mp5");
   }
}
