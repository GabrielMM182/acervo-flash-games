onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.riflesilencerbuy == 1)
      {
         if(_root.m4sil == false)
         {
            _root.m4sil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m4sil == true)
         {
            _root.m4sil = false;
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
