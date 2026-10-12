onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glocklambuy == 1)
      {
         if(_root.kimberlam == false)
         {
            _root.kimberlam = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.kimberlam == true)
         {
            _root.kimberlam = false;
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
