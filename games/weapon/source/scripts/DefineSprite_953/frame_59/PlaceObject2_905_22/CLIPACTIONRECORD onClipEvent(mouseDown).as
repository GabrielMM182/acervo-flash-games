onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.aimpointbuy == 1)
      {
         if(_root.aksight !== 3)
         {
            _root.aksight = 3;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.aksight == 3)
         {
            _root.aksight = 0;
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
