onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.eotechbuy == 1)
      {
         if(_root.g36sight !== 2)
         {
            _root.g36sight = 2;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.g36sight == 2)
         {
            _root.g36sight = 0;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.eotechbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeeotech");
      }
   }
}
