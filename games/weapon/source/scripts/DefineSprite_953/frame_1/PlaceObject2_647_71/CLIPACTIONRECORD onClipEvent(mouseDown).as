onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.heavybuy == 1)
      {
         if(_root.bodygear !== 4)
         {
            _root.bodygear = 4;
            _root.bodyprimarys = 9;
            _root.bodysecondarys = 5;
            _root.bodyarmor = 6;
            gear1 = new Sound();
            gear1.attachSound("gearequip");
            gear1.start();
         }
         else if(_root.bodygear == 4)
         {
            _root.bodygear = 0;
            _root.bodyprimarys = 0;
            _root.bodysecondarys = 0;
            _root.bodyarmor = 0;
            gear2 = new Sound();
            gear2.attachSound("gearequip2");
            gear2.start();
         }
      }
      else if(_root.heavybuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeheavy");
      }
   }
}
