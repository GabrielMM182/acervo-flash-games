on(press){
   pressed = true;
   with(_parent)
   {
      if(clipHolder._currentframe < clipHolder._totalframes)
      {
         clipHolder.gotoAndStop(clipHolder._currentframe + 1);
      }
   }
   pressing = true;
   time = getTimer();
}
