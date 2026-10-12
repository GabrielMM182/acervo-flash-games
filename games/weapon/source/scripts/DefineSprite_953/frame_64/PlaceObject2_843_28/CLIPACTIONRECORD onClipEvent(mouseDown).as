onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.slingbuy == 1)
      {
         if(_root.m14sling == false)
         {
            _root.m14sling = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m14sling == true)
         {
            _root.m14sling = false;
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
