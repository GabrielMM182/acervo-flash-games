on(press){
   if(_root.glockbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 1800)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 1800 && _root.glockbuy == 0)
   {
      _root.glockbuy = 1;
      _root.credits -= 1800;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop("glock");
   }
}
