onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.aimpointbuy == 1)
      {
         if(_root.m14sight !== 3)
         {
            _root.m14sight = 3;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m14sight == 3)
         {
            _root.m14sight = 0;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.aimpointbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeaimpoint");
      }
   }
}
