on(press){
   if(_root.belt2buy == 1)
   {
      _root.messages.gotoAndStop(4);
   }
   if(_root.credits < 800)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 800 && _root.belt2buy == 0)
   {
      _root.belt = 2;
      _root.beltsecondarys = 4;
      _root.beltprimarys = 2;
      _root.belt2buy = 1;
      gear1 = new Sound();
      gear1.attachSound("gearequip2");
      gear1.start();
      _root.credits -= 800;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(1);
   }
}
