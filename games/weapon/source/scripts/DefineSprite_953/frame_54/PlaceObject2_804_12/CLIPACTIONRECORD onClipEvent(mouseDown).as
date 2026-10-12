onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.pistolsilencerbuy == 1)
      {
         if(_root.uspsil == false)
         {
            _root.uspsil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.uspsil == true)
         {
            _root.uspsil = false;
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
