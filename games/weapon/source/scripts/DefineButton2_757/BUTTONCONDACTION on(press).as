on(press){
   if(_root.credits < 2000)
   {
      _root.messages.gotoAndStop(2);
   }
   else if(_root.credits >= 2000 && _root.deltaon == true)
   {
      _root.messages.gotoAndStop(9);
   }
   else if(_root.credits >= 2000 && _root.deltaon == false)
   {
      _root.deltaon = true;
      _root.deltahealth = 25;
      _root.credits -= 2000;
      _root.creditflash.gotoAndPlay(2);
      gotoAndStop(1);
   }
}
