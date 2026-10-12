function zombieGroanSound(zombieType)
{
   playASound = random(10) + 1;
   if(playASound == 1)
   {
      zombieGroan = new Sound(stageBG);
      zombieGroan.attachSound("sound_zombie" + zombieType);
      zombieGroan.setVolume(100);
      zombieGroan.start(0,1);
   }
}
function zombieHitWallSound()
{
   zombieHitWallSnd = new Sound(stageBG);
   zombieHitWallSnd.attachSound("zombie_hitWall" + (random(2) + 1));
   zombieHitWallSnd.setVolume(50);
   zombieHitWallSnd.start(0,1);
}
function destroyBody()
{
   this.removeMovieClip;
}
function zombieAppearance(zombieRef, isArmed)
{
   randomZombieHead = random(zombieHeads) + 1;
   randomZombieTorso = random(zombieTorsos) + 1;
   randomHeadAccessory = random(zombieHeadAccessories) + 1;
   randomTorsoAccessory = random(zombieTorsoAccessories) + 1;
   randomTorsoColour = torsoColours[random(torsoColours.length)];
   _root[zombieRef].dummyHead.attachMovie("zombieHead" + randomZombieHead,"head",x);
   _root[zombieRef].dummyTorso.attachMovie("zombieTorso" + randomZombieTorso,"torso",x);
   _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
   _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
   if(isArmed)
   {
      _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("armedWeapon" + random(numberZombieWeapons));
   }
   _root[zombieRef].dummyTorso.torso.play();
   _root[zombieRef].dummyHead.head.accessories.gotoAndStop(randomHeadAccessory);
   _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop(randomTorsoAccessory);
   _root[zombieRef].dummyTorso.torso.torso.gotoAndStop(randomTorsoColour);
   _root[zombieRef].dummyFrontUpperArm.upperArm.gotoAndStop(randomTorsoColour);
   _root[zombieRef].dummyFrontLowerArm.lowerArm.gotoAndStop(randomTorsoColour);
   _root[zombieRef].dummyBackUpperArm.upperArm.gotoAndStop(randomTorsoColour);
   _root[zombieRef].dummyBackLowerArm.lowerArm.gotoAndStop(randomTorsoColour);
   randomLegColour = legColours[random(legColours.length)];
   _root[zombieRef].dummyFrontUpperLeg.upperLeg.gotoAndStop(randomLegColour);
   _root[zombieRef].dummyFrontLowerLeg.lowerLeg.gotoAndStop(randomLegColour);
   _root[zombieRef].dummyBackUpperLeg.upperLeg.gotoAndStop(randomLegColour);
   _root[zombieRef].dummyBackLowerLeg.lowerLeg.gotoAndStop(randomLegColour);
   _root[zombieRef].cacheAsBitmap = true;
   if(currentZombieType.name == "zombieSlow")
   {
      _root[zombieRef].gotoAndPlay(random(20) + 45);
   }
   if(currentZombieType.name == "zombieFast")
   {
      _root[zombieRef].gotoAndPlay(random(20) + 1);
   }
   if(currentZombieType.name == "zombieSprint")
   {
      _root[zombieRef].gotoAndPlay(random(10) + 80);
   }
}
function zombieAppearanceCustom(zombieRef, zombieType, zombieArmed)
{
   randomZombieHead = random(zombieHeads) + 1;
   randomZombieTorso = random(zombieTorsos) + 1;
   randomHeadAccessory = random(zombieHeadAccessories) + 1;
   randomTorsoAccessory = random(zombieTorsoAccessories) + 1;
   randomTorsoColour = torsoColours[random(torsoColours.length)];
   randomLegColour = legColours[random(legColours.length)];
   if(zombieType == "zombieFatManSprint")
   {
      zombieType = "zombieFatMan";
   }
   if(zombieType == "zombieFatWomanSprint")
   {
      zombieType = "zombieFatWoman";
   }
   if(zombieType == "zombieSoldierSprint")
   {
      zombieType = "zombieSoldier";
   }
   if(zombieType == "zombieSWATSprint")
   {
      zombieType = "zombieSWAT";
   }
   switch(zombieType)
   {
      case "zombieSoldier":
         _root[zombieRef].dummyHead.attachMovie("zombieHead1","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("armyHelmet");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("armyVest");
         _root[zombieRef].dummyBackHand.backHand.accessories.gotoAndStop("armyM4");
         _root[zombieRef].dummyTorso.torso.torso.gotoAndStop("khaki");
         _root[zombieRef].dummyFrontUpperArm.upperArm.gotoAndStop("khaki");
         _root[zombieRef].dummyFrontLowerArm.lowerArm.gotoAndStop("khaki");
         _root[zombieRef].dummyBackUpperArm.upperArm.gotoAndStop("khaki");
         _root[zombieRef].dummyBackLowerArm.lowerArm.gotoAndStop("khaki");
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.gotoAndStop("khaki");
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.gotoAndStop("khaki");
         _root[zombieRef].dummyBackUpperLeg.upperLeg.gotoAndStop("khaki");
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.gotoAndStop("khaki");
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieSWAT":
         _root[zombieRef].dummyHead.attachMovie("zombieHead1","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("SWAT");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("SWAT");
         _root[zombieRef].dummyTorso.torso.torso.gotoAndStop("denim");
         _root[zombieRef].dummyFrontUpperArm.upperArm.gotoAndStop("denim");
         _root[zombieRef].dummyFrontLowerArm.lowerArm.gotoAndStop("denim");
         _root[zombieRef].dummyBackUpperArm.upperArm.gotoAndStop("denim");
         _root[zombieRef].dummyBackLowerArm.lowerArm.gotoAndStop("denim");
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.gotoAndStop("denim");
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.gotoAndStop("denim");
         _root[zombieRef].dummyBackUpperLeg.upperLeg.gotoAndStop("denim");
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.gotoAndStop("denim");
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieFatCop":
         _root[zombieRef].dummyHead.attachMovie("zombieHead1","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("copFat" + (random(3) + 1));
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("copFat");
         _root[zombieRef].dummyBackHand.backHand.accessories.gotoAndStop("copNightStick");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(6737151,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(6737151,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.gotoAndStop("skin");
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(6737151,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.gotoAndStop("skin");
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.gotoAndStop("nearBlack");
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.gotoAndStop("nearBlack");
         _root[zombieRef].dummyBackUpperLeg.upperLeg.gotoAndStop("nearBlack");
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.gotoAndStop("nearBlack");
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieDropRevolver":
         _root[zombieRef].dummyHead.attachMovie("zombieHead1","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("copFat" + (random(3) + 1));
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("copFat");
         _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("copRevolver");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(6737151,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(6737151,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(16771797,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(6737151,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(16771797,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(7208,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(7208,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(7208,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(7208,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieClown":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso2","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("clown");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("clown");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(6710988,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(39168,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(39168,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(6710988,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(6710988,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(13382400,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(13382400,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(13260,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(13260,0);
         _root[zombieRef].dummyFrontFoot.foot.colorTo(10027008,0);
         _root[zombieRef].dummyBackFoot.foot.colorTo(10027008,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieMechanic":
         _root[zombieRef].dummyHead.attachMovie("zombieHead2","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop(randomHeadAccessory);
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("mechanic");
         if(isArmed)
         {
            _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("armedWeapon" + random(numberZombieWeapons));
         }
         _root[zombieRef].dummyTorso.torso.torso.colorTo(3691610,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(3691610,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(3691610,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(3691610,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(3691610,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(3691610,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(3691610,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(3691610,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(3691610,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombiePriest":
         _root[zombieRef].dummyHead.attachMovie("zombieHead1","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso2","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("priest");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("priest");
         _root[zombieRef].dummyBackHand.backHand.accessories.gotoAndStop("bible");
         _root[zombieRef].dummyTorso.torso.torso.gotoAndStop("nearBlack");
         _root[zombieRef].dummyFrontUpperArm.upperArm.gotoAndStop("nearBlack");
         _root[zombieRef].dummyFrontLowerArm.lowerArm.gotoAndStop("nearBlack");
         _root[zombieRef].dummyBackUpperArm.upperArm.gotoAndStop("nearBlack");
         _root[zombieRef].dummyBackLowerArm.lowerArm.gotoAndStop("nearBlack");
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.gotoAndStop("nearBlack");
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.gotoAndStop("nearBlack");
         _root[zombieRef].dummyBackUpperLeg.upperLeg.gotoAndStop("nearBlack");
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.gotoAndStop("nearBlack");
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieNewsReporter":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("newsReporter");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("newsReporter");
         _root[zombieRef].dummyBackHand.backHand.accessories.gotoAndStop("microphone");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(13412704,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(13412704,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(13412704,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(13412704,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(13412704,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(3355443,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(3355443,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(3355443,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(3355443,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieNewsCameraman":
         _root[zombieRef].dummyHead.attachMovie("zombieHead1","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("newsCameraman");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("newsCameraman");
         _root[zombieRef].dummyBackHand.backHand.accessories.gotoAndStop("newsCamera");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(10040115,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(10040115,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(16771797,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(10040115,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(16771797,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(3355443,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(3355443,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(3355443,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(3355443,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieFatWoman":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("fatWoman" + (random(5) + 1));
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("fatWoman" + (random(5) + 1));
         if(isArmed)
         {
            _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("armedWeapon" + random(numberZombieWeapons));
         }
         _root[zombieRef].dummyTorso.torso.torso.gotoAndStop("skin");
         _root[zombieRef].dummyFrontUpperArm.upperArm.gotoAndStop("skin");
         _root[zombieRef].dummyFrontLowerArm.lowerArm.gotoAndStop("skin");
         _root[zombieRef].dummyBackUpperArm.upperArm.gotoAndStop("skin");
         _root[zombieRef].dummyBackLowerArm.lowerArm.gotoAndStop("skin");
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.gotoAndStop("skin");
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.gotoAndStop("skin");
         _root[zombieRef].dummyBackUpperLeg.upperLeg.gotoAndStop("skin");
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.gotoAndStop("skin");
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieFatMan":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("fatMan" + (random(4) + 1));
         if(isArmed)
         {
            _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("armedWeapon" + random(numberZombieWeapons));
         }
         zombieRandomClothesSet = "" + (random(4) + 1);
         switch(zombieRandomClothesSet)
         {
            case "1":
               _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("fatMan1");
               _root[zombieRef].dummyTorso.torso.torso.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(15260631,0);
               _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(15260631,0);
               _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(15260631,0);
               _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(6697728,0);
               _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(15260631,0);
               _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(6697728,0);
               _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(15260631,0);
               break;
            case "2":
               _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("fatMan2");
               _root[zombieRef].dummyTorso.torso.torso.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(15260631,0);
               _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(15260631,0);
               _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(15260631,0);
               _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(13158,0);
               _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(13158,0);
               _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(13158,0);
               _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(13158,0);
               break;
            case "3":
               _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("fatMan3");
               _root[zombieRef].dummyTorso.torso.torso.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(5266279,0);
               _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(5266279,0);
               _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(5266279,0);
               _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(5266279,0);
               _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(1510144,0);
               _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(1510144,0);
               _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(1510144,0);
               _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(1510144,0);
               break;
            case "4":
               _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("fatMan4");
               _root[zombieRef].dummyTorso.torso.torso.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(5780532,0);
               _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(5780532,0);
               _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(5780532,0);
               _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(5780532,0);
               _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(4993566,0);
               _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(4993566,0);
               _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(4993566,0);
               _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(4993566,0);
         }
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(6697728,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(15260631,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(6697728,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(15260631,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombiePrisoner":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop(randomHeadAccessory);
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("prisoner");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(16750848,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(16750848,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(16750848,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(16750848,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(16750848,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(16750848,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(16750848,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(16750848,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(16750848,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieDropShotgun":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("biker");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("biker");
         _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("bikerShotgun");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(6737151,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(15260631,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(15260631,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(15260631,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(15260631,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(1313280,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(1313280,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(1313280,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(1313280,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieDecayed":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("decayed" + (random(4) + 1));
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("decayed" + (random(4) + 1));
         if(isArmed)
         {
            _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("armedWeapon" + random(numberZombieWeapons));
         }
         _root[zombieRef].dummyFrontHand.frontHand.handskin.colorTo(8223810,0);
         _root[zombieRef].dummyBackHand.backHand.handskin.colorTo(8223810,0);
         _root[zombieRef].dummyTorso.torso.torso.gotoAndStop(randomTorsoColour);
         _root[zombieRef].dummyFrontUpperArm.upperArm.gotoAndStop(randomTorsoColour);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.gotoAndStop(randomTorsoColour);
         _root[zombieRef].dummyBackUpperArm.upperArm.gotoAndStop(randomTorsoColour);
         _root[zombieRef].dummyBackLowerArm.lowerArm.gotoAndStop(randomTorsoColour);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.gotoAndStop(randomLegColour);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.gotoAndStop(randomLegColour);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.gotoAndStop(randomLegColour);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.gotoAndStop(randomLegColour);
         _root[zombieRef].cacheAsBitmap = true;
   }
   _root[zombieRef].cacheAsBitmap = false;
   if(zombieArmed)
   {
      _root[zombieRef].dummyFrontHand.frontHand.accessories.gotoAndStop("armedWeapon" + random(numberZombieWeapons));
   }
   switch(currentZombieType.walkAnimation)
   {
      case "slow":
         _root[zombieRef].gotoAndPlay(random(20) + 45);
         return;
      case "fast":
         _root[zombieRef].gotoAndPlay(random(20) + 1);
         return;
      case "sprint":
         _root[zombieRef].gotoAndPlay(random(10) + 80);
         return;
      default:
         return;
   }
}
var numberZombieWeapons = 5;
var zombieDamageMultiplier = 1.5;
zombieSlow = new Object();
zombieSlow.speed = 1.3;
zombieSlow.health = 50;
zombieSlow.damage = 3;
zombieSlow.threat = 0.5;
zombieSlow.common = true;
zombieSlow.name = "zombieSlow";
zombieFast = new Object();
zombieFast.speed = 3;
zombieFast.health = 40;
zombieFast.damage = 2;
zombieFast.threat = 0.75;
zombieFast.common = true;
zombieFast.name = "zombieFast";
zombieSprint = new Object();
zombieSprint.speed = 13;
zombieSprint.health = 40;
zombieSprint.damage = 2;
zombieSprint.threat = 1;
zombieSprint.common = true;
zombieSprint.name = "zombieSprint";
zombieDog = new Object();
zombieDog.speed = 13.5;
zombieDog.health = 30;
zombieDog.damage = 1.5;
zombieDog.threat = 0.25;
zombieDog.common = true;
zombieDog.name = "zombieDog";
zombieSoldier = new Object();
zombieSoldier.speed = 1.3;
zombieSoldier.health = 40;
zombieSoldier.damage = 2;
zombieSoldier.threat = 1.5;
zombieSoldier.common = false;
zombieSoldier.name = "zombieSoldier";
zombieSoldier.walkAnimation = "fast";
zombieSoldierSprint = new Object();
zombieSoldierSprint.speed = 13;
zombieSoldierSprint.health = 40;
zombieSoldierSprint.damage = 2;
zombieSoldierSprint.threat = 2;
zombieSoldierSprint.common = false;
zombieSoldierSprint.name = "zombieSoldierSprint";
zombieSoldierSprint.walkAnimation = "sprint";
zombieSWAT = new Object();
zombieSWAT.speed = 1.3;
zombieSWAT.health = 40;
zombieSWAT.damage = 2;
zombieSWAT.threat = 1.25;
zombieSWAT.common = false;
zombieSWAT.name = "zombieSWAT";
zombieSWAT.walkAnimation = "fast";
zombieSWATSprint = new Object();
zombieSWATSprint.speed = 13;
zombieSWATSprint.health = 40;
zombieSWATSprint.damage = 2;
zombieSWATSprint.threat = 2;
zombieSWATSprint.common = false;
zombieSWATSprint.name = "zombieSWATSprint";
zombieSWATSprint.walkAnimation = "sprint";
zombieFatCop = new Object();
zombieFatCop.speed = 1.3;
zombieFatCop.health = 65;
zombieFatCop.damage = 2;
zombieFatCop.threat = 1;
zombieFatCop.common = false;
zombieFatCop.name = "zombieFatCop";
zombieFatCop.walkAnimation = "slow";
zombieDropRevolver = new Object();
zombieDropRevolver.speed = 1.3;
zombieDropRevolver.health = 65;
zombieDropRevolver.damage = 2;
zombieDropRevolver.threat = 1;
zombieDropRevolver.common = false;
zombieDropRevolver.name = "zombieDropRevolver";
zombieDropRevolver.walkAnimation = "slow";
zombieDropShotgun = new Object();
zombieDropShotgun.speed = 1.3;
zombieDropShotgun.health = 65;
zombieDropShotgun.damage = 2;
zombieDropShotgun.threat = 1;
zombieDropShotgun.common = false;
zombieDropShotgun.name = "zombieDropShotgun";
zombieDropShotgun.walkAnimation = "slow";
zombieFatWoman = new Object();
zombieFatWoman.speed = 1;
zombieFatWoman.health = 65;
zombieFatWoman.damage = 3;
zombieFatWoman.threat = 1.25;
zombieFatWoman.common = false;
zombieFatWoman.name = "zombieFatWoman";
zombieFatWoman.walkAnimation = "slow";
zombieFatWomanSprint = new Object();
zombieFatWomanSprint.speed = 13;
zombieFatWomanSprint.health = 65;
zombieFatWomanSprint.damage = 3;
zombieFatWomanSprint.threat = 1.5;
zombieFatWomanSprint.common = false;
zombieFatWomanSprint.name = "zombieFatWomanSprint";
zombieFatWomanSprint.walkAnimation = "sprint";
zombieFatManSprint = new Object();
zombieFatManSprint.speed = 10;
zombieFatManSprint.health = 70;
zombieFatManSprint.damage = 3;
zombieFatManSprint.threat = 1.75;
zombieFatManSprint.common = false;
zombieFatManSprint.name = "zombieFatManSprint";
zombieFatManSprint.walkAnimation = "sprint";
zombieFatMan = new Object();
zombieFatMan.speed = 1.3;
zombieFatMan.health = 70;
zombieFatMan.damage = 3;
zombieFatMan.threat = 1.5;
zombieFatMan.common = false;
zombieFatMan.name = "zombieFatMan";
zombieFatMan.walkAnimation = "fast";
zombieClown = new Object();
zombieClown.speed = 13;
zombieClown.health = 40;
zombieClown.damage = 2;
zombieClown.threat = 1;
zombieClown.common = false;
zombieClown.name = "zombieClown";
zombieClown.walkAnimation = "sprint";
zombieMechanic = new Object();
zombieMechanic.speed = 3;
zombieMechanic.health = 40;
zombieMechanic.damage = 2;
zombieMechanic.threat = 1;
zombieMechanic.common = false;
zombieMechanic.name = "zombieMechanic";
zombieMechanic.walkAnimation = "fast";
zombiePriest = new Object();
zombiePriest.speed = 3;
zombiePriest.health = 40;
zombiePriest.damage = 2;
zombiePriest.threat = 1;
zombiePriest.common = false;
zombiePriest.name = "zombiePriest";
zombiePriest.walkAnimation = "fast";
zombieNewsReporter = new Object();
zombieNewsReporter.speed = 3;
zombieNewsReporter.health = 40;
zombieNewsReporter.damage = 2;
zombieNewsReporter.threat = 1;
zombieNewsReporter.common = false;
zombieNewsReporter.name = "zombieNewsReporter";
zombieNewsReporter.walkAnimation = "fast";
zombieNewsCameraman = new Object();
zombieNewsCameraman.speed = 1.3;
zombieNewsCameraman.health = 40;
zombieNewsCameraman.damage = 2;
zombieNewsCameraman.threat = 1;
zombieNewsCameraman.common = false;
zombieNewsCameraman.name = "zombieNewsCameraman";
zombieNewsCameraman.walkAnimation = "slow";
zombiePrisoner = new Object();
zombiePrisoner.speed = 3;
zombiePrisoner.health = 40;
zombiePrisoner.damage = 2;
zombiePrisoner.threat = 1;
zombiePrisoner.common = false;
zombiePrisoner.name = "zombiePrisoner";
zombiePrisoner.walkAnimation = "fast";
zombieCrawler = new Object();
zombieCrawler.speed = 1.2;
zombieCrawler.health = 60;
zombieCrawler.damage = 2;
zombieCrawler.threat = 1.5;
zombieCrawler.common = false;
zombieCrawler.name = "zombieCrawler";
zombieCrawler.walkAnimation = "crawl";
zombieDecayed = new Object();
zombieDecayed.speed = 1.2;
zombieDecayed.health = 80;
zombieDecayed.damage = 1;
zombieDecayed.threat = 1.5;
zombieDecayed.common = true;
zombieDecayed.name = "zombieDecayed";
zombieDecayed.walkAnimation = "slow";
zombieEater = new Object();
zombieEater.speed = 3;
zombieEater.health = 50;
zombieEater.damage = 2;
zombieEater.threat = 1.25;
zombieEater.common = false;
zombieEater.name = "zombieEater";
zombieEater.walkAnimation = "slow";
allZombies = new Array(zombieSlow,zombieFast,zombieDog,zombieSprint,zombieSoldier,zombieFatCop,zombieClown,zombieMechanic,zombiePriest,zombieNewsReporter,zombieNewsCameraman,zombieFatWoman,zombieFatWomanSprint,zombieFatMan,zombieFatManSprint,zombiePrisoner,zombieDropRevolver,zombieDropShotgun,zombieCrawler,zombieEater,zombieDecayed,zombieArmedFast,zombieArmedSprint,zombieArmedSlow);
commonZombies = new Array(zombieSlow,zombieFast,zombieSprint,zombieDecayed,zombieSprint);
semiRareZombies = new Array(zombieDog,zombieFatWoman,zombieFatWomanSprint,zombieFatMan,zombieFatManSprint);
rareZombies = new Array(zombieSprint,zombieFatCop,zombieMechanic,zombiePriest,zombieNewsReporter,zombieNewsCameraman,zombiePrisoner,zombieDropRevolver,zombieDropShotgun);
veryRareZombies = new Array(zombieSoldier,zombieSoldierSprint,zombieSoldier,zombieSoldierSprint,zombieSWAT,zombieSWATSprint);
armedZombies = new Array(zombieSprint,zombieMechanic,zombieFatMan,zombieSlow,zombieFast,zombieFatManSprint,zombieFatWomanSprint,zombieFatWoman,zombieDecayed,zombieSoldier,zombieSWAT);
zombieHeads = 3;
zombieTorsos = 4;
zombieHeadAccessories = 25;
zombieTorsoAccessories = 15;
torsoColours = new Array("khaki","rose","darkGrey","tan","lightGrey","darkKhaki","denim","plum","camel","nearBlack","nearWhite","darkMaroon","darkPurple","gold");
legColours = new Array("darkGrey","darkBlue","darkKhaki","nearBlack","brown","darkBrown","lightGrey");
v;
