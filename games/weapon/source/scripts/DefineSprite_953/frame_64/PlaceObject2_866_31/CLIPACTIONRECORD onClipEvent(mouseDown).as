onClipEvent(mouseDown){
   if(thisover == true)
   {
      if(_root.m14socombuy == 1)
      {
         if(_root.m14socom == false)
         {
            _root.m14socom = true;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
         else if(_root.m14socom == true)
         {
            _root.m14socom = false;
            equip = new Sound();
            equip.attachSound("equip");
            equip.start();
         }
      }
      else if(_root.m14socombuy == 0)
      {
         _root.loadout.store.gotoAndStop("storem14socom");
      }
   }
}
