on(press){
   if(_root.acogbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 3100)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 3100 && _root.acogbuy == 0)
   {
      _root.acogbuy = 1;
      _root.credits -= 3100;
      _root.creditflash.gotoAndPlay(2);
   }
}
