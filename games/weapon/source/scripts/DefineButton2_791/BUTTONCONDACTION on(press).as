on(press){
   if(_root.leg2buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 600)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 600 && _root.leg2buy == 0)
   {
      _root.leg2 = true;
      _root.legprimarys += 3;
      gear1 = new Sound();
      gear1.attachSound("gearequip2");
      gear1.start();
      _root.leg2buy = 1;
      _root.credits -= 600;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(1);
   }
}
