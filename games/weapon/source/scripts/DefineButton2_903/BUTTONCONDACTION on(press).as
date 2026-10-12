on(press){
   if(_root.aimpointbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 2500)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 2500 && _root.aimpointbuy == 0)
   {
      _root.aimpointbuy = 1;
      _root.credits -= 2500;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(_root.primary);
   }
}
