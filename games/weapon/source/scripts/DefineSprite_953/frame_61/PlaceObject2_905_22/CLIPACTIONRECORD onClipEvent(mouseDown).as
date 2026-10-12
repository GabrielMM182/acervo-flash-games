onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.aimpointbuy == 1)
      {
         if(_root.l85sight !== 2)
         {
            _root.l85sight = 2;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.l85sight == 2)
         {
            _root.l85sight = 0;
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
