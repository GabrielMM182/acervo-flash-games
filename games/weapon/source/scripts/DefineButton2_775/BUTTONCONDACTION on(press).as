on(press){
   if(_root.lightbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 1100)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 1100 && _root.lightbuy == 0)
   {
      _root.bodygear = 2;
      _root.bodyprimarys = 3;
      _root.bodysecondarys = 1;
      _root.bodyarmor = 2;
      gear1 = new Sound();
      gear1.attachSound("gearequip");
      gear1.start();
      _root.lightbuy = 1;
      _root.credits -= 1100;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(1);
   }
}
