onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.eotechbuy == 1)
      {
         if(_root.l85sight !== 1)
         {
            _root.l85sight = 1;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.l85sight == 1)
         {
            _root.l85sight = 0;
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
