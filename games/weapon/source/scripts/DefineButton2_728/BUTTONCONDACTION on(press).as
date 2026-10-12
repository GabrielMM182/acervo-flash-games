on(press){
   if(_root.akbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 6600)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 6600 && _root.akbuy == 0)
   {
      _root.akbuy = 1;
      _root.credits -= 6600;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("ak");
   }
}
