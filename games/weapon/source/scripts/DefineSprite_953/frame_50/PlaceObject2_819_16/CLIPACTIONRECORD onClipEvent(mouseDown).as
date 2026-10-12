onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.glockhibuy == 1)
      {
         if(_root.glockhi == false)
         {
            _root.glockhi = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.glockhi == true)
         {
            _root.glockhi = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.glockhibuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeglockhi");
      }
   }
}
