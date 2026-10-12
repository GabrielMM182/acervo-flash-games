onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.pistolsilencerbuy == 1)
      {
         if(_root.psil == false)
         {
            _root.psil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.psil == true)
         {
            _root.psil = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.pistolsilencerbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storepistolsil");
      }
   }
}
