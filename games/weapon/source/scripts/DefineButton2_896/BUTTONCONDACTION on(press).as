on(press){
   if(_root.eotechbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 2100)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 2100 && _root.eotechbuy == 0)
   {
      _root.eotechbuy = 1;
      _root.credits -= 2100;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(_root.primary);
   }
}
