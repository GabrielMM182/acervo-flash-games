on(press){
   if(_root.reflexbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 1600)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 1600 && _root.reflexbuy == 0)
   {
      _root.reflexbuy = 1;
      _root.credits -= 1600;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(_root.primary);
   }
}
