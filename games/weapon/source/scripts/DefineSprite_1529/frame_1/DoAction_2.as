if(_root.m14sil == false)
{
   m14shot = new Sound();
   m14shot.attachSound("m14fire");
   m14shot.start();
}
else
{
   m14silence = new Sound();
   m14silence.attachSound("g36sil");
   m14silence.start();
}
