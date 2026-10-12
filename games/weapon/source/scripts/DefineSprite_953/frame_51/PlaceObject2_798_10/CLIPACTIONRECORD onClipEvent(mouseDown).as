onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glocklambuy == 1)
      {
         if(_root.m9lam == false)
         {
            _root.m9lam = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m9lam == true)
         {
            _root.m9lam = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.glocklambuy == 0)
      {
         _root.loadout.store.gotoAndStop("storepistollam");
      }
   }
}
