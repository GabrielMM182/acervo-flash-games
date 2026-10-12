on(press){
   if(_root.secondary == "empty" && _root.primary == "empty")
   {
      _root.messages.gotoAndStop(7);
   }
   else
   {
      _root.gotoAndStop("shortrange");
   }
}
