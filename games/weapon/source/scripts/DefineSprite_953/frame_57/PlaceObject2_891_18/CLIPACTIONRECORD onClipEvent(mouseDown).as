onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.reflexbuy == 1)
      {
         if(_root.umpsight !== 1)
         {
            _root.umpsight = 1;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.umpsight == 1)
         {
            _root.umpsight = 0;
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
