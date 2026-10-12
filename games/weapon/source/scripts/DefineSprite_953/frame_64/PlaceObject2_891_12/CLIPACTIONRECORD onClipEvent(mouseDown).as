onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.reflexbuy == 1)
      {
         if(_root.m14sight !== 4)
         {
            _root.m14sight = 4;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m14sight == 4)
         {
            _root.m14sight = 0;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.reflexbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storereflex");
      }
   }
}
