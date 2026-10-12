onClipEvent(load){
   this.titles = "Wave " + _root.wave + " completed";
   this.moneys = "Money earned : " + _root.mcredits;
   this.enemys = "Total kills : " + _root.mkills;
   _root.credits += _root.mcredits;
   _root.wave++;
   if(_root._root.delaynum1 > 50)
   {
      _root.delaynum1 -= 10;
   }
   _root.enemys1++;
   _root.enemy2wait++;
   _root.enemy3wait++;
   _root.enemy4wait++;
   if(_root.enemy2wait == 3)
   {
      if(_root._root.delaynum2 > 50)
      {
         _root.delaynum2 -= 10;
      }
      _root.enemys2++;
      _root.enemys1--;
      _root.enemy2wait = 0;
   }
   if(_root.enemy3wait == 6)
   {
      if(_root._root.delaynum3 > 50)
      {
         _root.delaynum3 -= 15;
      }
      _root.enemys3++;
      _root.enemys1 -= 1;
      _root.enemy3wait = 0;
   }
   if(_root.enemy4wait == 10)
   {
      if(_root._root.delaynum4 > 50)
      {
         _root.delaynum4 -= 20;
      }
      _root.enemys4++;
      _root.enemys1 -= 2;
      _root.enemy4wait = 0;
   }
}
