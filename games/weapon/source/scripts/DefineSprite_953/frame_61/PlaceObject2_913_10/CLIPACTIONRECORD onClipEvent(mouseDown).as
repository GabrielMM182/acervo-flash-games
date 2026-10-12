onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.acogbuy == 1)
      {
         if(_root.l85sight !== 3)
         {
            _root.l85sight = 3;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.l85sight == 3)
         {
            _root.l85sight = 0;
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
