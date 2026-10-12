num = random(3);
if(num == 2)
{
   _root.deltahealth -= random(5);
}
_parent.ammo--;
_root.sparkOut();
_root.health -= random(5);
_root.enemyFire = new Sound();
_root.enemyFire.attachSound("enemyFire");
_root.enemyFire.start();
