on(press){
   if(_root.gripbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 400)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 400 && _root.gripbuy == 0)
   {
      _root.gripbuy = 1;
      _root.credits -= 400;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(_root.primary);
   }
}
