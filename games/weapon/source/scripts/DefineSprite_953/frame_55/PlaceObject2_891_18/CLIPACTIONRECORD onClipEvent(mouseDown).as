onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.reflexbuy == 1 && _root.tmpsight !== 3)
      {
         _root.tmpsight = 3;
         equip = new Sound();
         equip.attachSound("equip");
         equip.start();
      }
      else if(_root.reflexbuy == 1 && _root.tmpsight == 3)
      {
         _root.tmpsight = 0;
         equip = new Sound();
         equip.attachSound("equip");
         equip.start();
      }
      else if(_root.reflexbuy == 0 && _root.tmpsight == 0)
      {
         _root.loadout.store.gotoAndStop("storereflex");
      }
   }
}
