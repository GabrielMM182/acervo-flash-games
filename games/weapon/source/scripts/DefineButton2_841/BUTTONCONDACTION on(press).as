on(press){
   if(_root.slingbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 500)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 500 && _root.slingbuy == 0)
   {
      _root.slingbuy = 1;
      _root.credits -= 500;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(_root.primary);
   }
}
