on(press){
   if(_root.umpbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 5200)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 5200 && _root.umpbuy == 0)
   {
      _root.umpbuy = 1;
      _root.credits -= 5200;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("ump");
   }
}
