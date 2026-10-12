onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.pistolsilencerbuy == 1)
      {
         if(_root.kimbersil == false)
         {
            _root.kimbersil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.kimbersil == true)
         {
            _root.kimbersil = false;
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
