onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glocklambuy == 1)
      {
         if(_root.plam == false)
         {
            _root.plam = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.plam == true)
         {
            _root.plam = false;
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
