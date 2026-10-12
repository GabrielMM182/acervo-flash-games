onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.acogbuy == 1)
      {
         if(_root.m4sight !== 2)
         {
            _root.m4sight = 2;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m4sight == 2)
         {
            _root.m4sight = 0;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.acogbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeacog");
      }
   }
}
