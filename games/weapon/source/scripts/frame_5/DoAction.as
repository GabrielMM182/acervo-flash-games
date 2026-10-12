function cursormain()
{
   _root.cursor1._x = _xmouse;
   _root.cursor1._y = _ymouse;
   updateAfterEvent();
}
_root.bg.keeper.callsigner = _root.callsign;
_root.bg.keeper.wavenum = _root.wave * 1000;
_root.bg.keeper.creditnum = _root.credits * 5;
_root.bg.keeper.line1 = "Wave number : " + _root.wave + " x 1000 = " + this.wavenum;
_root.bg.keeper.line2 = "Credits remaining : " + _root.credits + " x 5 = " + _root.bg.keeper.creditnum;
_root.bg.keeper.line3 = "Total score : " + (_root.bg.keeper.wavenum + _root.bg.keeper.creditnum);
_root.hiscorenew = _root.bg.keeper.wavenum + _root.bg.keeper.creditnum;
_root.bg.keeper.hinew = "This game\'s Hi-Score : " + _root.hiscorenew;
if(_root.hiscorenew > _root.hiscore)
{
   _root.hiscore = _root.hiscorenew;
}
_root.bg.keeper.highest = "Highest score : " + _root.hiscore;
so.data.callsign = _root.callsign;
so.data.hiscore = _root.hiscore;
so.data.saved = true;
so.flush();
