onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.m4barrelbuy == 1)
      {
         if(_root.m4barrel == false)
         {
            _root.m4barrel = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m4barrel == true)
         {
            _root.m4barrel = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.m4barrelbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storem4barrel");
      }
   }
}
