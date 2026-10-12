onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.leg1buy == 1)
      {
         if(_root.leg1 == false)
         {
            _root.leg1 = true;
            _root.legsecondarys += 2;
            gear1 = new Sound();
            gear1.attachSound("gearequip2");
            gear1.start();
         }
         else if(_root.leg1 == true)
         {
            _root.leg1 = false;
            _root.legsecondarys -= 2;
            gear2 = new Sound();
            gear2.attachSound("gearequip2");
            gear2.start();
         }
      }
      else if(_root.leg1buy == 0)
      {
         _root.loadout.store.gotoAndStop("storeleg1");
      }
   }
}
