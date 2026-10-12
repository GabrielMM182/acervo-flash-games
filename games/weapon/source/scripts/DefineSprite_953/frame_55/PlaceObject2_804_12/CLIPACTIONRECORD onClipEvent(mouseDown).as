onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.riflesilencerbuy == 1)
      {
         if(_root.tmpsil == false)
         {
            _root.tmpsil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.tmpsil == true)
         {
            _root.tmpsil = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.riflesilencerbuy == 0)
      {
         _root.loadout.store.gotoAndStop("storeriflesil");
      }
   }
}
