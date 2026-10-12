onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.belt1buy == 1)
      {
         if(_root.belt !== 1)
         {
            _root.belt = 1;
            _root.beltsecondarys = 4;
            _root.beltprimarys = 0;
            gear1 = new Sound();
            gear1.attachSound("gearequip2");
            gear1.start();
         }
         else if(_root.belt == 1)
         {
            _root.belt = 0;
            _root.beltsecondarys = 0;
            _root.beltprimarys = 0;
            gear2 = new Sound();
            gear2.attachSound("gearequip2");
            gear2.start();
         }
      }
      else if(_root.belt1buy == 0)
      {
         _root.loadout.store.gotoAndStop("storebelt1");
      }
   }
}
