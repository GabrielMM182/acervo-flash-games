on(press){
   if(_root.macbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 3500)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 3500 && _root.macbuy == 0)
   {
      _root.macbuy = 1;
      _root.credits -= 2800;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("mac");
   }
}
