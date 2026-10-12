on(press){
   if(_root.heavybuy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 3400)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 3400 && _root.heavybuy == 0)
   {
      _root.bodygear = 4;
      _root.bodyprimarys = 9;
      _root.bodysecondarys = 5;
      _root.bodyarmor = 6;
      gear1 = new Sound();
      gear1.attachSound("gearequip");
      gear1.start();
      _root.heavybuy = 1;
      _root.credits -= 3400;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(1);
   }
}
