on(press){
   if(_root.uspbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 3300)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 3300 && _root.uspbuy == 0)
   {
      _root.uspbuy = 1;
      _root.credits -= 3300;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("usp");
   }
}
