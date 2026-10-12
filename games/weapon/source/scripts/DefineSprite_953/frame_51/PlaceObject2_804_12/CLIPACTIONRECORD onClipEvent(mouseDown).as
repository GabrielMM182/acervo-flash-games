onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.pistolsilencerbuy == 1)
      {
         if(_root.m9sil == false)
         {
            _root.m9sil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m9sil == true)
         {
            _root.m9sil = false;
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
