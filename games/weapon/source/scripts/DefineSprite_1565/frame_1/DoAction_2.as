if(_root.mp5sil == false)
{
   mp5shot = new Sound();
   mp5shot.attachSound("mp5fire");
   mp5shot.start();
}
else
{
   mp5silence = new Sound();
   mp5silence.attachSound("mp5sil");
   mp5silence.start();
}
