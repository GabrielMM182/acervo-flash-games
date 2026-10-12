onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.tmphibuy == 1)
      {
         if(_root.tmphi == false)
         {
            _root.tmphi = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.tmphi == true)
         {
            _root.tmphi = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.tmphibuy == 0)
      {
         _root.loadout.store.gotoAndStop("storetmphi");
      }
   }
}
