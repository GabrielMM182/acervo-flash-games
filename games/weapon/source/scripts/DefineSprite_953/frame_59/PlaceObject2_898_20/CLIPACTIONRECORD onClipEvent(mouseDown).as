onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.eotechbuy == 1)
      {
         if(_root.aksight !== 1)
         {
            _root.aksight = 1;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.aksight == 1)
         {
            _root.aksight = 0;
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
