on(press){
   if(_root.leg1buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 400)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 400 && _root.leg1buy == 0)
   {
      _root.leg1 = true;
      _root.legsecondarys += 2;
      gear1 = new Sound();
      gear1.attachSound("gearequip2");
      gear1.start();
      _root.leg1buy = 1;
      _root.credits -= 400;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(1);
   }
}
