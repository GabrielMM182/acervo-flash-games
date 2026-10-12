onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.leg2buy == 1)
      {
         if(_root.leg2 == false)
         {
            _root.leg2 = true;
            _root.legprimarys += 3;
            gear1 = new Sound();
            gear1.attachSound("gearequip2");
            gear1.start();
         }
         else if(_root.leg2 == true)
         {
            _root.leg2 = false;
            _root.legprimarys -= 3;
            gear2 = new Sound();
            gear2.attachSound("gearequip2");
            gear2.start();
         }
      }
      else if(_root.leg2buy == 0)
      {
         _root.loadout.store.gotoAndStop("storeleg2");
      }
   }
}
