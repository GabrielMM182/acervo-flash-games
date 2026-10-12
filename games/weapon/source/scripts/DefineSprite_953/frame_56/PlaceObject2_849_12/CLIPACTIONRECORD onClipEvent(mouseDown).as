onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.mp5sdbuy == 1)
      {
         if(_root.mp5grip !== 2)
         {
            _root.mp5grip = 2;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.mp5grip == 2)
         {
            _root.mp5grip = 0;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.mp5sdbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storemp5sd");
      }
   }
}
