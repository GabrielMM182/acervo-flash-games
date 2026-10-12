onClipEvent(load){
   if(_root.primary == "empty")
   {
      this.gotoAndStop(_root.secondary);
   }
   else
   {
      this.gotoAndStop(_root.primary);
   }
   _X = 0;
   _Y = 0;
}
