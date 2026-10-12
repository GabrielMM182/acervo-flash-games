if(_root.m4sil == false)
{
   m4shot = new Sound();
   m4shot.attachSound("m4fire");
   m4shot.start();
}
else
{
   m4silence = new Sound();
   m4silence.attachSound("m4sil");
   m4silence.start();
}
