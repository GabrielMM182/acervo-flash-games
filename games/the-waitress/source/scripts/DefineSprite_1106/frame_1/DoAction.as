if(_root.Score == 0)
{
   _root.gotoAndPlay("MainMenu");
}
UserScore = _root.Score;
Selection.setFocus("UserName");
_root.Score = 0;
stop();
