on(press){
   pressed = true;
   with(_parent)
   {
      if(clipHolder._currentframe > 1)
      {
         clipHolder.gotoAndStop(clipHolder._currentframe - 1);
      }
   }
   pressing = true;
   time = getTimer();
}
