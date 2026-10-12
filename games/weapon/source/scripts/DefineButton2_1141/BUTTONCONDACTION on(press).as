on(press){
   if(_root.secondary == "empty" && _root.primary == "empty")
   {
      _root.messages.gotoAndStop(7);
   }
   else if(_root.missionselected == "empty")
   {
      _root.messages.gotoAndStop(8);
   }
   else if(_root.messages._currentframe == 1)
   {
      _root.gotoAndStop(_root.missionselected);
   }
}
