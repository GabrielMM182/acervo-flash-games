onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glockslidebuy == 1)
      {
         if(_root.glock18 == false)
         {
            _root.glock18 = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.glock18 == true)
         {
            _root.glock18 = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.glockslidebuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeglockslide");
      }
   }
}
