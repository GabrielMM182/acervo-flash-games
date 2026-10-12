onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.l85barrelbuy == 1)
      {
         if(_root.l85vgrip == false)
         {
            _root.l85vgrip = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.l85vgrip == true)
         {
            _root.l85vgrip = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.l85barrelbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storel85barrel");
      }
   }
}
