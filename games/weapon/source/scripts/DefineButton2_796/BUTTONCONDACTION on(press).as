on(press){
   if(_root.glocklambuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 450)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 450 && _root.glocklambuy == 0)
   {
      _root.glocklambuy = 1;
      _root.credits -= 450;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(_root.secondary);
   }
}
