onClipEvent(mouseDown){
   if(thisover == true)
   {
      _root.m9buy = 1;
      _root.secondary = "m9";
      _root.loadout.gotoAndStop(2);
      _root.loadout.store.gotoAndStop("m9");
      equip = new Sound();
      equip.attachSound("equip");
      equip.start();
      _root.callsign = _root.messages.callsigner.callsign;
      _root.messages.gotoAndStop(11);
   }
}
