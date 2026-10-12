onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.scarbarrelbuy == 1)
      {
         if(_root.scarbarrel == false)
         {
            _root.scarbarrel = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.scarbarrel == true)
         {
            _root.scarbarrel = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.l85barrelbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storescarbarrel");
      }
   }
}
