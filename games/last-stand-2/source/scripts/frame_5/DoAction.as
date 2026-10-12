function timer(timerTarget)
{
   timerCount--;
   if(timerCount <= 0 && gamePaused != true)
   {
      timerCount = timerMax + levelUp / 1.25;
      targetCount++;
      if(targetCount >= timerTarget - timerTarget / 6 && sunriseStarted == false)
      {
         startSunRise();
      }
      if(targetCount >= timerTarget - timerTarget / 8)
      {
         delete makeEnemy.onEnterFrame;
      }
      if(targetCount >= timerTarget && aliveZombies.length == 0)
      {
         stopTimer();
      }
   }
}
function startTimer(levelTime)
{
   levelClock.onEnterFrame = function()
   {
      timer(levelTime);
   };
}
function stopTimer()
{
   delete levelClock.onEnterFrame;
   targetCount = 0;
   _root.reloadAnimPlaying = false;
   _root.reloadMagazine();
   loadTimeManager();
}
function startSunRise()
{
   if(sunriseStarted == false)
   {
      sunriseStarted = true;
      bgImage.dawn._visible = true;
      bgImage.dawn._alpha = 0;
      alphaSun = setInterval(alphaUpSun,500);
   }
}
function alphaUpSun()
{
   if(bgImage.dawn._alpha <= 100)
   {
      bgImage.dawn._alpha += 2;
   }
   else
   {
      clearInterval(alphaSun);
   }
}
function resetSunRise()
{
   sunriseStarted = false;
   clearInterval(alphaSun);
   bgImage.dawn._alpha = 0;
   bgImage.dawn._visible = false;
}
function variableReset()
{
   bullet = 0;
   bulletLevel = 1;
   projectile = 0;
   smokePuff = 0;
   zombieDepthCount = 0;
   particleCount = 480000;
   explosionNumber = 0;
}
function addTrap(trapType, trapLocationNumber)
{
   trapNumber++;
   _root.attachMovie("trap_" + trapType,"trap" + trapNumber,29500 + trapNumber);
   _root["trap" + trapNumber]._x = _root["trapSpot" + trapLocationNumber].x;
   _root["trap" + trapNumber]._y = _root["trapSpot" + trapLocationNumber].y;
   activeTraps.push({ref:_root["trap" + trapNumber],type:trapType,range:_root[trapType].range,damage:_root[trapType].damage,location:trapLocationNumber});
   enemyOnScreen.push({ref:_root["trap" + trapNumber],depth:_root["trap" + trapNumber]._y});
}
function cleanUpTraps()
{
   for(x in activeTraps)
   {
      removeMovieClip(_root[activeTraps[x].ref]);
      trapLocations[activeTraps[x].location].empty = true;
      trapLocations[activeTraps[x].location].type = "empty";
      timeManager.trapMap["location" + activeTraps[x].location].trapIcon.gotoAndStop("empty");
      activeTraps.splice(x,1);
   }
}
function trapLocationObjects()
{
   i = 0;
   while(i < 20)
   {
      trapLocations.push({ref:_root.trapMap["location" + i],type:"empty",empty:true});
      i++;
   }
}
function populateTrapMap()
{
   for(v in _root.trapLocations)
   {
      timeManager.trapMap["location" + v].trapIcon.gotoAndStop(_root.trapLocations[v].type);
      timeManager.trapMap["location" + v].cross.alphaTo(0,0.5);
      if(_root.trapLocations[v].type != "empty")
      {
         addTrap(_root.trapLocations[v].type,v);
      }
   }
}
function placeTrapOnMap(trapButton, trapType)
{
   if(currentSelectedTrap != "empty" && _root["total_" + trapType] > 0)
   {
      _root["total_" + trapType]--;
      updateTrapMapText();
      trapLocations[trapButton].empty = false;
      trapLocations[trapButton].type = trapType;
   }
}
function removeTrapOnMap(trapButton, trapType)
{
   _root["total_" + trapType]++;
   updateTrapMapText();
   trapLocations[trapButton].empty = true;
   trapLocations[trapButton].type = "empty";
   timeManager.trapMap["location" + trapButton].trapIcon.gotoAndStop("empty");
}
function removeTrapOnMapFromExplosion(trapButton)
{
   updateTrapMapText();
   trapLocations[trapButton].empty = true;
   trapLocations[trapButton].type = "empty";
}
function updateTrapMapText()
{
   timeManager.trapMap.gasCylinderText.text = "x" + total_gasCylinder;
   timeManager.trapMap.mineText.text = "x" + total_mine;
   timeManager.trapMap.bearTrapText.text = "x" + total_bearTrap;
}
function trapSetupButton(butName)
{
   timeManager.trapMap[butName].onRollOver = function()
   {
      this.colorTo(10027008,0.5,"easeOutSine");
   };
   timeManager.trapMap[butName].onRollOut = function()
   {
      this.colorTo(null,0.5,"easeOutSine");
   };
   timeManager.trapMap[butName].onRelease = function()
   {
      if(trapMapOpen == false)
      {
         openTrapMap();
         timeManager.trapMap[butName].gotoAndStop("accept");
         trapMapOpen = true;
      }
      else
      {
         closeTrapMap();
         timeManager.trapMap[butName].gotoAndStop("setup");
         trapMapOpen = false;
      }
   };
}
function trapMapPlacementButtons(butName)
{
   timeManager.trapMap[butName]._rotation = random(10) - 5;
   timeManager.trapMap[butName]._xscale = timeManager.trapMap[butName]._yscale = random(5) + 95;
   timeManager.trapMap[butName].cross._alpha = 0;
   timeManager.trapMap[butName].onRollOver = function()
   {
      this.colorTo(10027008,0.5,"easeOutSine");
      var _loc3_ = butName.substring(8,10);
      for(v in _root.trapLocations)
      {
         if(v == _loc3_)
         {
            if(_root.trapLocations[v].empty == true && _root["total_" + currentSelectedTrap] > 0)
            {
               _root.timeManager.trapMap["location" + v].trapIcon.gotoAndStop(currentSelectedTrap);
            }
            else if(_root.trapLocations[v].empty == false)
            {
               _root.timeManager.trapMap["location" + v].cross.alphaTo(100,0.5);
            }
         }
      }
   };
   timeManager.trapMap[butName].onRollOut = function()
   {
      this.colorTo(null,0.5,"easeOutSine");
      this.cross.alphaTo(0,0.5);
      for(v in _root.trapLocations)
      {
         timeManager.trapMap["location" + v].trapIcon.gotoAndStop(_root.trapLocations[v].type);
      }
   };
   timeManager.trapMap[butName].onRelease = function()
   {
      var _loc2_ = butName.substring(8,10);
      for(v in _root.trapLocations)
      {
         if(v == _loc2_)
         {
            if(_root.trapLocations[v].empty == true)
            {
               placeTrapOnMap(_loc2_,currentSelectedTrap);
            }
            else
            {
               removeTrapOnMap(_loc2_,_root.trapLocations[v].type);
            }
         }
      }
   };
}
function trapSelectionButtons(butName)
{
   timeManager.trapMap[butName].onRollOver = function()
   {
      this.colorTo(10027008,0.5,"easeOutSine");
   };
   timeManager.trapMap[butName].onRollOut = function()
   {
      this.colorTo(null,0.5,"easeOutSine");
   };
   timeManager.trapMap[butName].onRelease = function()
   {
      if(trapMapOpen == false)
      {
         openTrapMap();
         trapMapOpen = true;
      }
      currentSelectedTrap = butName.substring(4,50);
   };
}
function loadTimeManager()
{
   _root.mainBlackOut.alphaTo(0,1,"easeOutSine");
   chainsawSound.stop("sound_chainsawIdle");
   stopChainsawIdle();
   timeManagerOpen = true;
   if(retryLevel == false)
   {
      levelUp++;
   }
   pauseGame();
   _root.attachMovie("timeManager","timeManager",900021);
   timeManager.blackOut.alphaTo(100,1,"easeOutSine",0.2,startTimeManager);
   hoursSpentSurvivors = 0;
   hoursSpentWeapons = 0;
   hoursSpentRepairingWall = 0;
   hoursSpentSupplies = 0;
   wallRepairs = 0;
   survivorsFound = 0;
   suppliesFound = 0;
   searchPartyMembersKilled = 0;
   hoursInDay = 12;
   searchFoundAWeapon = 0;
   currentZombieThreat = 0;
   threatDeficit = 0;
   liveZombieCount = 0;
   tempFoundSurvivors = 0;
   tempFoundSupplies = 0;
   for(v in searchWeaponsFound)
   {
      searchWeaponsFound.pop();
   }
}
function startTimeManager()
{
   hideCrosshairs();
   bgMusic.volumeTo(20,3,"easeOutSine");
   cleanUpZombies();
   timeManager.gotoAndStop("timeManage");
   cleanUpSurvivors();
   setupTravelMap();
   firstTravelSetup(currentTownLocation);
   changeClipBoardMap(currentTownLocation);
   setupSearchedBuildings();
   changeBackdrops(currentTownLocation);
   timeManager.blackOut.alphaTo(0,2,"easeOutSine");
   updateClipBoardText();
   weaponMeter();
   if(survivors >= maxHelpers)
   {
      timeManager.theClipBoard.noVacancy._visible = true;
   }
   else
   {
      timeManager.theClipBoard.noVacancy._visible = false;
   }
   if(retryLevel == true)
   {
      calculateFindings();
      confirmResults();
   }
   else
   {
      clipBoardUp();
   }
   loadHints();
}
function closeManager()
{
   dropWeapon();
   cleanUpZombies();
   removeMapOverlay();
   createTownMapOverlay(currentTownLocation);
   populateTrapMap();
   if(_root.primaryWeapon != undefined)
   {
      showCrosshairs();
      bgMusic.volumeTo(100,8,"easeOutSine");
      retryLevel = false;
      startOfLevelWallHealth = wall.health;
      _root.timeManager.blackOut.alphaTo(100,2,"easeOutSine",0,startNextLevel);
      assignSurvivorWeapons();
      swapWeapon(primaryWeapon.name);
      variableReset();
      if(bgMusicPlaying == false)
      {
         changeMusic();
      }
   }
   else
   {
      _root.timeManager.tm_backgrounds.needAWeapon.alphaTo(100,1);
   }
}
function updateClipBoardText()
{
   clearInterval(updateClipBoard);
   timeManager.theClipBoard.hoursRemaining.text = hoursInDay;
   timeManager.theClipBoard.hoursSurvivors.text = hoursSpentSurvivors;
   timeManager.theClipBoard.hoursWeapons.text = hoursSpentWeapons;
   timeManager.theClipBoard.hoursSupplies.text = hoursSpentSupplies;
   timeManager.theClipBoard.hoursRepairingWallText.text = hoursSpentRepairingWall;
   timeManager.theClipBoard.repairRateText.text = Math.round(repairRate * Math.round(survivors / 2) / 100);
   timeManager.clipBoardResults.wallRepairedBy.text = Math.round(wallRepairs / 100);
   timeManager.clipBoardResults.survivorsFoundText.text = tempFoundSurvivors;
   timeManager.clipBoardResults.suppliesFoundText.text = tempFoundSupplies;
   timeManager.clipBoardResults.survivorsKilledText.text = searchPartyMembersKilled;
   timeManager.clipBoardResults.clipBoardDay.text = levelUp;
   timeManager.theClipBoard.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.theClipBoard.barricadeMax.text = Math.round(wall.maxHealth / 100);
   timeManager.clipBoardResults.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.clipBoardResults.barricadeMax.text = Math.round(wall.maxHealth / 100);
   timeManager.theClipBoard.survivorsTotal.text = survivors;
   timeManager.clipBoardResults.survivorsTotal.text = survivors;
   timeManager.theClipBoard.suppliesTotal.text = supplies;
   timeManager.clipBoardResults.suppliesTotal.text = supplies;
   timeManager.theClipBoard.townNameText.text = location[currentTownLocation].name;
   timeManager.theClipBoard.dayNumberText.text = "DAY " + levelUp;
}
function resetClipBoardText()
{
   timeManager.theClipBoard.hoursRemaining.text = "12";
   timeManager.theClipBoard.hoursSurvivors.text = "0";
   timeManager.theClipBoard.hoursWeapons.text = "0";
   timeManager.theClipBoard.hoursSupplies.text = "0";
   timeManager.theClipBoard.hoursRepairingWall.text = "0";
   timeManager.clipBoardResults.wallRepairedTo.text = "0";
   timeManager.clipBoardResults.survivorsFound.text = "0";
   timeManager.clipBoardResults.suppliesFoundText.text = "0";
   timeManager.clipBoardResults.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.theClipBoard.barricadeTotal.text = Math.round(wall.health / 100);
   timeManager.clipBoardResults.foundWeapons.text = "";
   timeManager.clipBoardResults.survivorsFoundText.text = "0";
   timeManager.clipBoardResults.suppliesFoundText.text = "0";
}
function calculateFindings()
{
   tempWallHealth = wall.health;
   wallRepairs = hoursSpentRepairingWall * repairRate * Math.round(survivors / 2);
   wall.health += wallRepairs;
   checkWallStatus();
   if(wall.health > 0)
   {
      wall.destroyed = false;
   }
   if(wall.health >= wall.maxHealth)
   {
      wallRepairs = wall.maxHealth - tempWallHealth;
      wall.health = wall.maxHealth;
   }
   checkWallStatus();
   startOfLevelWallHealth = wall.health;
   if(survivors <= maxSurvivorsOnScreen)
   {
      survivors += tempFoundSurvivors;
   }
   if(survivors > maxSurvivorsOnScreen)
   {
      survivors = maxSurvivorsOnScreen;
   }
   scroungedSupplies += 0.25;
   if(scroungedSupplies >= 1)
   {
      supplies += scroungedSupplies;
      scroungedSupplies = 0;
   }
   supplies += tempFoundSupplies;
   v = 0;
   while(v < searchWeaponsFound.length)
   {
      _root[searchWeaponsFound[v]].found = true;
      timeManager.clipBoardResults.foundWeapons.text += _root[searchWeaponsFound[v]].description;
      if(searchWeaponsFound.length - 1 - v > 0)
      {
         timeManager.clipBoardResults.foundWeapons.text += ", ";
      }
      v++;
   }
   if(searchWeaponsFound[0] == undefined)
   {
      timeManager.clipBoardResults.foundWeapons.text = "NONE";
   }
   setupSurvivors();
   checkWeaponSlots();
   for(i in allWeapons)
   {
      if(_root[allWeapons[i]].found == true)
      {
         timeManager.tm_backgrounds["shadow_" + _root[allWeapons[i]].name].attachMovie(_root[allWeapons[i]].name + "_Icon",_root[allWeapons[i]].name + "_Weapon",this.getNextHighestDepth);
      }
      if(_root[allWeapons[i]].inUse == true)
      {
         timeManager.tm_backgrounds["shadow_" + _root[allWeapons[i]].name][_root[allWeapons[i]].name + "_Weapon"].alphaTo(0,0);
      }
      else
      {
         timeManager.tm_backgrounds["shadow_" + _root[allWeapons[i]].name][_root[allWeapons[i]].name + "_Weapon"].alphaTo(100,0);
      }
   }
   _root.timeManager.tm_backgrounds.primary.attachMovie(primaryWeapon.name + "_Icon","primaryWeapon",this.getNextHighestDepth);
   _root.timeManager.tm_backgrounds.secondary.attachMovie(secondaryWeapon.name + "_Icon","secondaryWeapon",this.getNextHighestDepth);
   _root.timeManager.tm_backgrounds.slot3.attachMovie(slot3Weapon.name + "_Icon","slot3Weapon",this.getNextHighestDepth);
   _root.timeManager.tm_backgrounds.slot4.attachMovie(slot4Weapon.name + "_Icon","slot4Weapon",this.getNextHighestDepth);
   _root.timeManager.tm_backgrounds.slot5.attachMovie(slot5Weapon.name + "_Icon","slot5Weapon",this.getNextHighestDepth);
   _root.timeManager.tm_backgrounds.slot6.attachMovie(slot6Weapon.name + "_Icon","slot6Weapon",this.getNextHighestDepth);
   debugDay++;
   updateClipBoard = setInterval(updateClipBoardText,1000);
}
function weaponMeter()
{
   var _loc1_;
   for(i in weaponPoints)
   {
      i = nextWeaponPoint;
      if(weaponPoints[i] != undefined)
      {
         pointsDifference = weaponPoints[i] - weaponPoints[i - 1];
         earnedPointsPastDiff = foundWeaponsTotal - weaponPoints[i - 1];
         if(earnedPointsPastDiff <= 0)
         {
            earnedPointsPastDiff = 0;
         }
      }
      else
      {
         pointsDifference = weaponPoints[i];
         earnedPointsPastDiff = foundWeaponsTotal;
      }
      _loc1_ = Math.round(earnedPointsPastDiff / pointsDifference * 100);
      timeManager.theClipBoard.findOmeter.findBar.bar._xscale = _loc1_;
      break;
   }
}
function slideToToolBench()
{
   timeManager.tm_backgrounds.xSlideTo(-1695,1.2,"easeOutSine",0.5);
   timeManager.trapMap.xSlideTo(-400,0.5,"easeOutSine",2);
   populateTrapMap();
   updateTrapMapText();
}
function openTrapMap()
{
   dropWeapon();
   timeManager.trapMap.xSlideTo(20,0.8,"easeOutSine");
}
function closeTrapMap()
{
   dropWeapon();
   timeManager.trapMap.xSlideTo(-400,0.8,"easeOutSine");
}
function openPostCard()
{
   timeManager.theClipBoard.postCard.xSlideTo(-320,1,"easeOutSine");
}
function closePostCard()
{
   timeManager.theClipBoard.postCard.xSlideTo(-520,1,"easeOutSine");
}
function openTravelMap()
{
   travelMapOpen = true;
   timeManager.travelMap.blockerButton._visible = false;
   clipBoardDown();
   timeManager.travelMap.ySlideTo(220,1.5,"easeOutSine",1);
}
function closeTravelMap()
{
   travelMapOpen = false;
   timeManager.travelMap.blockerButton._visible = true;
   timeManager.travelMap.ySlideTo(629,2,"easeOutSine",1,openJournal);
   updateClipBoardText();
   updateClipBoardResultsText();
}
function clipBoardUp()
{
   checkIfCanTravel();
   timeManager.theClipBoard.ySlideTo(30,0.5,"easeOutSine",1);
}
function clipBoardDown()
{
   timeManager.theClipBoard.ySlideTo(420,0.5,"easeOutSine");
   timeManager.tm_backgrounds.xSlideTo(-950,1.8,"easeOutSine",0.5);
}
function clipBoardResultsUp()
{
   timeManager.clipBoardResults.ySlideTo(15,0.5,"easeOutSine");
}
function clipBoardResultsDown()
{
   timeManager.clipBoardResults.ySlideTo(420,0.5,"easeOutSine");
}
function confirmTimeManagement()
{
   clipBoardDown();
   calculateFindings();
   timeManager.tm_backgrounds.night.alphaTo(100,1.8,"easeOutSine",0,clipBoardResultsUp);
}
function confirmResults()
{
   clipBoardResultsDown();
   resetClipBoardText();
   slideToToolBench();
}
function clipBoardButtons(btnName)
{
   _root.timeManager.theClipBoard[btnName].onRelease = function()
   {
      switch(btnName)
      {
         case "barricadePlus":
            if(hoursInDay > 0)
            {
               hoursSpentRepairingWall++;
               hoursInDay--;
               updateClipBoardText();
            }
            return;
         case "barricadeMinus":
            if(hoursSpentRepairingWall > 0)
            {
               hoursSpentRepairingWall--;
               hoursInDay++;
               updateClipBoardText();
            }
            return;
         case "weaponsMinus":
            if(hoursSpentWeapons > 0)
            {
               hoursSpentWeapons--;
               hoursInDay++;
               updateClipBoardText();
            }
            return;
         case "weaponsPlus":
            if(hoursInDay > 0)
            {
               hoursSpentWeapons++;
               hoursInDay--;
               updateClipBoardText();
            }
            return;
         case "survivorsMinus":
            if(hoursSpentSurvivors > 0)
            {
               hoursSpentSurvivors--;
               hoursInDay++;
               updateClipBoardText();
            }
            return;
         case "survivorsPlus":
            if(hoursInDay > 0)
            {
               hoursSpentSurvivors++;
               hoursInDay--;
               updateClipBoardText();
            }
            return;
         case "suppliesPlus":
            if(hoursInDay > 0)
            {
               hoursSpentSupplies++;
               hoursInDay--;
               updateClipBoardText();
            }
            return;
         case "suppliesMinus":
            if(hoursSpentSupplies > 0)
            {
               hoursSpentSupplies--;
               hoursInDay++;
               updateClipBoardText();
            }
            return;
         default:
            return;
      }
   };
}
function setupTravelMap()
{
   _root.timeManager.travelMap.supplyWarning._alpha = 0;
   for(m in _root.allTownLocations)
   {
      timeManager.travelMap[allTownLocations[m]].gotoAndStop("noTravel");
   }
   for(v in location[currentTownLocation].destinations)
   {
      timeManager.travelMap[location[currentTownLocation].destinations[v]].gotoAndStop("yesTravel");
      timeManager.travelMap[currentTownLocation].gotoAndStop("youAreHere");
   }
   for(v in travelledLocations)
   {
      _root.timeManager.travelMap.travelLines[travelledLocations[v]].lineMask.xScaleTo(100,0);
   }
   timeManager.travelMap.blockerButton._visible = false;
   if(travelMapOpen)
   {
      closeTravelMap();
      timeManager.travelMap.blockerButton._visible = true;
   }
   timeManager.travelMap.suppliesTotalText.text = supplies;
   timeManager.travelMap.daysLeftText.text = 40 - levelUp + 1;
}
function changeBackdrops(townName)
{
   timeManager.tm_backgrounds.colorTo(0,1,"easeOutSine",null,function()
   {
      timeManager.tm_backgrounds.gotoAndStop(townName);
   }
   );
   timeManager.tm_backgrounds.colorTo(null,2,"easeOutSine",2);
   bgImage.gotoAndStop(townName);
}
function createTownMapOverlay(townName)
{
   townNameOverlays++;
   _root.attachMovie("bg_" + townName + "_overlay","mapOverlay",864235 + townNameOverlays);
   _root.mapOverlay._x = 0;
   _root.mapOverlay._y = 420;
}
function removeMapOverlay()
{
   removeMovieClip(mapOverlay);
}
function changeClipBoardMap(townName)
{
   timeManager.theClipBoard.searchMap.gotoAndStop(townName);
   updateClipBoardText();
}
function townButton(townName)
{
   _root.timeManager.travelMap[townName].onRollOver = function()
   {
      this.scribble.gotoAndPlay(1);
      for(v in location[currentTownLocation].destinations)
      {
         if(location[currentTownLocation].destinations[v] == townName)
         {
            _root.validTownRollOver = true;
         }
      }
      if(_root.validTownRollOver)
      {
         calculateTravelTime(currentTownLocation,townName);
         _root.timeManager.travelMap.townInfoCard.townNameText.text = location[townName].name;
         _root.timeManager.travelMap.townInfoCard.townPopText.text = location[townName].population;
         _root.timeManager.travelMap.townInfoCard.daysTravelText.text = travelTime;
         _root.timeManager.travelMap.townInfoCard.slideTo(_root.timeManager.travelMap[townName]._x,_root.timeManager.travelMap[townName]._y,1);
         _root.timeManager.travelMap.townInfoCard.rotateTo(random(10) - 15,1);
         _root.validTownRollOver = false;
      }
   };
   _root.timeManager.travelMap[townName].onRollOut = function()
   {
      _root.timeManager.travelMap.townInfoCard.slideTo(-600,50,0.5);
      _root.timeManager.travelMap.townInfoCard.rotateTo(random(30),0.5);
   };
   _root.timeManager.travelMap[townName].onRelease = function()
   {
      _root.travelToLocation(townName);
   };
}
function checkIfCanTravel()
{
   for(v in location[currentTownLocation].destinations)
   {
      calculateTravelTime(currentTownLocation,location[currentTownLocation].destinations[v]);
      if(travelTime <= supplies)
      {
         openPostCard();
      }
      else
      {
         closePostCard();
      }
   }
}
function travelToLocation(townName)
{
   for(v in location[currentTownLocation].destinations)
   {
      if(location[currentTownLocation].destinations[v] == townName)
      {
         validTravelDestination = true;
      }
   }
   calculateTravelTime(currentTownLocation,townName);
   if(validTravelDestination && travelTime <= supplies)
   {
      _root.timeManager.travelMap.blockerButton._visible = true;
      currentTownTarget = townName;
      if(travelTime <= 1)
      {
         _root.timeManager.travelMap.confirmTravel.travelTimeText.text = travelTime + " DAY";
      }
      else
      {
         _root.timeManager.travelMap.confirmTravel.travelTimeText.text = travelTime + " DAYS";
      }
      _root.timeManager.travelMap.confirmTravel.townNameText.text = location[currentTownTarget].name + " ?";
      _root.timeManager.travelMap.confirmTravel.slideTo(-13,1.5,0.8);
   }
   else if(travelTime > supplies && validTravelDestination)
   {
      validTravelDestination = false;
      _root.timeManager.travelMap.supplyWarning.slideTo(_root.timeManager.travelMap[townName]._x,_root.timeManager.travelMap[townName]._y - 50,0);
      _root.timeManager.travelMap.supplyWarning.scaleTo(5,0);
      _root.timeManager.travelMap.supplyWarning.alphaTo(100,0,"easeOutSine");
      _root.timeManager.travelMap.supplyWarning.scaleTo(110,0.25,"easeOutBounce");
      _root.timeManager.travelMap.supplyWarning.scaleTo(5,0.25,"easeOutBounce",2);
      _root.timeManager.travelMap.supplyWarning.alphaTo(0,0,"easeOutSine",2.2);
   }
}
function travelConfirmed(currentTown, targetTown)
{
   cleanUpTraps();
   hoursSpentRepairingWall = 0;
   supplies -= travelTime;
   levelUp += travelTime;
   validTravelDestination = false;
   if(targetTown == "unionCity")
   {
      endGame();
      endingGame = true;
   }
   var _loc5_;
   var _loc3_;
   if(endingGame == false)
   {
      _root.timeManager.travelMap.travelLines[currentTown + "_" + targetTown].lineMask.xScaleTo(100,travelTime,"linear",null,setupTravelMap);
      _loc5_ = currentTown + "_" + targetTown;
      travelledLocations.push(_loc5_);
      _loc3_ = currentTownLocation;
      currentTownLocation = targetTown;
      currentTownTarget = "";
      changeBackdrops(currentTownLocation);
      changeClipBoardMap(currentTownLocation);
      firstTravelSetup(currentTownLocation);
      setupSearchedBuildings();
      resetNonConfirmedSearches(_loc3_);
      setupWall(currentTownLocation);
      fadeAndChangeMusic();
   }
}
function firstTravelSetup(townName)
{
   if(location[townName].travelledTo == false)
   {
      setupBuildings("weapons",townName);
      setupBuildings("supplies",townName);
      setupBuildings("survivors",townName);
      location[townName].travelledTo = true;
   }
}
function cancelTravel(butName)
{
   _root.timeManager.travelMap[butName].onRelease = function()
   {
      this._parent.ySlideTo(629,1,"easeOutSine");
      _root.updateClipBoardText();
      _root.updateClipBoardResultsText();
      _root.clipBoardUp();
   };
}
function cancelTravelConfirm(butName)
{
   _root.timeManager.travelMap.confirmTravel[butName].onRelease = function()
   {
      this._parent.slideTo(-13,420,0.5);
      _root.validTravelDestination = false;
      _root.timeManager.travelMap.blockerButton._visible = false;
   };
}
function calculateTravelTime(depart, arrive)
{
   if(depart == "glenDale" && arrive == "whistlersGrove" || depart == "whistlersGrove" && arrive == "glenDale")
   {
      travelTime = 4;
   }
   else if(depart == "glenDale" && arrive == "claysBurg" || depart == "claysBurg" && arrive == "glenDale")
   {
      travelTime = 4;
   }
   else if(depart == "whistlersGrove" && arrive == "claysBurg" || depart == "claysBurg" && arrive == "whistlersGrove")
   {
      travelTime = 5;
   }
   else if(depart == "whistlersGrove" && arrive == "aspenWood" || depart == "aspenWood" && arrive == "whistlersGrove")
   {
      travelTime = 4;
   }
   else if(depart == "claysBurg" && arrive == "aspenWood" || depart == "aspenWood" && arrive == "claysBurg")
   {
      travelTime = 3;
   }
   else if(depart == "whistlersGrove" && arrive == "aspenWood" || depart == "aspenWood" && arrive == "whistlersGrove")
   {
      travelTime = 4;
   }
   else if(depart == "whistlersGrove" && arrive == "jonesTown" || depart == "jonesTown" && arrive == "whistlersGrove")
   {
      travelTime = 4;
   }
   else if(depart == "aspenWood" && arrive == "jonesTown" || depart == "jonesTown" && arrive == "aspenWood")
   {
      travelTime = 3;
   }
   else if(depart == "jonesTown" && arrive == "armyBase" || depart == "armyBase" && arrive == "jonesTown")
   {
      travelTime = 3;
   }
   else if(depart == "armyBase" && arrive == "unionCity" || depart == "unionCity" && arrive == "armyBase")
   {
      travelTime = 4;
   }
   else if(depart == "jonesTown" && arrive == "unionCity" || depart == "unionCity" && arrive == "jonesTown")
   {
      travelTime = 6;
   }
}
function shuffleArray()
{
   var _loc1_ = Math.round(Math.random() * 2);
   return _loc1_;
}
function searchBuilding(buildingName, townName, buildingType)
{
   _root[townName + "BuildingsSearched"].push({butName:buildingName,buildingType:buildingType});
   for(v in _root[buildingType + "Buildings"])
   {
      if(_root[buildingType + "Buildings"][v].ref == buildingName)
      {
         if(_root.hoursInDay - _root[buildingType + "Buildings"][v].searchTime >= 0)
         {
            _root.hoursInDay -= _root[buildingType + "Buildings"][v].searchTime;
            _root.updateClipBoardText();
            switch(buildingType)
            {
               case "weapons":
                  if(_root[buildingType + "Buildings"][v].hasItem != "empty")
                  {
                     _root[_root[buildingType + "Buildings"][v].hasItem].found = true;
                     searchWeaponsFound.push(_root[buildingType + "Buildings"][v].hasItem);
                     allWeaponsFound.push(_root[buildingType + "Buildings"][v].hasItem);
                  }
                  break;
               case "survivors":
                  if(_root[buildingType + "Buildings"][v].hasItem == "survivor")
                  {
                     if(survivors < maxSurvivorsOnScreen)
                     {
                        tempFoundSurvivors++;
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "survivors2")
                  {
                     if(survivors < maxSurvivorsOnScreen)
                     {
                        tempFoundSurvivors += 2;
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "supplies")
                  {
                     tempFoundSupplies++;
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "supplies2")
                  {
                     tempFoundSupplies += 2;
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "gasCylinder")
                  {
                     total_gasCylinder += 4;
                     searchWeaponsFound.push("gasCylinder");
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "mine")
                  {
                     total_mine += 4;
                     searchWeaponsFound.push("mine");
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "bearTrap")
                  {
                     total_bearTrap += 4;
                     searchWeaponsFound.push("bearTrap");
                  }
                  break;
               case "supplies":
                  if(_root[buildingType + "Buildings"][v].hasItem == "supplies")
                  {
                     tempFoundSupplies++;
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "supplies2")
                  {
                     tempFoundSupplies += 2;
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "survivor")
                  {
                     if(survivors < maxSurvivorsOnScreen)
                     {
                        tempFoundSurvivors++;
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "survivors2")
                  {
                     if(survivors < maxSurvivorsOnScreen)
                     {
                        tempFoundSurvivors += 2;
                     }
                  }
            }
         }
      }
   }
}
function cancelSearchBuilding(buildingName, townName, buildingType)
{
   for(v in _root[buildingType + "Buildings"])
   {
      if(_root[buildingType + "Buildings"][v].ref == buildingName)
      {
         if(_root.hoursInDay + _root[buildingType + "Buildings"][v].searchTime <= 12)
         {
            _root.hoursInDay += _root[buildingType + "Buildings"][v].searchTime;
            _root.updateClipBoardText();
            switch(buildingType)
            {
               case "weapons":
                  if(_root[buildingType + "Buildings"][v].hasItem != "empty")
                  {
                     for(x in searchWeaponsFound)
                     {
                        if(_root[buildingType + "Buildings"][v].hasItem == searchWeaponsFound[x])
                        {
                           _root[searchWeaponsFound[x]].found = false;
                           searchWeaponsFound.splice(x,1);
                        }
                     }
                  }
                  break;
               case "survivors":
                  if(_root[buildingType + "Buildings"][v].hasItem == "survivor")
                  {
                     if(tempFoundSurvivors > 0)
                     {
                        tempFoundSurvivors--;
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "supplies")
                  {
                     if(tempFoundSupplies > 0)
                     {
                        tempFoundSupplies--;
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "mine")
                  {
                     for(x in searchWeaponsFound)
                     {
                        if(searchWeaponsFound[x] == "mine")
                        {
                           searchWeaponsFound.splice(x,1);
                           if(total_mine > 0)
                           {
                              total_mine -= 4;
                           }
                        }
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "gasCylinder")
                  {
                     for(x in searchWeaponsFound)
                     {
                        if(searchWeaponsFound[x] == "gasCylinder")
                        {
                           searchWeaponsFound.splice(x,1);
                           if(total_gasCylinder > 0)
                           {
                              total_gasCylinder -= 4;
                           }
                        }
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "bearTrap")
                  {
                     for(x in searchWeaponsFound)
                     {
                        if(searchWeaponsFound[x] == "bearTrap")
                        {
                           searchWeaponsFound.splice(x,1);
                           if(total_bearTrap > 0)
                           {
                              total_bearTrap -= 4;
                           }
                        }
                     }
                  }
                  break;
               case "supplies":
                  if(_root[buildingType + "Buildings"][v].hasItem == "supplies")
                  {
                     if(tempFoundSupplies > 0)
                     {
                        tempFoundSupplies--;
                     }
                  }
                  if(_root[buildingType + "Buildings"][v].hasItem == "survivor")
                  {
                     if(tempFoundSurvivors > 0)
                     {
                        tempFoundSurvivors--;
                     }
                  }
            }
         }
      }
   }
   for(v in _root[townName + "BuildingsSearched"])
   {
      if(_root[townName + "BuildingsSearched"][v].butName == buildingName)
      {
         _root[townName + "BuildingsSearched"].splice(v,1);
      }
   }
}
function clearBuildings()
{
   delete suppliesBuildings;
   delete survivorBuildings;
   delete weaponBuildings;
   delete glenDaleBuildingsSearched;
   delete claysBurgBuildingsSearched;
   delete whistlersGroveBuildingsSearched;
   delete aspenWoodBuildingsSearched;
   delete jonesTownBuildingsSearched;
   delete armyBaseBuildingsSearched;
}
function setupBuildings(buildingType, townName)
{
   updateClipBoardText();
   _root.timeManager.theClipBoard.searchMap.gotoAndStop(currentTownLocation);
   if(_root[townName + "BuildingsSearched"][0].butName == undefined)
   {
      _root[townName + "BuildingsSearched"] = new Array();
   }
   _root[buildingType + "Buildings"] = new Array();
   _root[buildingType + "Buildings"] = location[townName][buildingType + "Buildings"];
   _root[townName + buildingType + "ToFind"] = new Array();
   _root[townName + buildingType + "ToFind"] = location[townName][buildingType].sort(shuffleArray);
   for(v in _root[buildingType + "Buildings"])
   {
      _root[buildingType + "Buildings"][v].hasItem = _root[townName + buildingType + "ToFind"][v];
   }
}
function resetNonConfirmedSearches(townName)
{
   for(e in searchWeaponsFound)
   {
      searchWeaponsFound.splice(e,1);
   }
   hoursInDay = 12;
   updateClipBoardText();
}
function setupSearchedBuildings()
{
   for(v in _root[currentTownLocation + "BuildingsSearched"])
   {
      _root.timeManager.theClipBoard.searchMap[_root[currentTownLocation + "BuildingsSearched"][v].buildingType][_root[currentTownLocation + "BuildingsSearched"][v].butName].gotoAndStop("searched");
      _root.timeManager.theClipBoard.searchMap[_root[currentTownLocation + "BuildingsSearched"][v].buildingType][_root[currentTownLocation + "BuildingsSearched"][v].butName].enabled = false;
   }
}
function searchBuildingButtons(buildingType, butName)
{
   _root.timeManager.theClipBoard.searchMap[buildingType][butName].onLoad = function()
   {
      this.searched = false;
   };
   _root.timeManager.theClipBoard.searchMap[buildingType][butName].onRollOver = function()
   {
      _root.timeManager.theClipBoard.searchInfoCard._alpha = 100;
      mapPoint = new Object();
      mapPoint.x = this._x;
      mapPoint.y = this._y;
      _root.timeManager.theClipBoard.searchMap[buildingType].localToGlobal(mapPoint);
      _root.timeManager.theClipBoard.searchInfoCard.slideTo(mapPoint.x,mapPoint.y,0.2);
      for(v in _root[buildingType + "Buildings"])
      {
         if(_root[buildingType + "Buildings"][v].ref == butName)
         {
            _root.timeManager.theClipBoard.searchInfoCard.hasItem.text = _root[buildingType + "Buildings"][v].hasItem;
            _root.timeManager.theClipBoard.searchInfoCard.searchTime.text = _root[buildingType + "Buildings"][v].searchTime;
            _root.timeManager.theClipBoard.searchInfoCard.buildingName.text = _root[buildingType + "Buildings"][v].ref;
            _root.timeManager.theClipBoard.searchInfoCard.searchTypeText.text = buildingType;
            _root.timeManager.theClipBoard.searchInfoCard.buildingNameText.text = _root[buildingType + "Buildings"][v].name;
         }
      }
   };
   _root.timeManager.theClipBoard.searchMap[buildingType][butName].onRollOut = function()
   {
      _root.timeManager.theClipBoard.searchInfoCard._alpha = 0;
   };
   _root.timeManager.theClipBoard.searchMap[buildingType][butName].onRelease = function()
   {
      if(this.searched == false)
      {
         for(v in _root[buildingType + "Buildings"])
         {
            if(_root[buildingType + "Buildings"][v].ref == butName)
            {
               if(_root.hoursInDay - _root[buildingType + "Buildings"][v].searchTime >= 0)
               {
                  this.searched = true;
                  _root[currentTownLocation + "BuildingsSearched"].push({butName:butName,buildingType:buildingType});
                  this.scribbleCircle.play();
                  _root.searchBuilding(butName,currentTownLocation,buildingType);
               }
            }
         }
      }
      else
      {
         this.searched = false;
         _root.cancelSearchBuilding(butName,currentTownLocation,buildingType);
         this.scribbleCircle.gotoAndStop(1);
      }
   };
}
function setupSurvivorSlots()
{
   survivorPosition1 = new Object();
   survivorPosition1.free = true;
   survivorPosition1.weapon = "snubnose";
   survivorPosition1.x = 645;
   survivorPosition1.y = 100;
   survivorPosition1.section = "section1";
   survivorPosition2 = new Object();
   survivorPosition2.free = true;
   survivorPosition2.weapon = "snubnose";
   survivorPosition2.x = 683;
   survivorPosition2.y = 202;
   survivorPosition2.section = "section3";
   survivorPosition3 = new Object();
   survivorPosition3.free = true;
   survivorPosition3.weapon = "snubnose";
   survivorPosition3.x = 664;
   survivorPosition3.y = 245;
   survivorPosition3.section = "section3";
   survivorPosition4 = new Object();
   survivorPosition4.free = true;
   survivorPosition4.weapon = "snubnose";
   survivorPosition4.x = 650;
   survivorPosition4.y = 72;
   survivorPosition4.section = "section1";
   survivorSlot.push(survivorPosition1,survivorPosition2,survivorPosition3,survivorPosition4);
   for(x in survivorSlot)
   {
   }
}
function cleanUpSurvivors()
{
   for(v in survivorsOnScreen)
   {
      if(survivorsOnScreen[v].dead == true)
      {
         survivorSlot[survivorsOnScreen[v].slotNumber].free = true;
         for(x in friendliesOnScreen)
         {
            if(survivorsOnScreen[v].ref == friendliesOnScreen[x].ref)
            {
               friendliesOnScreen.splice(x,1);
            }
         }
         removeMovieClip(survivorsOnScreen[v].ref);
         survivorsOnScreen.splice(v,1);
      }
   }
}
function removeSurvivors()
{
   survivors = 0;
   for(v in survivorsOnScreen)
   {
      survivorSlot[survivorsOnScreen[v].slotNumber].free = true;
      removeMovieClip(survivorsOnScreen[v].ref);
      survivorsOnScreen.splice(v,1);
   }
}
function assignSurvivorWeapons()
{
   for(v in survivorsOnScreen)
   {
      _root.survivorsOnScreen[v].weapon = survivorSlot[survivorsOnScreen[v].slotNumber].weapon;
      _root.survivorsOnScreen[v].holdType = _root[survivorSlot[survivorsOnScreen[v].slotNumber].weapon].holdType;
      _root.survivorsOnScreen[v].ammo = _root[survivorSlot[survivorsOnScreen[v].slotNumber].weapon].magazineCapacity;
      _root.survivorsOnScreen[v].maxAmmo = _root[survivorSlot[survivorsOnScreen[v].slotNumber].weapon].magazineCapacity;
      _root.survivorsOnScreen[v].shotCounter = _root[survivorSlot[survivorsOnScreen[v].slotNumber].weapon].survivorRPM;
      _root.survivorsOnScreen[v].shotCounterMax = _root[survivorSlot[survivorsOnScreen[v].slotNumber].weapon].survivorRPM;
      _root.survivorsOnScreen[v].ref.gotoAndStop(1);
      _root.survivorsOnScreen[v].ref.helperMainGun.helperGun.gotoAndStop(survivorsOnScreen[v].weapon);
      _root.survivorsOnScreen[v].ref.helperMainGun.gotoAndStop(survivorsOnScreen[v].holdType);
      _root.survivorsOnScreen[v].running = false;
      _root.survivorsOnScreen[v].firing = false;
      _root.survivorsOnScreen[v].reloading = false;
   }
}
function setupSurvivors()
{
   v = 0;
   while(v <= survivorSlot.length)
   {
      if(survivorSlot[v].free == true && survivorOnScreenCount < survivors)
      {
         survivorSlot[v].free = false;
         survivorOnScreenCount++;
         survivorInc++;
         _root.attachMovie("survivorDummy","survivor" + survivorInc,survivorDepthCount + survivorSlot[v].y);
         _root["survivor" + survivorInc]._x = survivorSlot[v].x;
         _root["survivor" + survivorInc]._y = survivorSlot[v].y;
         _root["survivor" + survivorInc].reloading = false;
         randomTorsoColour = survivorTorsoColours[random(survivorTorsoColours.length)];
         _root["survivor" + survivorInc].helperMainGun.dummyHead.gotoAndStop("survivor_head" + random(10));
         _root["survivor" + survivorInc].helperMainGun.dummyFrontHand.attachMovie("survivorHand" + randomZombieTorso,"torso",x);
         _root["survivor" + survivorInc].helperMainGun.dummyBackHand.attachMovie("survivorHand" + randomZombieTorso,"torso",x);
         _root["survivor" + survivorInc].dummyHead.head.accessories.gotoAndStop(randomHeadAccessory);
         _root["survivor" + survivorInc].dummyTorso.torsoAddons.gotoAndStop(randomTorsoAccessory);
         _root["survivor" + survivorInc].dummyTorso.torso.colorTo(randomTorsoColour,0);
         _root["survivor" + survivorInc].helperMainGun.dummyFrontUpperArm.upperArm.colorTo(randomTorsoColour,0);
         _root["survivor" + survivorInc].helperMainGun.dummyFrontLowerArm.lowerArm.colorTo(randomTorsoColour,0);
         _root["survivor" + survivorInc].helperMainGun.dummyBackUpperArm.upperArm.colorTo(randomTorsoColour,0);
         _root["survivor" + survivorInc].helperMainGun.dummyBackLowerArm.lowerArm.colorTo(randomTorsoColour,0);
         randomLegColour = survivorLegColours[random(survivorLegColours.length)];
         _root["survivor" + survivorInc].dummyFrontUpperLeg.upperLeg.colorTo(randomLegColour,0);
         _root["survivor" + survivorInc].dummyFrontLowerLeg.lowerLeg.colorTo(randomLegColour,0);
         _root["survivor" + survivorInc].dummyBackUpperLeg.upperLeg.colorTo(randomLegColour,0);
         _root["survivor" + survivorInc].dummyBackLowerLeg.lowerLeg.colorTo(randomLegColour,0);
         survivorsOnScreen.push({ref:_root["survivor" + survivorInc],depth:_root["survivor" + survivorInc]._y,running:false,firing:false,reloading:false,dead:false,ammo:_root[survivorSlot[v].weapon].magazineCapacity,maxAmmo:_root[survivorSlot[v].weapon].magazineCapacity,weapon:survivorSlot[v].weapon,holdType:_root[survivorSlot[v].weapon].holdType,shotCounter:_root[survivorSlot[v].weapon].survivorRPM,shotCounterMax:_root[survivorSlot[v].weapon].survivorRPM,burstCounter:0,targetDiffX:1000,targetDiffY:1000,sectionName:survivorSlot[v].section,slotNumber:v});
         friendliesOnScreen.push({ref:_root["survivor" + survivorInc],depth:_root["survivor" + survivorInc]._y});
      }
      v++;
   }
}
function survivorFindTarget()
{
   findTargetTimer--;
   if(findTargetTimer < 0 && survivors > 0)
   {
      _root.survivorSection_1.occupied = false;
      _root.survivorSection_2.occupied = false;
      _root.survivorSection_3.occupied = false;
      findTargetTimer = findTargetTimerMax;
      i = 1;
      while(i <= 3)
      {
         for(z in aliveZombies)
         {
            if(aliveZombies[z].ref._x >= _root["survivorSection_" + i].startX && aliveZombies[z].ref._y >= _root["survivorSection_" + i].startY && aliveZombies[z].ref._y <= _root["survivorSection_" + i].endY)
            {
               _root["survivorSection_" + i].occupied = true;
            }
         }
         i++;
      }
   }
}
function survivorWeaponFire()
{
   v = 0;
   var _loc4_;
   var _loc3_;
   while(v <= survivorsOnScreen.length)
   {
      if(wall.health < 400 && survivorsOnScreen[v].running == false && survivorsOnScreen[v].dead == false)
      {
         survivorsOnScreen[v].running = true;
         survivorsOnScreen[v].ref.reloading = false;
         survivorsOnScreen[v].firing = false;
         survivorsOnScreen[v].ref.gotoAndPlay("runAway");
         survivorsOnScreen[v].ref.helperMainGun.gotoAndPlay("scared");
      }
      if(survivorsOnScreen[v].firing == false && survivorsOnScreen[v].ref.reloading == false && survivorsOnScreen[v].dead == false && survivorsOnScreen[v].running == false)
      {
         survivorsOnScreen[v].shotCounter--;
         if(survivorsOnScreen[v].ammo > 0 && survivorsOnScreen[v].shotCounter < 0)
         {
            i = 0;
            while(i <= 3)
            {
               if(survivorsOnScreen[v].sectionName == _root["survivorSection_" + i].name && _root["survivorSection_" + i].occupied == true)
               {
                  survivorsOnScreen[v].burstCounter--;
                  if(survivorsOnScreen[v].burstCounter < 5)
                  {
                     if(survivorsOnScreen[v].burstCounter < 0)
                     {
                        survivorsOnScreen[v].burstCounter = 45 - survivorsOnScreen[v].shotCounterMax;
                     }
                     firingHelperSound = new Sound(survivorsOnScreen[v].ref);
                     firingHelperSound.attachSound("sound_" + survivorsOnScreen[v].weapon + "Fire");
                     firingHelperSound.setVolume(40);
                     firingHelperSound.start(0,1);
                     survivorsOnScreen[v].firing = true;
                     survivorsOnScreen[v].shotCounter = survivorsOnScreen[v].shotCounterMax + random(survivorsOnScreen[v].shotCounterMax) / 2;
                     bullet++;
                     survivorsOnScreen[v].ref.helperMainGun.helperGun.muzzleFlash.play();
                     _loc4_ = new Object();
                     _loc4_.x = survivorsOnScreen[v].ref.helperMainGun.helperGun.barrelEnd._x + random(30);
                     _loc4_.y = survivorsOnScreen[v].ref.helperMainGun.helperGun.barrelEnd._y - 15;
                     survivorsOnScreen[v].ref.helperMainGun.localToGlobal(_loc4_);
                     survivorsOnScreen[v].ammo--;
                     _loc3_ = _root.attachMovie("round","helperRound" + bullet,bullet + 100);
                     _loc3_.gotoAndStop("off");
                     _loc3_._x = _loc4_.x;
                     _loc3_._y = _loc4_.y;
                     _loc3_.angle = random(8) - 4;
                     _loc3_._rotation = _loc3_.angle;
                     _loc3_.onEnterFrame = function()
                     {
                        this._x -= 90;
                     };
                     if(survivorsOnScreen[v].weapon == "shotgun" || survivorsOnScreen[v].weapon == "sawnOff")
                     {
                        roundsOnScreen.push({ref:_root["helperRound" + bullet],damage:_root[survivorsOnScreen[v].weapon].survivorDamage,headShotDamage:_root[survivorsOnScreen[v].weapon].survivorHeadShotDamage,owner:"helper"});
                     }
                     else
                     {
                        roundsOnScreen.push({ref:_root["helperRound" + bullet],damage:_root[survivorsOnScreen[v].weapon].damage,headShotDamage:_root[survivorsOnScreen[v].weapon].headShotDamage,owner:"helper"});
                     }
                     survivorsOnScreen[v].ref.helperMainGun.gotoAndPlay(survivorsOnScreen[v].holdType + "_fire");
                     survivorsOnScreen[v].firing = false;
                  }
                  if(survivorsOnScreen[v].ammo <= 0 && survivorsOnScreen[v].ref.reloading == false && survivorsOnScreen[v].firing == false)
                  {
                     survivorsOnScreen[v].ref.helperMainGun.gotoAndPlay(survivorsOnScreen[v].holdType + "_reload");
                     survivorsOnScreen[v].ammo = survivorsOnScreen[v].maxAmmo;
                  }
               }
               i++;
            }
         }
      }
      v++;
   }
}
function checkHitsOnSurvivors()
{
   var _loc1_;
   for(s in survivorsOnScreen)
   {
      for(v in aliveZombies)
      {
         if(aliveZombies[v].armed == true && survivorsOnScreen[s].dead == false)
         {
            aliveZombies[v].targetYDiff = aliveZombies[v].ref._y - 60 - survivorsOnScreen[s].ref._y;
            if(aliveZombies[v].targetYDiff <= 20 && aliveZombies[v].targetYDiff >= -20)
            {
               if(aliveZombies[v].ref.dummyFrontHand.frontHand.accessories.weapon.collision.hitTest(survivorsOnScreen[s].ref.collision))
               {
                  _loc1_ = new Object();
                  _loc1_.x = survivorsOnScreen[s].ref.collision._x;
                  _loc1_.y = survivorsOnScreen[s].ref.collision._y;
                  survivorsOnScreen[s].ref.collision.localToGlobal(_loc1_);
                  survivorBloodParticle(_loc1_.x,_loc1_.y);
                  survivorsOnScreen[s].dead = true;
                  survivors -= 1;
                  survivorOnScreenCount--;
                  survivorsOnScreen[s].ref.helperMainGun.gotoAndPlay("dead");
                  survivorsOnScreen[s].ref.gotoAndPlay("death");
                  killingHelperSound = new Sound(survivorsOnScreen[s].ref);
                  killingHelperSound.attachSound("sound_survivorHeadExplode");
                  killingHelperSound.setVolume(100);
                  killingHelperSound.start(0,1);
               }
            }
         }
      }
   }
}
function fadeAndChangeMusic()
{
   bgMusic.volumeTo(0,3,"linear",0,changeMusic);
}
function changeMusic()
{
   bgMusic.stop();
   bgMusicPlaying = true;
   bgMusic = new Sound(stageBG);
   bgMusic.attachSound("music_" + location[currentTownLocation].musicTrack);
   bgMusic.setVolume(0);
   bgMusic.start(0,999999);
   bgMusic.volumeTo(20,3);
}
function stopMusic()
{
   bgMusicPlaying = false;
   _root.bgMusic.stop();
}
levelUp = 1;
clearBuildings();
var timerMax = 35;
var timerCount = timerMax;
var targetCount = 0;
var sunriseStarted = false;
testingWeapons = false;
allWeapons = new Array();
allWeapons.push("chainsaw","pistol","revolver","shotgun","barrett","huntingRifle","UZI","UMP","M4A1","AK47","sawnOff","M249","RPG","grenade","compoundBow");
snubnose = new Object();
snubnose.name = "snubnose";
snubnose.description = "snubnose revolver";
snubnose.fireMode = "semi";
snubnose.weaponGroup = "pistol";
snubnose.holdType = "handgun";
snubnose.damage = 5;
snubnose.headShotDamage = 10;
snubnose.weaponRPM = 200;
snubnose.survivorRPM = 6;
snubnose.roundSpeed = 120;
snubnose.reloadTime = 2280;
snubnose.reloadType = "auto";
snubnose.magazineCapacity = 6;
snubnose.shotsPerRound = 1;
snubnose.recoil = 4;
snubnose.casingEject = false;
snubnose.showTracers = true;
snubnose.accuracy = 8;
snubnose.powerRating = 2;
snubnose.inUse = false;
pistol = new Object();
pistol.name = "pistol";
pistol.description = ".45 Pistol";
pistol.weaponGroup = "pistol";
pistol.holdType = "handgun";
pistol.fireMode = "semi";
pistol.damage = 5;
pistol.headShotDamage = 8;
pistol.weaponRPM = 200;
pistol.survivorRPM = 7;
pistol.roundSpeed = 120;
pistol.reloadTime = 1000;
pistol.reloadType = "auto";
pistol.pumpWeapon = true;
pistol.pumpTime = 125;
pistol.magazineCapacity = 17;
pistol.shotsPerRound = 1;
pistol.recoil = 4;
pistol.casingEject = true;
pistol.showTracers = true;
pistol.accuracy = 3;
pistol.powerRating = 3;
pistol.inUse = true;
revolver = new Object();
revolver.name = "revolver";
revolver.description = ".357 Revolver";
revolver.fireMode = "semi";
revolver.weaponGroup = "pistol";
revolver.holdType = "handgun";
revolver.damage = 10;
revolver.headShotDamage = 30;
revolver.weaponRPM = 200;
revolver.survivorRPM = 8;
revolver.roundSpeed = 120;
revolver.reloadTime = 2280;
revolver.reloadType = "auto";
revolver.pumpWeapon = true;
revolver.pumpTime = 425;
revolver.magazineCapacity = 6;
revolver.shotsPerRound = 1;
revolver.recoil = 8;
revolver.casingEject = false;
revolver.showTracers = true;
revolver.accuracy = 3;
revolver.powerRating = 5;
revolver.inUse = false;
UMP = new Object();
UMP.name = "UMP";
UMP.description = "UMP 45";
UMP.fireMode = "auto";
UMP.weaponGroup = "pistol";
UMP.holdType = "rifle";
UMP.damage = 3;
UMP.headShotDamage = 4;
UMP.weaponRPM = 75;
UMP.survivorRPM = 3;
UMP.roundSpeed = 120;
UMP.reloadTime = 1800;
UMP.reloadType = "auto";
UMP.magazineCapacity = 25;
UMP.shotsPerRound = 1;
UMP.recoil = 3;
UMP.casingEject = true;
UMP.showTracers = true;
UMP.accuracy = 3;
UMP.recoilAnimated = true;
UMP.recoiling = false;
UMP.powerRating = 7;
UMP.inUse = false;
UZI = new Object();
UZI.name = "UZI";
UZI.description = "UZI";
UZI.fireMode = "auto";
UZI.weaponGroup = "pistol";
UZI.holdType = "handgun";
UZI.damage = 2.5;
UZI.headShotDamage = 3;
UZI.weaponRPM = 60;
UZI.survivorRPM = 2;
UZI.roundSpeed = 120;
UZI.reloadTime = 1800;
UZI.reloadType = "auto";
UZI.magazineCapacity = 50;
UZI.shotsPerRound = 1;
UZI.recoil = 5;
UZI.casingEject = true;
UZI.showTracers = true;
UZI.accuracy = 6;
UZI.powerRating = 8;
UZI.inUse = false;
huntingRifle = new Object();
huntingRifle.name = "huntingRifle";
huntingRifle.description = "HUNTING RIFLE";
huntingRifle.weaponGroup = "rifle";
huntingRifle.holdType = "rifle";
huntingRifle.fireMode = "semi";
huntingRifle.damage = 30;
huntingRifle.headShotDamage = 40;
huntingRifle.weaponRPM = 500;
huntingRifle.survivorRPM = 40;
huntingRifle.roundSpeed = 150;
huntingRifle.reloadTime = 1800;
huntingRifle.penetrates = true;
huntingRifle.goesThrough = 2;
huntingRifle.pumpWeapon = false;
huntingRifle.pumpTime = 800;
huntingRifle.reloadType = "auto";
huntingRifle.magazineCapacity = 1;
huntingRifle.shotsPerRound = 1;
huntingRifle.accuracy = 0;
huntingRifle.casingEject = true;
huntingRifle.showTracers = true;
huntingRifle.recoil = 10;
huntingRifle.powerRating = 10;
huntingRifle.inUse = false;
barrett = new Object();
barrett.name = "barrett";
barrett.description = "BARRETT";
barrett.weaponGroup = "rifle";
barrett.fireMode = "semi";
barrett.damage = 40;
barrett.headShotDamage = 100;
barrett.weaponRPM = 500;
barrett.roundSpeed = 150;
barrett.reloadTime = 1800;
barrett.penetrates = true;
barrett.goesThrough = 5;
barrett.pumpWeapon = true;
barrett.pumpTime = 1200;
barrett.reloadType = "auto";
barrett.magazineCapacity = 10;
barrett.shotsPerRound = 1;
barrett.accuracy = 1;
barrett.casingEject = true;
barrett.showTracers = true;
barrett.recoil = 10;
sawnOff = new Object();
sawnOff.name = "sawnOff";
sawnOff.description = "Sawn-off shotgun";
sawnOff.fireMode = "semi";
sawnOff.weaponGroup = "shotgun";
sawnOff.holdType = "handgun";
sawnOff.damage = 5;
sawnOff.headShotDamage = 7;
sawnOff.survivorDamage = 30;
sawnOff.survivorHeadShotDamage = 42;
sawnOff.weaponRPM = 500;
sawnOff.roundSpeed = 120;
sawnOff.reloadTime = 2000;
sawnOff.reloadType = "manual";
sawnOff.pumpWeapon = true;
sawnOff.pumpTime = 400;
sawnOff.magazineCapacity = 2;
sawnOff.shotsPerRound = 6;
sawnOff.accuracy = 15;
sawnOff.casingEject = true;
sawnOff.showTracers = true;
sawnOff.recoil = 8;
sawnOff.survivorRPM = 12;
sawnOff.inUse = false;
shotgun = new Object();
shotgun.name = "shotgun";
shotgun.description = "shotgun";
shotgun.fireMode = "semi";
shotgun.weaponGroup = "shotgun";
shotgun.holdType = "rifle";
shotgun.damage = 3.5;
shotgun.headShotDamage = 2.5;
shotgun.survivorDamage = 30;
shotgun.survivorHeadShotDamage = 42;
shotgun.weaponRPM = 500;
shotgun.roundSpeed = 120;
shotgun.reloadTime = 700;
shotgun.reloadType = "manual";
shotgun.pumpWeapon = true;
shotgun.pumpTime = 700;
shotgun.magazineCapacity = 8;
shotgun.shotsPerRound = 8;
shotgun.accuracy = 5;
shotgun.casingEject = true;
shotgun.showTracers = true;
shotgun.recoil = 5;
shotgun.survivorRPM = 15;
shotgun.inUse = false;
autoShotgun = new Object();
autoShotgun.name = "autoShotgun";
autoShotgun.description = "Auto Shotgun";
autoShotgun.fireMode = "auto";
autoShotgun.weaponGroup = "shotgun";
autoShotgun.damage = 7;
autoShotgun.headShotDamage = 7;
autoShotgun.weaponRPM = 250;
autoShotgun.roundSpeed = 120;
autoShotgun.reloadTime = 700;
autoShotgun.reloadType = "automatic";
autoShotgun.pumpWeapon = false;
autoShotgun.pumpTime = 700;
autoShotgun.magazineCapacity = 12;
autoShotgun.shotsPerRound = 3;
autoShotgun.accuracy = 5;
autoShotgun.casingEject = true;
autoShotgun.showTracers = true;
autoShotgun.recoil = 5;
autoShotgun.recoilAnimated = true;
autoShotgun.recoiling = false;
M4A1 = new Object();
M4A1.name = "M4A1";
M4A1.description = "M4A1";
M4A1.fireMode = "auto";
M4A1.weaponGroup = "rifle";
M4A1.holdType = "rifle";
M4A1.damage = 3.25;
M4A1.headShotDamage = 5.5;
M4A1.weaponRPM = 90;
M4A1.survivorRPM = 3;
M4A1.roundSpeed = 150;
M4A1.reloadTime = 1800;
M4A1.reloadType = "auto";
M4A1.magazineCapacity = 30;
M4A1.shotsPerRound = 1;
M4A1.accuracy = 3;
M4A1.casingEject = true;
M4A1.showTracers = true;
M4A1.recoil = 5;
M4A1.recoilAnimated = true;
M4A1.recoiling = false;
M4A1.powerRating = 12;
M4A1.inUse = false;
AK47 = new Object();
AK47.name = "AK47";
AK47.description = "AK47";
AK47.fireMode = "auto";
AK47.weaponGroup = "rifle";
AK47.holdType = "rifle";
AK47.damage = 4.5;
AK47.headShotDamage = 5.5;
AK47.weaponRPM = 101;
AK47.survivorRPM = 3;
AK47.roundSpeed = 120;
AK47.reloadTime = 1800;
AK47.reloadType = "auto";
AK47.magazineCapacity = 30;
AK47.shotsPerRound = 1;
AK47.accuracy = 5;
AK47.casingEject = true;
AK47.showTracers = true;
AK47.recoil = 8;
AK47.recoilAnimated = true;
AK47.recoiling = false;
AK47.powerRating = 15;
AK47.inUse = false;
M249 = new Object();
M249.name = "M249";
M249.description = "M249 Minimi";
M249.fireMode = "auto";
M249.weaponGroup = "rifle";
M249.holdType = "rifle";
M249.recoilAnimated = true;
M249.recoiling = false;
M249.damage = 3.5;
M249.headShotDamage = 4;
M249.weaponRPM = 90;
M249.survivorRPM = 3;
M249.roundSpeed = 120;
M249.reloadTime = 3600;
M249.reloadType = "auto";
M249.magazineCapacity = 200;
M249.shotsPerRound = 1;
M249.accuracy = 8;
M249.casingEject = true;
M249.showTracers = true;
M249.recoil = 8;
M249.powerRating = 13;
M249.inUse = false;
grenade = new Object();
grenade.name = "grenade";
grenade.type = "explosive";
grenade.description = "HAND GRENADES";
grenade.fireMode = "thrown";
grenade.damage = 90;
grenade.headShotDamage = 90;
grenade.weaponRPM = 90;
grenade.frags = 10;
grenade.fragDistance = 150;
grenade.roundSpeed = 90;
grenade.reloadTime = 1700;
grenade.reloadType = "auto";
grenade.magazineCapacity = 1;
grenade.shotsPerRound = 1;
grenade.timer = 25;
grenade.inUse = false;
chainsaw = new Object();
chainsaw.name = "chainsaw";
chainsaw.description = "CHAINSAW";
chainsaw.fireMode = "auto";
chainsaw.weaponGroup = "rifle";
chainsaw.damage = 8;
chainsaw.headShotDamage = 12;
chainsaw.weaponRPM = 150;
chainsaw.roundSpeed = 80;
chainsaw.reloadTime = 1000;
chainsaw.reloadType = "auto";
chainsaw.magazineCapacity = 50;
chainsaw.shotsPerRound = 1;
chainsaw.accuracy = 0;
chainsaw.type = "melee";
chainsaw.range = 120;
chainsaw.casingEject = false;
chainsaw.showTracers = true;
chainsaw.recoil = 0;
chainsaw.inUse = false;
var roundsBeforeBurn = 10;
flameThrower = new Object();
flameThrower.name = "flameThrower";
flameThrower.description = "FLAMETHROWER";
flameThrower.fireMode = "auto";
flameThrower.weaponGroup = "rifle";
flameThrower.damage = 1;
flameThrower.headShotDamage = 1;
flameThrower.weaponRPM = 20;
flameThrower.roundSpeed = 80;
flameThrower.reloadTime = 1000;
flameThrower.reloadType = "auto";
flameThrower.magazineCapacity = 1000;
flameThrower.shotsPerRound = 1;
flameThrower.accuracy = 0;
flameThrower.type = "melee";
flameThrower.range = 130;
flameThrower.penetrates = false;
flameThrower.casingEject = false;
flameThrower.showTracers = false;
flameThrower.recoil = 0;
RPG = new Object();
RPG.name = "RPG";
RPG.description = "RPG";
RPG.fireMode = "semi";
RPG.weaponGroup = "impactExplosives";
RPG.damage = 100;
RPG.headShotDamage = 100;
RPG.weaponRPM = 150;
RPG.roundSpeed = 120;
RPG.reloadTime = 800;
RPG.reloadType = "auto";
RPG.magazineCapacity = 1;
RPG.shotsPerRound = 1;
RPG.accuracy = 0;
RPG.type = "impactExplosive";
RPG.range = 120;
RPG.penetrates = false;
RPG.casingEject = false;
RPG.showTracers = true;
RPG.recoil = 0;
RPG.inUse = false;
compoundBow = new Object();
compoundBow.description = "Compound Bow";
compoundBow.name = "compoundBow";
compoundBow.fireMode = "semi";
compoundBow.weaponGroup = "bow";
compoundBow.damage = 15;
compoundBow.explodeDamage = 0;
compoundBow.headShotDamage = 30;
compoundBow.weaponRPM = 150;
compoundBow.roundSpeed = 80;
compoundBow.reloadTime = 800;
compoundBow.reloadType = "auto";
compoundBow.magazineCapacity = 1;
compoundBow.shotsPerRound = 1;
compoundBow.accuracy = 5;
compoundBow.penetrates = false;
compoundBow.casingEject = false;
compoundBow.showTracers = true;
compoundBow.recoil = 0;
compoundBow.inUse = false;
snubnose.found = false;
pistol.found = true;
revolver.found = false;
huntingRifle.found = false;
chainsaw.found = false;
shotgun.found = false;
sawnOff.found = false;
grenade.found = false;
UMP.found = false;
UZI.found = false;
M4A1.found = false;
AK47.found = false;
M249.found = false;
barrett.found = false;
compoundBow.found = false;
RPG.found = false;
if(testingWeapons == true)
{
   snubnose.found = true;
   pistol.found = true;
   revolver.found = true;
   huntingRifle.found = true;
   chainsaw.found = true;
   shotgun.found = true;
   sawnOff.found = true;
   grenade.found = true;
   UMP.found = true;
   UZI.found = true;
   M4A1.found = true;
   AK47.found = true;
   M249.found = true;
   barrett.found = true;
   compoundBow.found = true;
   RPG.found = true;
}
var trapNumber = 0;
var currentSelectedTrap = "empty";
var trapMapOpen = false;
var total_gasCylinder = 0;
var total_mine = 0;
var total_bearTrap = 0;
activeTraps = new Array();
trapLocations = new Array();
gasCylinder = new Object();
gasCylinder.name = "gasCylinder";
gasCylinder.description = "GAS CYLINDER";
gasCylinder.health = 5;
gasCylinder.damage = 400;
gasCylinder.range = 120;
mine = new Object();
mine.name = "mine";
mine.description = "LAND MINE";
mine.health = 0;
mine.damage = 800;
mine.range = 90;
bearTrap = new Object();
bearTrap.name = "bearTrap";
bearTrap.description = "BEAR TRAP";
bearTrap.health = 0;
bearTrap.damage = 0;
bearTrap.range = 0;
trapSpot0 = new Object();
trapSpot0.x = 80;
trapSpot0.y = 130;
trapSpot1 = new Object();
trapSpot1.x = 200;
trapSpot1.y = 136;
trapSpot2 = new Object();
trapSpot2.x = 320;
trapSpot2.y = 135;
trapSpot3 = new Object();
trapSpot3.x = 440;
trapSpot3.y = 132;
trapSpot4 = new Object();
trapSpot4.x = 560;
trapSpot4.y = 131;
trapSpot5 = new Object();
trapSpot5.x = 75;
trapSpot5.y = 180;
trapSpot6 = new Object();
trapSpot6.x = 195;
trapSpot6.y = 181;
trapSpot7 = new Object();
trapSpot7.x = 322;
trapSpot7.y = 183;
trapSpot8 = new Object();
trapSpot8.x = 445;
trapSpot8.y = 188;
trapSpot9 = new Object();
trapSpot9.x = 562;
trapSpot9.y = 180;
trapSpot10 = new Object();
trapSpot10.x = 75;
trapSpot10.y = 235;
trapSpot11 = new Object();
trapSpot11.x = 196;
trapSpot11.y = 236;
trapSpot12 = new Object();
trapSpot12.x = 325;
trapSpot12.y = 238;
trapSpot13 = new Object();
trapSpot13.x = 440;
trapSpot13.y = 234;
trapSpot14 = new Object();
trapSpot14.x = 557;
trapSpot14.y = 237;
trapSpot15 = new Object();
trapSpot15.x = 75;
trapSpot15.y = 301;
trapSpot16 = new Object();
trapSpot16.x = 190;
trapSpot16.y = 300;
trapSpot17 = new Object();
trapSpot17.x = 322;
trapSpot17.y = 302;
trapSpot18 = new Object();
trapSpot18.x = 439;
trapSpot18.y = 309;
trapSpot19 = new Object();
trapSpot19.x = 560;
trapSpot19.y = 300;
trapLocationObjects();
updateTrapMapText();
timeManager._visible = false;
blackOut._visible = false;
timeManagerOpen = false;
nextWeaponPoint = 1;
retryLevel = false;
var beenHere = true;
var previousTownLocation = "";
repairRate = 505;
hoursInDay = 12;
hoursSpentRepairingWall = 0;
hoursSpentWeapons = 0;
hoursSpentSurvivors = 0;
survivorsFound = 0;
foundSurvivors = 0;
foundWeaponsTotal = 1;
searchPartyMembersKilled = 0;
debugDay = 0;
searchFoundAWeapon = 0;
var supplies = 0;
var suppliesFound = 0;
var hoursSpentSupplies = 0;
var scroungedSupplies = 0;
var allTownLocations = new Array("glenDale","claysBurg","whistlersGrove","aspenWood","jonesTown","armyBase","unionCity");
var currentTownLocation = "glenDale";
location = new Object();
location.armyBase = new Object();
location.armyBase.ref = "armyBase";
location.armyBase.name = "FORT TRAN";
location.armyBase.description = "The small Army base where I arrived in this area.";
location.armyBase.population = "Unknown";
location.armyBase.destinations = ["jonesTown","unionCity"];
location.armyBase.journalHeading = "FORT TRAN";
location.armyBase.journalText = "I ASSUME THIS IS WHERE THE CHOPPER WAS SUPPOSED TO BE HEADED.\r\rIT\'S BEEN COMPLETELY OVERRUN, MANAGED STILL TO PULL TOGETHER SOME SANDBAGS TO PUT TOGETHER A STURDY WALL THOUGH.";
location.armyBase.weaponsBuildings = [{ref:"weaponsPlace0",name:"WEAPON STORAGE",searchTime:2,hasItem:"empty"},{ref:"weaponsPlace1",name:"POLICE STATION",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace2",name:"GUN SHOP",searchTime:5,hasItem:"empty"}];
location.armyBase.weapons = ["RPG","M249","empty"];
location.armyBase.survivorsBuildings = [{ref:"survivorsPlace0",name:"MEDICAL CLINIC",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace1",name:"HOUSE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace2",name:"TOWN HALL",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace3",name:"HOUSE",searchTime:3,hasItem:"empty"}];
location.armyBase.survivors = ["mine","mine","mine","bearTrap"];
location.armyBase.suppliesBuildings = [{ref:"suppliesPlace0",name:"STORE",searchTime:3,hasItem:"empty"},{ref:"suppliesPlace1",name:"SMALL STORE",searchTime:3,hasItem:"empty"}];
location.armyBase.supplies = ["supplies2","supplies2"];
location.armyBase.maxWallHealth = 5000;
location.armyBase.zombieThreat = 8;
location.armyBase.semiRareZombieChance = 20;
location.armyBase.rareZombieChance = 5;
location.armyBase.veryRareZombieChance = 1;
location.armyBase.armedZombieChance = 0;
location.armyBase.levelTime = 30;
location.armyBase.gunLevel = 1;
location.armyBase.supplyLevel = 1;
location.armyBase.survivorLevel = 1;
location.armyBase.numSpawnZones = 1;
location.armyBase.spawnZone0_min = 120;
location.armyBase.spawnZone0_max = 300;
location.armyBase.brightnessLevelZombies = 60;
location.armyBase.brightnessLevelHero = 70;
location.armyBase.travelledTo = false;
location.glenDale = new Object();
location.glenDale.ref = "glenDale";
location.glenDale.name = "GLENDALE";
location.glenDale.description = "A rural town.";
location.glenDale.population = "20,420";
location.glenDale.journalHeading = "40 DAYS";
location.glenDale.journalText = "IT\'S BEEN A MONTH. BACK AT SQUARE ONE. THE CRASH STILL HAUNTS ME. THEY\'RE STILL EVERYWHERE\r\rRADIO BROADCAST SAID TODAY THAT THEY\'RE SEALING OFF THE MAINLAND.\r\r40 DAYS UNTIL THE LAST BOATS AND AIRCRAFT LEAVE. GOT TO MAKE IT TO UNION CITY.";
location.glenDale.destinations = ["claysBurg","whistlersGrove"];
location.glenDale.weaponsBuildings = [{ref:"weaponsPlace0",name:"SHERRIF\'S OFFICE",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace1",name:"QUICKSTOP",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace2",name:"HOUSE",searchTime:4,hasItem:"empty"},{ref:"weaponsPlace3",name:"HOUSE",searchTime:4,hasItem:"empty"}];
location.glenDale.weapons = ["empty","chainsaw","empty","revolver"];
location.glenDale.survivorsBuildings = [{ref:"survivorsPlace0",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace1",name:"CHURCH",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace2",name:"PARK",searchTime:3,hasItem:"empty"}];
location.glenDale.survivors = ["bearTrap","gasCylinder","supplies"];
location.glenDale.suppliesBuildings = [{ref:"suppliesPlace0",name:"OLD HOUSE",searchTime:5,hasItem:"empty"},{ref:"suppliesPlace1",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"suppliesPlace2",name:"SUPERMARKET",searchTime:4,hasItem:"empty"},{ref:"suppliesPlace3",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"suppliesPlace4",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"suppliesPlace5",name:"BIG HOUSE",searchTime:4,hasItem:"empty"}];
location.glenDale.supplies = ["supplies","supplies","supplies","survivor","survivor","empty"];
location.glenDale.maxWallHealth = 8000;
location.glenDale.zombieThreat = 4.5;
location.glenDale.commonZombieChance = 80;
location.glenDale.semiRareZombieChance = 40;
location.glenDale.rareZombieChance = 20;
location.glenDale.veryRareZombieChance = 0;
location.glenDale.armedZombieChance = 0;
location.glenDale.levelTime = 25;
location.glenDale.gunLevel = 0.5;
location.glenDale.supplyLevel = 1.2;
location.glenDale.survivorLevel = 0.5;
location.glenDale.numSpawnZones = 1;
location.glenDale.spawnZone0_min = 160;
location.glenDale.spawnZone0_max = 220;
location.glenDale.brightnessLevelZombies = 40;
location.glenDale.brightnessLevelHero = 50;
location.glenDale.travelledTo = false;
location.whistlersGrove = new Object();
location.whistlersGrove.ref = "whistlersGrove";
location.whistlersGrove.name = "WHISTLER\'S GROVE";
location.whistlersGrove.description = "Just another small rural town.";
location.whistlersGrove.population = "10,913";
location.whistlersGrove.journalHeading = "WHISTLERS GROVE";
location.whistlersGrove.journalText = "BASEMENTS. NOT A FAN BUT IT\'S A NECESSITY AT THE MOMENT.\r\rBUILT A CRUDE BARRICADE UPSTAIRS TO HOLD THEM OFF TONIGHT, SHOULD DO THE TRICK. DON\'T HAVE MUCH TIME OR ENERGY TO BUILD ANYTHING SUBSTANTIAL.\r\rBEST BET IS TO FIND WHAT I CAN AND KEEP MOVING TOWARDS UNION CITY.";
location.whistlersGrove.destinations = ["glenDale","claysBurg","aspenWood"];
location.whistlersGrove.weaponsBuildings = [{ref:"weaponsPlace0",name:"HALL",searchTime:4,hasItem:"empty"},{ref:"weaponsPlace1",name:"STORE",searchTime:4,hasItem:"empty"},{ref:"weaponsPlace2",name:"BIG HOUSE",searchTime:5,hasItem:"empty"},{ref:"weaponsPlace3",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace4",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace5",name:"HOUSE",searchTime:4,hasItem:"empty"},{ref:"weaponsPlace6",name:"HOUSE",searchTime:4,hasItem:"empty"}];
location.whistlersGrove.weapons = ["shotgun","compoundBow","empty","empty","empty","empty","empty"];
location.whistlersGrove.survivorsBuildings = [{ref:"survivorsPlace0",name:"RUNDOWN HOUSE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace1",name:"HOUSE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace2",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace3",name:"MEDICAL CENTRE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace4",name:"HOUSE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace5",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace6",name:"HOUSE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace7",name:"HOUSE",searchTime:3,hasItem:"empty"}];
location.whistlersGrove.survivors = ["survivor","supplies","gasCylinder","bearTrap","empty","survivor","supplies2","empty"];
location.whistlersGrove.suppliesBuildings = [{ref:"suppliesPlace0",name:"STORE",searchTime:4,hasItem:"empty"},{ref:"suppliesPlace1",name:"CORNER STORE",searchTime:3,hasItem:"empty"}];
location.whistlersGrove.supplies = ["supplies","supplies"];
location.whistlersGrove.maxWallHealth = 6000;
location.whistlersGrove.zombieThreat = 6;
location.whistlersGrove.commonZombieChance = 80;
location.whistlersGrove.semiRareZombieChance = 30;
location.whistlersGrove.rareZombieChance = 15;
location.whistlersGrove.veryRareZombieChance = 5;
location.whistlersGrove.armedZombieChance = 25;
location.whistlersGrove.levelTime = 35;
location.whistlersGrove.gunLevel = 0.75;
location.whistlersGrove.supplyLevel = 1;
location.whistlersGrove.survivorLevel = 0.75;
location.whistlersGrove.numSpawnZones = 1;
location.whistlersGrove.spawnZone0_min = 160;
location.whistlersGrove.spawnZone0_max = 215;
location.whistlersGrove.brightnessLevelZombies = 40;
location.whistlersGrove.brightnessLevelHero = 50;
location.whistlersGrove.travelledTo = false;
location.claysBurg = new Object();
location.claysBurg.ref = "claysBurg";
location.claysBurg.name = "CLAYSBURG";
location.claysBurg.description = "Larger rural centre, large industry.";
location.claysBurg.population = "60,044";
location.claysBurg.destinations = ["glenDale","whistlersGrove","aspenWood"];
location.claysBurg.weaponsBuildings = [{ref:"weaponsPlace0",name:"GAS STATION",searchTime:4,hasItem:"empty"},{ref:"weaponsPlace1",name:"7/11",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace2",name:"POLICE STATION",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace3",name:"HOUSE",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace4",name:"GUN STORE",searchTime:4,hasItem:"empty"}];
location.claysBurg.journalHeading = "HOLY GROUND";
location.claysBurg.journalText = "HAH! DON\'T THINK IT\'LL MAKE A DIFFERENCE TO THEM, THE BASTARDS, THE PEWS MAKE A FAIRLY DECENT BARRICADE THOUGH.\r\rA LOT OF STORES AROUND HERE, HOPEFULLY I CAN DIG UP SOME SUPPLIES.\r\rNOTE: I\'VE SEEN A NUMBER OF THEM CARRYING WEAPONS, COULD GET NASTY.";
location.claysBurg.weapons = ["empty","UMP","empty","empty","UZI"];
location.claysBurg.survivorsBuildings = [{ref:"survivorsPlace0",name:"DEPT.STORE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace1",name:"DRESS SHOP",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace2",name:"SHOE SHOP",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace3",name:"HANDBAGS",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace4",name:"STORE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace5",name:"APARTMENT",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace6",name:"OFFICE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace7",name:"APARTMENTS",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace8",name:"LARGE STORE",searchTime:5,hasItem:"empty"},{ref:"survivorsPlace9",name:"APARTMENT",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace10",name:"STORE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace11",name:"STORE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace12",name:"WAREHOUSE",searchTime:5,hasItem:"empty"}];
location.claysBurg.survivors = ["survivor","supplies","empty","supplies2","survivor","bearTrap","empty","gasCylinder","empty","bearTrap","empty","survivor","empty"];
location.claysBurg.suppliesBuildings = [{ref:"suppliesPlace0",name:"BLANK",searchTime:4,hasItem:"empty"},{ref:"suppliesPlace1",name:"BLANK",searchTime:4,hasItem:"empty"}];
location.claysBurg.supplies = ["supplies","empty"];
location.claysBurg.maxWallHealth = 5500;
location.claysBurg.zombieThreat = 6;
location.claysBurg.commonZombieChance = 80;
location.claysBurg.semiRareZombieChance = 35;
location.claysBurg.rareZombieChance = 10;
location.claysBurg.veryRareZombieChance = 4;
location.claysBurg.armedZombieChance = 20;
location.claysBurg.levelTime = 40;
location.claysBurg.gunLevel = 1.25;
location.claysBurg.supplyLevel = 1.5;
location.claysBurg.survivorLevel = 0.5;
location.claysBurg.numSpawnZones = 1;
location.claysBurg.spawnZone0_min = 120;
location.claysBurg.spawnZone0_max = 300;
location.claysBurg.brightnessLevelZombies = 50;
location.claysBurg.brightnessLevelHero = 55;
location.claysBurg.travelledTo = false;
location.aspenWood = new Object();
location.aspenWood.ref = "aspenWood";
location.aspenWood.name = "ASPENWOOD";
location.aspenWood.description = "Farmland on the outskirts of Jonestown.";
location.aspenWood.population = "1040";
location.aspenWood.destinations = ["jonesTown","whistlersGrove","claysBurg"];
location.aspenWood.journalHeading = "MIDDLE OF NOWHERE";
location.aspenWood.journalText = "HAVEN\'T HEARD ANYTHING MORE ON THE RADIO ABOUT THE EVACUATION, CAN ONLY HOPE THEY STICK TO THEIR TIMEFRAME.\r\rDON\'T LIKE MY CHANCES OF FINDING MUCH HERE, BEST TO GET WHAT I CAN AND KEEP MOVING.\r\rUNION CITY OR BUST.";
location.aspenWood.weaponsBuildings = [{ref:"weaponsPlace0",name:"GAS STATION",searchTime:5,hasItem:"empty"},{ref:"weaponsPlace1",name:"STORE",searchTime:4,hasItem:"empty"},{ref:"weaponsPlace2",name:"STORE",searchTime:4,hasItem:"empty"},{ref:"weaponsPlace3",name:"SHERRIF\'S",searchTime:4,hasItem:"empty"}];
location.aspenWood.weapons = ["huntingRifle","empty","sawnOff","empty"];
location.aspenWood.survivorsBuildings = [{ref:"survivorsPlace0",name:"DINER",searchTime:5,hasItem:"empty"},{ref:"survivorsPlace1",name:"FARMHOUSE",searchTime:5,hasItem:"empty"},{ref:"survivorsPlace2",name:"FARMHOUSE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace3",name:"FARMHOUSE",searchTime:5,hasItem:"empty"},{ref:"survivorsPlace4",name:"OLD HOUSE",searchTime:5,hasItem:"empty"}];
location.aspenWood.survivors = ["survivors2","supplies2","bearTrap","mine","supplies2"];
location.aspenWood.suppliesBuildings = [{ref:"suppliesPlace0",name:"STORE",searchTime:4,hasItem:"empty"},{ref:"suppliesPlace1",name:"STORE",searchTime:4,hasItem:"empty"}];
location.aspenWood.supplies = ["supplies","supplies"];
location.aspenWood.maxWallHealth = 5000;
location.aspenWood.zombieThreat = 8;
location.aspenWood.commonZombieChance = 80;
location.aspenWood.semiRareZombieChance = 40;
location.aspenWood.rareZombieChance = 10;
location.aspenWood.veryRareZombieChance = 5;
location.aspenWood.armedZombieChance = 40;
location.aspenWood.levelTime = 45;
location.aspenWood.gunLevel = 2;
location.aspenWood.supplyLevel = 1;
location.aspenWood.survivorLevel = 1;
location.aspenWood.numSpawnZones = 1;
location.aspenWood.spawnZone0_min = 120;
location.aspenWood.spawnZone0_max = 300;
location.aspenWood.brightnessLevelZombies = 40;
location.aspenWood.brightnessLevelHero = 50;
location.aspenWood.travelledTo = false;
location.jonesTown = new Object();
location.jonesTown.ref = "jonesTown";
location.jonesTown.name = "JONESTOWN";
location.jonesTown.description = "There\'s something about this place.";
location.jonesTown.population = "100,027";
location.jonesTown.journalHeading = "LAST STOP";
location.jonesTown.journalText = "UNION CITY IS ONLY A FEW DAYS FROM HERE, BETTER HURRY. MISS THAT BOAT AND I GET THE FEELING IT\'S ALL OVER.";
location.jonesTown.destinations = ["unionCity","aspenWood","armyBase"];
location.jonesTown.weaponsBuildings = [{ref:"weaponsPlace0",name:"APARTMENT",searchTime:2,hasItem:"empty"},{ref:"weaponsPlace1",name:"SECURITY CO.",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace2",name:"STORE",searchTime:5,hasItem:"empty"},{ref:"weaponsPlace3",name:"STORE",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace4",name:"POLICE",searchTime:3,hasItem:"empty"}];
location.jonesTown.weapons = ["grenade","AK47","M4A1","empty","empty"];
location.jonesTown.survivorsBuildings = [{ref:"survivorsPlace0",name:"APARTMENT",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace1",name:"APARTMENT",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace2",name:"APARTMENT",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace3",name:"APARTMENT",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace4",name:"APARTMENT",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace5",name:"APARTMENT",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace6",name:"STORE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace7",name:"APARTMENT",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace8",name:"STORE",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace9",name:"APARTMENT",searchTime:3,hasItem:"empty"}];
location.jonesTown.survivors = ["survivor","supplies2","survivor","mine","empty","empty","gasCylinder","empty","bearTrap","empty"];
location.jonesTown.suppliesBuildings = [{ref:"suppliesPlace0",name:"STORE",searchTime:3,hasItem:"empty"},{ref:"suppliesPlace1",name:"CAMPING STORE",searchTime:3,hasItem:"empty"}];
location.jonesTown.supplies = ["supplies","supplies"];
location.jonesTown.maxWallHealth = 5000;
location.jonesTown.zombieThreat = 8;
location.jonesTown.commonZombieChance = 80;
location.jonesTown.semiRareZombieChance = 60;
location.jonesTown.rareZombieChance = 15;
location.jonesTown.veryRareZombieChance = 10;
location.jonesTown.armedZombieChance = 50;
location.jonesTown.levelTime = 50;
location.jonesTown.gunLevel = 1.25;
location.jonesTown.supplyLevel = 1.5;
location.jonesTown.survivorLevel = 0.5;
location.jonesTown.numSpawnZones = 1;
location.jonesTown.spawnZone0_min = 120;
location.jonesTown.spawnZone0_max = 300;
location.jonesTown.brightnessLevelZombies = 50;
location.jonesTown.brightnessLevelHero = 50;
location.jonesTown.travelledTo = false;
location.unionCity = new Object();
location.unionCity.ref = "unionCity";
location.unionCity.name = "UNION CITY";
location.unionCity.description = "The population is huge here, makes it dangerous.";
location.unionCity.population = "350,148";
location.unionCity.destinations = ["jonesTown"];
location.unionCity.weaponsBuildings = [{ref:"weaponsPlace0",name:"WEAPON STORAGE",searchTime:2,hasItem:"empty"},{ref:"weaponsPlace1",name:"POLICE STATION",searchTime:3,hasItem:"empty"},{ref:"weaponsPlace2",name:"GUN SHOP",searchTime:5,hasItem:"empty"}];
location.unionCity.weapons = ["revolver","empty","empty"];
location.unionCity.survivorsBuildings = [{ref:"survivorsPlace0",name:"MEDICAL CLINIC",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace1",name:"HOUSE",searchTime:4,hasItem:"empty"},{ref:"survivorsPlace2",name:"TOWN HALL",searchTime:3,hasItem:"empty"},{ref:"survivorsPlace3",name:"HOUSE",searchTime:3,hasItem:"empty"}];
location.unionCity.survivors = ["survivor","supplies","mine","mine"];
location.unionCity.suppliesBuildings = [{ref:"suppliesPlace0",name:"STORE",searchTime:3,hasItem:"empty"},{ref:"suppliesPlace1",name:"SMALL STORE",searchTime:3,hasItem:"empty"}];
location.unionCity.supplies = ["supplies","supplies"];
location.unionCity.maxWallHealth = 3000;
location.unionCity.zombieThreat = 20;
location.unionCity.commonZombieChance = 80;
location.unionCity.semiRareZombieChance = 60;
location.unionCity.rareZombieChance = 50;
location.unionCity.veryRareZombieChance = 20;
location.unionCity.armedZombieChance = 80;
location.unionCity.levelTime = 60;
location.unionCity.numSpawnZones = 1;
location.unionCity.spawnZone0_min = 120;
location.unionCity.spawnZone0_max = 300;
location.unionCity.brightnessLevelZombies = 60;
location.unionCity.brightnessLevelHero = 70;
location.unionCity.travelledTo = false;
var travelTime = 0;
var daysAtCurrentLocation = 0;
var currentTownLocation = "armyBase";
var currentTownTarget = "";
var validTravelDestination = false;
var validTownRollOver = false;
var canTravel = false;
var travelMapOpen = false;
var travelledLocations = new Array();
var townNameOverlays = 0;
var endingGame = false;
var tempFoundSurvivors = 0;
var tempFoundSupplies = 0;
var searchWeaponsFound = new Array();
var allWeaponsFound = new Array();
var survivors = 0;
var maxSurvivorsOnScreen = 5;
var survivorDepthCount = 350;
var survivorOnScreenCount = 0;
var survivorInc = 0;
var currentSurvivorBurstModeCount = 0;
var findTargetTimerMax = 100;
var findTargetTimer = findTargetTimerMax;
var survivorsOnScreen = new Array();
var friendliesOnScreen = new Array();
var survivorSlot = new Array();
var tempWeaponPower = new Array();
var survivorSection_1 = new Object();
survivorSection_1.name = "section1";
survivorSection_1.startY = 0;
survivorSection_1.endY = 230;
survivorSection_1.startX = 50;
survivorSection_1.occupied = false;
var survivorSection_2 = new Object();
survivorSection_2.name = "section2";
survivorSection_2.startY = 0;
survivorSection_2.endY = 0;
survivorSection_2.startX = 0;
survivorSection_2.occupied = false;
var survivorSection_3 = new Object();
survivorSection_3.name = "section3";
survivorSection_3.startY = 210;
survivorSection_3.endY = 420;
survivorSection_3.startX = 50;
survivorSection_3.occupied = false;
survivorTorsoColours = new Array("0x53552F","0x993333","0x333333","0x996600","0x888888","0x4E462C","0x3A4958","0x3E373A","0xB2987F","0x222222","0xcccccc","0x451616","0x571542","0x6A6846");
survivorLegColours = new Array("0x333333","0x182746","0x333300","0x111111");
var bgMusicPlaying = false;
location.glenDale.musicTrack = "track1";
location.claysBurg.musicTrack = "track2";
location.whistlersGrove.musicTrack = "track3";
location.aspenWood.musicTrack = "track4";
location.jonesTown.musicTrack = "track5";
location.unionCity.musicTrack = "track6";
