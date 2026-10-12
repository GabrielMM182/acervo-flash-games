onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.slingbuy == 1)
      {
         if(_root.scarsling == false)
         {
            _root.scarsling = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.scarsling == true)
         {
            _root.scarsling = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.slingbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storesling");
      }
   }
}
