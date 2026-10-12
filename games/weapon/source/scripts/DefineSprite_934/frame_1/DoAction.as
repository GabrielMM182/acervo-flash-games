health = _root.health;
cost = 0;
max = 1000 - _root.health;
number = Math.round(max / 2);
onEnterFrame = function()
{
   number = mySlider.number;
   if(_root.health >= 1000)
   {
      gotoAndStop(2);
   }
   else
   {
      gotoAndStop(1);
   }
   max = 1000 - _root.health;
   cost = number * Math.round(_root.wave / 4);
   health = _root.health;
   upper.mouseOver = function()
   {
      if(number <= max)
      {
         number++;
      }
   };
   downer.mouseOver = function()
   {
      if(number >= 0)
      {
         number--;
      }
   };
   buyer.onPress = function()
   {
      if(cost <= _root.credits)
      {
         _root.credits -= cost;
         _root.health += number;
         _root.creditflash.gotoAndPlay(2);
      }
      else
      {
         _root.messages.gotoAndStop(2);
      }
   };
};
