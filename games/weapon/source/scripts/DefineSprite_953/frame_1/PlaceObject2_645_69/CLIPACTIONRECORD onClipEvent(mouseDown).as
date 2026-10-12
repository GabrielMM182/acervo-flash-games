onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.mediumbuy == 1)
      {
         if(_root.bodygear !== 3)
         {
            _root.bodygear = 3;
            _root.bodyprimarys = 5;
            _root.bodysecondarys = 3;
            _root.bodyarmor = 4;
            gear1 = new Sound();
            gear1.attachSound("gearequip");
            gear1.start();
         }
         else if(_root.bodygear == 3)
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
      else if(_root.mediumbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storemedium");
      }
   }
}
