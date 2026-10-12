onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.reflexbuy == 1)
      {
         if(_root.aksight !== 4)
         {
            _root.aksight = 4;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.aksight == 4)
         {
            _root.aksight = 0;
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
