onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.riflesilencerbuy == 1)
      {
         if(_root.scarsil == false)
         {
            _root.scarsil = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.scarsil == true)
         {
            _root.scarsil = false;
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
