onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.riflesilencerbuy == 1)
      {
         if(_root.g36sil == false)
         {
            _root.g36sil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.g36sil == true)
         {
            _root.g36sil = false;
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
