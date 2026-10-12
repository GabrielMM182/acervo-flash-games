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
function zombieAppearance(zombieRef)
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
   _root[zombieRef].dummyTorso.torso.play();
   _root[zombieRef].dummyHead.head.accessories.gotoAndStop(randomHeadAccessory);
   _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop(randomTorsoAccessory);
   _root[zombieRef].dummyTorso.torso.torso.colorTo(randomTorsoColour,0);
   _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(randomTorsoColour,0);
   _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(randomTorsoColour,0);
   _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(randomTorsoColour,0);
   _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(randomTorsoColour,0);
   randomLegColour = legColours[random(legColours.length)];
   _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(randomLegColour,0);
   _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(randomLegColour,0);
   _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(randomLegColour,0);
   _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(randomLegColour,0);
   _root[zombieRef].cacheAsBitmap = true;
   if(_root[currentZombieType].name == "zombieSlow")
   {
      _root[zombieRef].gotoAndPlay(random(20) + 45);
   }
   if(_root[currentZombieType].name == "zombieFast")
   {
      _root[zombieRef].gotoAndPlay(random(20) + 1);
   }
   if(_root[currentZombieType].name == "zombieSprint")
   {
      _root[zombieRef].gotoAndPlay(random(10) + 80);
   }
}
function zombieAppearanceCustom(zombieRef, zombieType)
{
   randomZombieHead = random(zombieHeads) + 1;
   randomZombieTorso = random(zombieTorsos) + 1;
   randomHeadAccessory = random(zombieHeadAccessories) + 1;
   randomTorsoAccessory = random(zombieTorsoAccessories) + 1;
   if(zombieType == "zombieFatManSprint")
   {
      zombieType = "zombieFatMan";
   }
   if(zombieType == "zombieFatWomanSprint")
   {
      zombieType = "zombieFatWoman";
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
         _root[zombieRef].dummyTorso.torso.torso.colorTo(8485151,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(8485151,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(8485151,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(8485151,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(8485151,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(5329152,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(5329152,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(5329152,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(5329152,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieSWAT":
         _root[zombieRef].dummyHead.attachMovie("zombieHead1","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("SWAT");
         _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("SWAT");
         _root[zombieRef].dummyTorso.torso.torso.colorTo(1783122,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(1783122,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(1783122,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(1783122,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(1783122,0);
         _root[zombieRef].dummyBackHand.backHand.colorTo(1184274,0);
         _root[zombieRef].dummyFrontHand.frontHand.colorTo(1184274,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(1783122,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(1783122,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(1783122,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(1783122,0);
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
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(16771797,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(6737151,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(16771797,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(7208,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(7208,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(7208,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(7208,0);
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
         _root[zombieRef].dummyTorso.torso.torso.colorTo(1644825,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(1644825,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(1644825,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(1644825,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(1644825,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(1644825,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(1644825,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(1644825,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(1644825,0);
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
         _root[zombieRef].dummyTorso.torso.torso.colorTo(15260631,0);
         _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(15260631,0);
         _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(15260631,0);
         _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(15260631,0);
         _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(15260631,0);
         _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(15260631,0);
         _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(15260631,0);
         _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(15260631,0);
         _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(15260631,0);
         _root[zombieRef].cacheAsBitmap = true;
         break;
      case "zombieFatMan":
         _root[zombieRef].dummyHead.attachMovie("zombieHead3","head",x);
         _root[zombieRef].dummyTorso.attachMovie("zombieTorso1","torso",x);
         _root[zombieRef].dummyFrontHand.attachMovie("zombie_Hand","frontHand",x);
         _root[zombieRef].dummyBackHand.attachMovie("zombie_Hand","backHand",x);
         _root[zombieRef].dummyHead.head.accessories.gotoAndStop("fatMan" + (random(4) + 1));
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
               _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(7500362,0);
               _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(15260631,0);
               _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(7500362,0);
               _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperLeg.upperLeg.colorTo(1510144,0);
               _root[zombieRef].dummyFrontLowerLeg.lowerLeg.colorTo(1510144,0);
               _root[zombieRef].dummyBackUpperLeg.upperLeg.colorTo(1510144,0);
               _root[zombieRef].dummyBackLowerLeg.lowerLeg.colorTo(1510144,0);
               break;
            case "4":
               _root[zombieRef].dummyTorso.torso.torsoAddons.gotoAndStop("fatMan4");
               _root[zombieRef].dummyTorso.torso.torso.colorTo(15260631,0);
               _root[zombieRef].dummyFrontUpperArm.upperArm.colorTo(4868682,0);
               _root[zombieRef].dummyFrontLowerArm.lowerArm.colorTo(4868682,0);
               _root[zombieRef].dummyBackUpperArm.upperArm.colorTo(4868682,0);
               _root[zombieRef].dummyBackLowerArm.lowerArm.colorTo(4868682,0);
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
   }
   switch(_root[currentZombieType].walkAnimation)
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
zombieSlow = new Object();
zombieSlow.speed = 1.3;
zombieSlow.health = 50;
zombieSlow.damage = 3;
zombieSlow.name = "zombieSlow";
zombieFast = new Object();
zombieFast.speed = 3;
zombieFast.health = 40;
zombieFast.damage = 2;
zombieFast.name = "zombieFast";
zombieSprint = new Object();
zombieSprint.speed = 13;
zombieSprint.health = 40;
zombieSprint.damage = 2;
zombieSprint.name = "zombieSprint";
zombieDog = new Object();
zombieDog.speed = 13.5;
zombieDog.health = 30;
zombieDog.damage = 1.5;
zombieDog.name = "zombieDog";
zombieSoldier = new Object();
zombieSoldier.speed = 1.3;
zombieSoldier.health = 40;
zombieSoldier.damage = 2;
zombieSoldier.name = "zombieSoldier";
zombieSoldier.walkAnimation = "fast";
zombieSWAT = new Object();
zombieSWAT.speed = 1.3;
zombieSWAT.health = 40;
zombieSWAT.damage = 2;
zombieSWAT.name = "zombieSWAT";
zombieSWAT.walkAnimation = "fast";
zombieFatCop = new Object();
zombieFatCop.speed = 1.3;
zombieFatCop.health = 65;
zombieFatCop.damage = 2;
zombieFatCop.name = "zombieFatCop";
zombieFatCop.walkAnimation = "slow";
zombieDropRevolver = new Object();
zombieDropRevolver.speed = 1.3;
zombieDropRevolver.health = 65;
zombieDropRevolver.damage = 2;
zombieDropRevolver.name = "zombieDropRevolver";
zombieDropRevolver.walkAnimation = "slow";
zombieDropShotgun = new Object();
zombieDropShotgun.speed = 1.3;
zombieDropShotgun.health = 65;
zombieDropShotgun.damage = 2;
zombieDropShotgun.name = "zombieDropShotgun";
zombieDropShotgun.walkAnimation = "slow";
zombieFatWoman = new Object();
zombieFatWoman.speed = 1;
zombieFatWoman.health = 65;
zombieFatWoman.damage = 3;
zombieFatWoman.name = "zombieFatWoman";
zombieFatWoman.walkAnimation = "slow";
zombieFatWomanSprint = new Object();
zombieFatWomanSprint.speed = 13;
zombieFatWomanSprint.health = 65;
zombieFatWomanSprint.damage = 3;
zombieFatWomanSprint.name = "zombieFatWoman";
zombieFatWomanSprint.walkAnimation = "sprint";
zombieFatManSprint = new Object();
zombieFatManSprint.speed = 10;
zombieFatManSprint.health = 70;
zombieFatManSprint.damage = 3;
zombieFatManSprint.name = "zombieFatManSprint";
zombieFatManSprint.walkAnimation = "sprint";
zombieFatMan = new Object();
zombieFatMan.speed = 1.3;
zombieFatMan.health = 70;
zombieFatMan.damage = 3;
zombieFatMan.name = "zombieFatMan";
zombieFatMan.walkAnimation = "fast";
zombieClown = new Object();
zombieClown.speed = 13;
zombieClown.health = 40;
zombieClown.damage = 2;
zombieClown.name = "zombieClown";
zombieClown.walkAnimation = "sprint";
zombieMechanic = new Object();
zombieMechanic.speed = 3;
zombieMechanic.health = 40;
zombieMechanic.damage = 2;
zombieMechanic.name = "zombieMechanic";
zombieMechanic.walkAnimation = "fast";
zombiePriest = new Object();
zombiePriest.speed = 3;
zombiePriest.health = 40;
zombiePriest.damage = 2;
zombiePriest.name = "zombiePriest";
zombiePriest.walkAnimation = "fast";
zombieNewsReporter = new Object();
zombieNewsReporter.speed = 3;
zombieNewsReporter.health = 40;
zombieNewsReporter.damage = 2;
zombieNewsReporter.name = "zombieNewsReporter";
zombieNewsReporter.walkAnimation = "fast";
zombieNewsCameraman = new Object();
zombieNewsCameraman.speed = 1.3;
zombieNewsCameraman.health = 40;
zombieNewsCameraman.damage = 2;
zombieNewsCameraman.name = "zombieNewsCameraman";
zombieNewsCameraman.walkAnimation = "slow";
zombiePrisoner = new Object();
zombiePrisoner.speed = 3;
zombiePrisoner.health = 40;
zombiePrisoner.damage = 2;
zombiePrisoner.name = "zombiePrisoner";
zombiePrisoner.walkAnimation = "fast";
allZombies = new Array("zombieSlow","zombieFast","zombieDog","zombieSprint","zombieSoldier","zombieFatCop","zombieClown","zombieMechanic","zombiePriest","zombieNewsReporter","zombieNewsCameraman","zombieFatWoman","zombieFatWomanSprint","zombieFatMan","zombieFatManSprint","zombiePrisoner","zombieDropRevolver","zombieDropShotgun");
zombieHeads = 3;
zombieTorsos = 3;
zombieHeadAccessories = 15;
zombieTorsoAccessories = 15;
torsoColours = new Array("0x53552F","0x993333","0x333333","0x996600","0x888888","0x4E462C","0x3A4958","0x3E373A","0xB2987F","0x222222","0xcccccc","0x451616","0x571542","0x6A6846");
legColours = new Array("0x333333","0x182746","0x333300","0x111111");
v;
