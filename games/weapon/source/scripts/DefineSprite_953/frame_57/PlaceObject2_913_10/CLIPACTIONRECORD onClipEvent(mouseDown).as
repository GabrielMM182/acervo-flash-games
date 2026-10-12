onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.acogbuy == 1)
      {
         if(_root.umpsight !== 4)
         {
            _root.umpsight = 4;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.umpsight == 4)
         {
            _root.umpsight = 0;
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
