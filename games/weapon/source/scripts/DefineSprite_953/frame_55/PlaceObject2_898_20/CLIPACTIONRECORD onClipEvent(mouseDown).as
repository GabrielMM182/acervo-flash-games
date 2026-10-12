onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.eotechbuy == 1)
      {
         if(_root.tmpsight !== 1)
         {
            _root.tmpsight = 1;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.tmpsight == 1)
         {
            _root.tmpsight = 0;
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
