onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.slingbuy == 1)
      {
         if(_root.aksling == false)
         {
            _root.aksling = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.aksling == true)
         {
            _root.aksling = false;
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
