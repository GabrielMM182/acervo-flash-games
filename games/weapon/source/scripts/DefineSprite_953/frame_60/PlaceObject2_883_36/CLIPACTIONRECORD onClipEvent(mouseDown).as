onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.m4stockbuy == 1)
      {
         if(_root.m4stock == false)
         {
            _root.m4stock = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m4stock == true)
         {
            _root.m4stock = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.m4stockbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storem4stock");
      }
   }
}
