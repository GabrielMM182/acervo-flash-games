function stopMainMusic()
{
   trace("FADING MUSIC OUT");
   _root.bgMusic.stop();
}
bgMusic = new Sound(musicAmbience);
bgMusic.attachSound("inGameMusic");
bgMusic.setVolume(10);
musicIsPlaying = true;
ambientSound = new Sound(musicAmbience);
ambientSound.attachSound("BGAmbience");
ambientSound.setVolume(10);
ambientSound.start(0,999999);
