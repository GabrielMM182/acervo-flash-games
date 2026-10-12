on(press){
   if(_root.mediumbuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 2200)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 2200 && _root.mediumbuy == 0)
   {
      _root.bodygear = 3;
      _root.bodyprimarys = 5;
      _root.bodysecondarys = 3;
      _root.bodyarmor = 4;
      gear1 = new Sound();
      gear1.attachSound("gearequip");
      gear1.start();
      _root.mediumbuy = 1;
      _root.credits -= 2200;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(1);
   }
}
