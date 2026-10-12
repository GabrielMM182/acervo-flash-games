function UpdateLives()
{
   il = 1;
   while(il <= 10)
   {
      if(il <= Lives)
      {
         eval("Status.l" + il)._visible = true;
      }
      else
      {
         eval("Status.l" + il)._visible = false;
      }
      il++;
   }
   if(Lives <= 0)
   {
      gotoAndStop("GameOver");
      play();
   }
}
function UpdateScore()
{
   if(Score == 0)
   {
      Status.Scr.d1._visible = true;
      Status.Scr.d1.gotoAndStop(1);
      is = 2;
      while(is <= 10)
      {
         eval("Status.Scr.d" + is)._visible = false;
         is++;
      }
   }
   else
   {
      TheNum = Score;
      is = 0;
      while(is <= 9)
      {
         Digits[9 - is] = Math.floor(TheNum % 10);
         Thenum = Math.floor(Score / Math.pow(10,is + 1));
         is++;
      }
      OffSet = 0;
      while(Digits[OffSet] == 0)
      {
         OffSet++;
      }
      is = 1;
      while(is <= 10)
      {
         if(is <= 10 - Offset)
         {
            eval("Status.ScR.d" + is).gotoAndStop(Digits[is - 1 + OffSet] + 1);
            eval("Status.ScR.d" + is)._visible = true;
         }
         else
         {
            eval("Status.ScR.d" + is)._visible = false;
         }
         is++;
      }
   }
}
function FindTable(num)
{
   ATN = 0;
   it = 1;
   while(it <= TT)
   {
      if(!TablesOc[it - 1])
      {
         ATN++;
      }
      it++;
   }
   Sel = random(ATN) + 1;
   if(ATN > 0)
   {
      it = 1;
      while(it <= TT)
      {
         if(!TablesOc[it - 1])
         {
            Sel--;
            if(Sel == 0)
            {
               eval("Scene.C" + num).Table = it;
               TablesOc[it - 1] = true;
               eval("Scene.C" + num).Place = random(2) + 1;
               break;
            }
         }
         it++;
      }
   }
}
function InitiateClient(num)
{
   eval("Scene.C" + num).Mode = 0;
   eval("Scene.C" + num)._x = -300;
   eval("Scene.C" + num)._xscale = 100;
   eval("Scene.C" + num).Type = random(4) + 1;
   eval("Scene.C" + num).Partner = 0;
   eval("Scene.C" + num).Active = true;
   eval("Scene.C" + num).Time = 0;
   eval("Scene.C" + num).Table = 0;
   eval("Scene.C" + num).free = false;
   eval("Scene.C" + num).move = true;
   eval("Scene.C" + num).Body.index = num;
   eval("Scene.C" + num).Plate = 0;
   eval("Scene.C" + num).Drink = 0;
   eval("Scene.C" + num).ReturnToMode3 = false;
   eval("Scene.C" + num).finished = false;
   eval("Scene.C" + num).Steps = 0;
   eval("Scene.C" + num).Patience = 0;
   eval("Scene.C" + num).WalkTime = 0;
   eval("Scene.C" + num).Failed = false;
   eval("Scene.C" + num).OrderedFor = false;
   eval("Scene.C" + num).swapDepths(10 + num);
   i = 1;
   while(i <= Cmax)
   {
      if(eval("Scene.C" + i).Mode == 0 and i != num and eval("Scene.C" + i).Partner == 0 and eval("Scene.C" + i).Table > 0)
      {
         eval("Scene.C" + num).Partner = i;
         eval("Scene.C" + i).Partner = num;
         eval("Scene.C" + num).Table = eval("Scene.C" + i).Table;
         if(eval("Scene.C" + i).Place == 1)
         {
            eval("Scene.C" + num).Place = 2;
            eval("Scene.C" + num).Active = false;
         }
         else
         {
            eval("Scene.C" + num).Place = 1;
            eval("Scene.C" + num).Active = false;
         }
      }
      i++;
   }
   if(eval("Scene.C" + num).Partner == 0)
   {
      FindTable(num);
   }
   TheTable = eval("Scene.C" + num).Table;
   ThePlace = eval("Scene.C" + num).Place;
   eval("Scene.Table" + TheTable).Places[ThePlace] = num;
   if(eval("Scene.C" + num).Type == 1)
   {
      eval("Scene.C" + num)._y = 0;
      eval("Scene.C" + num).WalkSpeed = 20;
      eval("Scene.C" + num).Anim = new Array(0,1,10,22,25,26,29,30,33,36,44,47,71,75,83,86,94);
   }
   if(eval("Scene.C" + num).Type == 2)
   {
      eval("Scene.C" + num)._y = 0;
      eval("Scene.C" + num).WalkSpeed = 16;
      eval("Scene.C" + num).Anim = new Array(0,1,10,21,24,25,27,28,30,38,49,57,81,83,91,95,104);
   }
   if(eval("Scene.C" + num).Type == 3)
   {
      eval("Scene.C" + num)._y = 0;
      eval("Scene.C" + num).WalkSpeed = 20;
      eval("Scene.C" + num).Anim = new Array(0,1,10,21,24,52,55,56,66,70,86,91,122,133,143,146,155);
   }
   if(eval("Scene.C" + num).Type == 4)
   {
      eval("Scene.C" + num)._y = 0;
      eval("Scene.C" + num).WalkSpeed = 20;
      eval("Scene.C" + num).Anim = new Array(0,1,10,21,24,25,28,29,33,35,44,46,65,70,76,79,88);
   }
}
function AddClient()
{
   Cmax++;
   Scene.ClientExample.duplicateMovieClip("C" + Cmax,Cmax + 10);
   InitiateClient(Cmax);
   eval("Scene.C" + Cmax).Snd = new Sound(eval("_root.Scene.C" + Cmax));
}
function AnimPhase(num, phase)
{
   if(eval("Scene.C" + num).Body._currentFrame < eval("Scene.C" + num).Anim[phase] or eval("Scene.C" + num).Body._currentFrame > eval("Scene.C" + num).Anim[phase + 1])
   {
      eval("Scene.C" + num).Body.gotoAndPlay(eval("Scene.C" + num).Anim[phase]);
   }
   else
   {
      eval("Scene.C" + num).Body.play();
   }
}
function ActivateClient(num)
{
   eval("Scene.C" + num).gotoAndStop(eval("Scene.C" + num).Type);
   if(eval("Scene.C" + num).Mode == 0)
   {
      if(eval("Scene.C" + num).Table > 0)
      {
         MinWTime = 11;
         i = 1;
         while(i <= Cmax)
         {
            if(eval("Scene.C" + i).Mode == 1 and eval("Scene.C" + i).WalkTime < MinWTime)
            {
               MinWTime = eval("Scene.C" + i).WalkTime;
            }
            i++;
         }
         if(MinWTime > 10)
         {
            if(random(200) == 0 or eval("Scene.C" + num).Partner > 0 or Level == 1)
            {
               eval("Scene.C" + num).gotoAndPlay(1);
               eval("Scene.C" + num).Mode = 1;
            }
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 1)
   {
      eval("Scene.C" + num).WalkTime++;
      if(eval("Scene.C" + num).move)
      {
         eval("Scene.C" + num)._x += eval("Scene.C" + num).WalkSpeed;
      }
      if(eval("Scene.C" + num)._x >= PlacesX[eval("Scene.C" + num).Table * 2 + eval("Scene.C" + num).Place - 3])
      {
         eval("Scene.C" + num)._x = PlacesX[eval("Scene.C" + num).Table * 2 + eval("Scene.C" + num).Place - 3];
         eval("Scene.C" + num).move = false;
         if(eval("Scene.C" + num).Place == 1)
         {
            AnimPhase(num,2);
            eval("Scene.C" + num).Mode = 1.5;
            eval("Scene.C" + num).swapDepths(num);
         }
         if(eval("Scene.C" + num).Place == 2)
         {
            AnimPhase(num,15);
            if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[16])
            {
               eval("Scene.C" + num)._xscale = -100;
               eval("Scene.C" + num)._x -= 14.5;
               eval("Scene.C" + num).swapDepths(num);
               eval("Scene.C" + num).Mode = 1.5;
               AnimPhase(num,2);
            }
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 1.5)
   {
      if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[3] - 1)
      {
         if(!eval("Scene.Table" + eval("Scene.C" + num).Table).Dirty)
         {
            if(!eval("Scene.C" + num).OrderedFor)
            {
               eval("Scene.C" + num).Mode = 2;
            }
            else
            {
               eval("Scene.C" + num).Mode = 3;
            }
         }
         else
         {
            eval("Scene.C" + num).Body.stop();
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 2)
   {
      if(eval("Scene.C" + num).Active)
      {
         if(eval("Scene.C" + num).Body._currentFrame < eval("Scene.C" + num).Anim[4] or eval("Scene.C" + num).Body._currentFrame >= eval("Scene.C" + num).Anim[5])
         {
            AnimPhase(num,3);
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 3)
   {
      if(eval("Scene.C" + num).Active and eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[4])
      {
         AnimPhase(num,5);
      }
      if(eval("Scene.C" + num).Plate > 0 or eval("Scene.C" + num).Drink > 0)
      {
         AnimPhase(num,7);
         if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[8])
         {
            eval("Scene.C" + num).Mode = 4;
         }
      }
      if(eval("Scene.C" + num).Plate == 0 and eval("Scene.C" + num).Drink == 0 and eval("Scene.Table" + eval("Scene.C" + num).Table).OrderD[eval("Scene.C" + num).Place] == 0 and eval("Scene.Table" + eval("Scene.C" + num).Table).OrderP[eval("Scene.C" + num).Place] == 0)
      {
         eval("Scene.C" + num).Finished = true;
      }
      if(eval("Scene.C" + num).Finished and eval("Scene.C" + num).Partner == 0 or eval("Scene.C" + num).Finished and eval("Scene.C" + eval("Scene.C" + num).Partner).Finished)
      {
         eval("Scene.C" + num).Mode = 10;
      }
   }
   if(eval("Scene.C" + num).Mode == 4)
   {
      if(eval("Scene.C" + num).Plate > 0)
      {
         AnimPhase(num,8);
         if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[9])
         {
            eval("Scene.C" + num).Mode = 5;
         }
      }
      else if(eval("Scene.C" + num).Drink > 0)
      {
         eval("Scene.C" + num).Mode = 7;
      }
   }
   if(eval("Scene.C" + num).Mode == 5)
   {
      AnimPhase(num,9);
      if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[10])
      {
         if(eval("Scene.C" + num).Drink > 0 and random(4) == 0)
         {
            eval("Scene.C" + num).JumpTo = 7;
            eval("Scene.C" + num).Mode = 6;
         }
         eval("Scene.Table" + eval("Scene.C" + num).Table + ".Plate" + eval("Scene.C" + num).Place).filled -= 1;
         if(eval("Scene.Table" + eval("Scene.C" + num).Table + ".Plate" + eval("Scene.C" + num).Place).filled <= 0)
         {
            eval("Scene.Table" + eval("Scene.C" + num).Table).Dirty = true;
            eval("Scene.Table" + eval("Scene.C" + num).Table).DirtyP[eval("Scene.C" + num).Place] = eval("Scene.C" + num).Plate;
            eval("Scene.C" + num).Plate = 0;
            eval("Scene.C" + num).JumpTo = 8;
            eval("Scene.C" + num).Mode = 6;
            eval("Scene.C" + num).ReturnToMode3 = true;
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 6)
   {
      AnimPhase(num,10);
      if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[11])
      {
         eval("Scene.C" + num).Mode = eval("Scene.C" + num).JumpTo;
      }
   }
   if(eval("Scene.C" + num).Mode == 7)
   {
      AnimPhase(num,11);
      if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[12])
      {
         if(eval("Scene.C" + num).Plate > 0)
         {
            eval("Scene.C" + num).Mode = 4;
         }
         else
         {
            eval("Scene.C" + num).Mode = 8;
            eval("Scene.C" + num).JumpTo = 9;
         }
         eval("Scene.Table" + eval("Scene.C" + num).Table + ".Drink" + eval("Scene.C" + num).Place).filled -= 1;
         if(eval("Scene.Table" + eval("Scene.C" + num).Table + ".Drink" + eval("Scene.C" + num).Place).filled <= 0)
         {
            eval("Scene.Table" + eval("Scene.C" + num).Table).Dirty = true;
            eval("Scene.Table" + eval("Scene.C" + num).Table).DirtyD[eval("Scene.C" + num).Place] = eval("Scene.C" + num).Drink;
            eval("Scene.Table" + eval("Scene.C" + num).Table + ".Drink" + eval("Scene.C" + num).Place).gotoAndStop(eval("Scene.C" + num).Drink + 4);
            eval("Scene.C" + num).Drink = 0;
            eval("Scene.C" + num).ReturnToMode3 = true;
            eval("Scene.C" + num).Mode = 8;
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 8)
   {
      AnimPhase(num,12);
      if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[13] - 1)
      {
         eval("Scene.C" + num).Body.stop();
         eval("Scene.C" + num).Mode = eval("Scene.C" + num).JumpTo;
         if(eval("Scene.C" + num).ReturnToMode3)
         {
            eval("Scene.C" + num).ReturnToMode3 = false;
            eval("Scene.C" + num).Mode = 3;
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 9)
   {
      if(random(100) == 0)
      {
         eval("Scene.C" + num).Mode = 3;
      }
   }
   if(eval("Scene.C" + num).Mode == 10)
   {
      AnimPhase(num,13);
      if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[14])
      {
         ResetTable(eval("Scene.C" + num).Table);
         if(eval("Scene.C" + num).Failed)
         {
            eval("Scene.C" + num).Failed = false;
            Lives--;
            UpdateLives();
         }
         else
         {
            Fanfare.start();
            Score += Math.round((100 - eval("Scene.C" + num).Patience / 100) * Ko);
            UpdateScore();
         }
         eval("Scene.C" + num).Mode = 11;
         if(eval("Scene.C" + num).Active)
         {
            TablesOc[eval("Scene.C" + num).Table - 1] = false;
         }
         ResetList(eval("Scene.C" + num).Table);
         CCTable = eval("Scene.C" + num).Table;
         CCPlace = eval("Scene.C" + num).Place;
         if(eval("Scene.Table" + CCTable).Places[CCPlace] == num)
         {
            eval("Scene.Table" + eval("Scene.C" + num).Table).Places[eval("Scene.C" + num).Place] = 0;
         }
         i = 1;
         while(i <= Cmax)
         {
            if(eval("Scene.C" + i).Mode == 0 and eval("Scene.C" + i).Table == 0)
            {
               InitiateClient(i);
            }
            i++;
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 11)
   {
      AnimPhase(num,14);
      if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[15])
      {
         eval("Scene.C" + num).Steps++;
         eval("Scene.C" + num)._y += 7;
         if(eval("Scene.C" + num).Steps == 2)
         {
            eval("Scene.C" + num).swapDepths(20 + num);
            eval("Scene.C" + num).Mode = 12;
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 12)
   {
      if(eval("Scene.C" + num).Place == 1)
      {
         AnimPhase(num,15);
         if(eval("Scene.C" + num).Body._currentFrame == eval("Scene.C" + num).Anim[16])
         {
            eval("Scene.C" + num).Mode = 13;
            eval("Scene.C" + num)._x -= 14.5;
            eval("Scene.C" + num)._xscale = -100;
         }
      }
      if(eval("Scene.C" + num).Place == 2)
      {
         if(eval("Scene.C" + num).Partner == 0 or eval("Scene.C" + eval("Scene.C" + num).Partner).Mode == 13)
         {
            eval("Scene.C" + num).Mode = 13;
         }
         else
         {
            eval("Scene.C" + num).Body.stop();
         }
      }
   }
   if(eval("Scene.C" + num).Mode == 13)
   {
      AnimPhase(num,1);
      if(eval("Scene.C" + num)._x >= -300)
      {
         eval("Scene.C" + num)._x -= eval("Scene.C" + num).WalkSpeed;
      }
      else if(eval("Scene.C" + num).Partner > 0 and eval("Scene.C" + num).Active)
      {
         if(random(200) == 0)
         {
            InitiateClient(num);
         }
      }
      else
      {
         InitiateClient(num);
      }
   }
   eval("Scene.C" + num).Time++;
   if(eval("Scene.C" + num).Mode == 1.5)
   {
      eval("Scene.C" + num).Patience += 3 * Ko;
   }
   if(eval("Scene.C" + num).Mode == 2)
   {
      eval("Scene.C" + num).Patience += 2 * Ko;
   }
   if(eval("Scene.C" + num).Mode >= 3 and eval("Scene.C" + num).Mode <= 9)
   {
      if(eval("Scene.Table" + eval("Scene.C" + num).Table).OrderD[eval("Scene.C" + num).Place] > 0)
      {
         eval("Scene.C" + num).Patience += 0.5 * Ko;
      }
      if(eval("Scene.Table" + eval("Scene.C" + num).Table).OrderP[eval("Scene.C" + num).Place] > 0)
      {
         eval("Scene.C" + num).Patience += 0.5 * Ko;
      }
   }
   eval("Scene.C" + num).St.Body.gotoAndStop(Math.round(eval("Scene.C" + num).Patience / 100) + 1);
   if(eval("Scene.C" + num).Patience >= 10000 and eval("Scene.C" + num).Mode < 10)
   {
      eval("Scene.C" + num).Failed = true;
      eval("Scene.C" + num).St.gotoAndPlay(8);
      eval("Scene.Table" + eval("Scene.C" + num).Table).OrderD[1] = 0;
      eval("Scene.Table" + eval("Scene.C" + num).Table).OrderD[2] = 0;
      eval("Scene.Table" + eval("Scene.C" + num).Table).OrderP[1] = 0;
      eval("Scene.Table" + eval("Scene.C" + num).Table).OrderP[2] = 0;
      if(eval("Scene.C" + num).Plate > 0)
      {
         eval("Scene.Table" + eval("Scene.C" + num).Table).Dirty = true;
         eval("Scene.Table" + eval("Scene.C" + num).Table).DirtyP[eval("Scene.C" + num).Place] = eval("Scene.C" + num).Plate;
      }
      if(eval("Scene.C" + num).Drink > 0)
      {
         eval("Scene.Table" + eval("Scene.C" + num).Table).Dirty = true;
         eval("Scene.Table" + eval("Scene.C" + num).Table).DirtyD[eval("Scene.C" + num).Place] = eval("Scene.C" + num).Drink;
      }
      eval("Scene.C" + num).Mode = 10;
      if(eval("Scene.C" + num).Partner > 0)
      {
         if(eval("Scene.C" + eval("Scene.C" + num).Partner).Plate > 0)
         {
            eval("Scene.Table" + eval("Scene.C" + eval("Scene.C" + num).Partner).Table).Dirty = true;
            eval("Scene.Table" + eval("Scene.C" + eval("Scene.C" + num).Partner).Table).DirtyP[eval("Scene.C" + eval("Scene.C" + num).Partner).Place] = eval("Scene.C" + eval("Scene.C" + num).Partner).Plate;
         }
         if(eval("Scene.C" + eval("Scene.C" + num).Partner).Drink > 0)
         {
            eval("Scene.Table" + eval("Scene.C" + eval("Scene.C" + num).Partner).Table).Dirty = true;
            eval("Scene.Table" + eval("Scene.C" + eval("Scene.C" + num).Partner).Table).DirtyD[eval("Scene.C" + eval("Scene.C" + num).Partner).Place] = eval("Scene.C" + eval("Scene.C" + num).Partner).Drink;
         }
         eval("Scene.C" + eval("Scene.C" + num).Partner).Failed = true;
         eval("Scene.C" + eval("Scene.C" + num).Partner).Mode = 10;
         eval("Scene.C" + eval("Scene.C" + num).Partner).St.gotoAndPlay(8);
      }
   }
}
function InitWaitress()
{
   Scene.W._x = 200;
   Scene.W._y = 13;
   Scene.W.dir = 0;
   Scene.W.Mode = 0;
   Scene.W.Drinks = new Array(0,0,0,0,0,0,0,0,0);
   Scene.W.Plates = new Array(0,0,0);
   Scene.W.TotalPlates = 0;
   Scene.W.TotalDrinks = 0;
   Scene.W.Serve = 0;
   Scene.W.ServeDish = false;
   Scene.W.SelectDrink = 0;
   Scene.W.MenuActive = false;
   Scene.Cook.Busy = false;
   TrashCan = 0;
   DDOT = 0;
   Scene.WExample._visible = false;
}
function ActivateWaitress()
{
   if(Scene.W.Mode == 0)
   {
      if(Scene.W.dir == 0)
      {
         Scene.W.gotoAndStop(14);
      }
      else
      {
         Scene.W.gotoAndStop(40);
      }
      Scene.W.Busy = false;
      Scene.W.Tnum = 0;
   }
   if(Scene.W.Mode == 1)
   {
      if(Scene.W.dir == 0)
      {
         if(Scene.W._currentFrame > 9)
         {
            Scene.W.gotoAndPlay(2);
         }
         Scene.W._x -= 22;
      }
      else
      {
         if(Scene.W._currentFrame < 28 or Scene.W._currentFrame > 36)
         {
            Scene.W.gotoAndPlay(29);
         }
         Scene.W._x += 22;
      }
      if(Scene.W.dir == 0 and Scene.W._x <= Scene.W.DesX)
      {
         Scene.W.DesReached = true;
      }
      if(Scene.W.dir == 1 and Scene.W._x >= Scene.W.DesX)
      {
         Scene.W.DesReached = true;
      }
      if(Scene.W.DesReached)
      {
         Scene.W._x = Scene.W.DesX;
         Scene.W.Mode = 2;
      }
   }
   if(Scene.W.Mode == 2)
   {
      if(Scene.W.dir == 0)
      {
         if(Scene.W._currentFrame < 11 or Scene.W._currentFrame > 14)
         {
            Scene.W.gotoAndPlay(11);
         }
         if(Scene.W._currentFrame == 14)
         {
            Scene.W.Mode = 4;
         }
      }
      if(Scene.W.dir == 1)
      {
         if(Scene.W._currentFrame < 37 or Scene.W._currentFrame > 40)
         {
            Scene.W.gotoAndPlay(37);
         }
         if(Scene.W._currentFrame == 40)
         {
            Scene.W.Mode = 4;
         }
      }
      if(Scene.W.Tnum == 7)
      {
         Scene.W.Mode = 12;
      }
   }
   if(Scene.W.Mode == 3)
   {
      if(Scene.W.dir == 1)
      {
         if(Scene.W._currentFrame < 15 or Scene.W._currentFrame > 23)
         {
            Scene.W.gotoAndPlay(15);
         }
         if(Scene.W._currentFrame == 18)
         {
            Scene.W.gotoAndPlay(21);
         }
         if(Scene.W._currentFrame == 23)
         {
            Scene.W.Mode = 1;
         }
      }
      if(Scene.W.dir == 0)
      {
         if(Scene.W._currentFrame < 41 or Scene.W._currentFrame > 49)
         {
            Scene.W.gotoAndPlay(41);
         }
         if(Scene.W._currentFrame == 44)
         {
            Scene.W.gotoAndPlay(47);
         }
         if(Scene.W._currentFrame == 49)
         {
            Scene.W.Mode = 1;
         }
      }
   }
   if(Scene.W.Mode == 4)
   {
      if(Scene.W.Tnum <= 4 and !TablesOc[Scene.W.Tnum - 1] and !eval("Scene.Table" + Scene.W.Tnum).Dirty)
      {
         Scene.W.Mode = 0;
      }
      else
      {
         if(Scene.W.dir == 0)
         {
            if(Scene.W._currentFrame < 15 or Scene.W._currentFrame > 20)
            {
               Scene.W.gotoAndPlay(15);
            }
            if(Scene.W._currentFrame == 20)
            {
               if(Scene.W.Tnum <= 4)
               {
                  Scene.W.Mode = 5;
               }
               if(Scene.W.Tnum == 5)
               {
                  Scene.W.Mode = 10;
               }
               if(Scene.W.Tnum == 6)
               {
                  Scene.W.Mode = 11;
               }
               if(Scene.W.Tnum == 8)
               {
                  Scene.W.Mode = 13;
               }
               if(Scene.W.Tnum == 9)
               {
                  Scene.W.Mode = 16;
               }
               if(Scene.W.Tnum == 10)
               {
                  Scene.W.Mode = 19;
               }
               if(Scene.W.Tnum < 8)
               {
                  Scene.W.Busy = true;
               }
            }
         }
         if(Scene.W.dir == 1)
         {
            if(Scene.W._currentFrame < 41 or Scene.W._currentFrame > 46)
            {
               Scene.W.gotoAndPlay(41);
            }
            if(Scene.W._currentFrame == 46)
            {
               if(Scene.W.Tnum <= 4)
               {
                  Scene.W.Mode = 5;
               }
               if(Scene.W.Tnum == 5)
               {
                  Scene.W.Mode = 10;
               }
               if(Scene.W.Tnum == 6)
               {
                  Scene.W.Mode = 11;
               }
               if(Scene.W.Tnum == 8)
               {
                  Scene.W.Mode = 13;
               }
               if(Scene.W.Tnum == 9)
               {
                  Scene.W.Mode = 16;
               }
               if(Scene.W.Tnum == 10)
               {
                  Scene.W.Mode = 19;
               }
               if(Scene.W.Tnum < 8)
               {
                  Scene.W.Busy = true;
               }
            }
         }
      }
   }
   if(Scene.W.Mode == 5)
   {
      Cancel = true;
      if(eval("Scene.Table" + Scene.W.Tnum).Dirty)
      {
         Scene.W.Mode = 9;
      }
      if(eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[1]).Mode == 2 or eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[2]).Mode == 2)
      {
         Scene.W.Mode = 7;
      }
      if(eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[1]).Mode != 2 and eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[2]).Mode != 2)
      {
         if(eval("Scene.Table" + Scene.W.Tnum).OrderP[1] > 0 or eval("Scene.Table" + Scene.W.Tnum).OrderP[2] > 0 or eval("Scene.Table" + Scene.W.Tnum).OrderD[1] > 0 or eval("Scene.Table" + Scene.W.Tnum).OrderD[2] > 0)
         {
            Scene.W.Mode = 8;
         }
         else if(!eval("Scene.Table" + Scene.W.Tnum).Dirty)
         {
            Scene.W.Mode = 6;
         }
      }
   }
   if(Scene.W.Mode == 6)
   {
      Scene.W.Busy = false;
      if(Scene.W.dir == 1)
      {
         if(Scene.W._currentFrame < 21 or Scene.W._currentFrame > 26)
         {
            Scene.W.gotoAndPlay(21);
         }
         if(Scene.W._currentFrame == 26)
         {
            if(!Scene.W.MenuActive)
            {
               Scene.W.Mode = 0;
            }
            else
            {
               Scene.W.MenuActive = false;
               Wgo(Scene.W.XDes);
            }
         }
      }
      if(Scene.W.dir == 0)
      {
         if(Scene.W._currentFrame < 47 or Scene.W._currentFrame > 53)
         {
            Scene.W.gotoAndPlay(47);
         }
         if(Scene.W._currentFrame == 53)
         {
            if(!Scene.W.MenuActive)
            {
               Scene.W.Mode = 0;
            }
            else
            {
               Scene.W.MenuActive = false;
               Wgo(Scene.W.XDes);
            }
         }
      }
   }
   if(Scene.W.Mode == 7)
   {
      Cancel = false;
      if(Scene.W._currentFrame < 56 or Scene.W._currentFrame > 76)
      {
         Scene.W.gotoAndPlay(56);
      }
      if(Scene.W._currentFrame == 76)
      {
         i = 1;
         while(i <= 2)
         {
            if(eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[i]).Mode > 1)
            {
               eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[i]).Mode = 3;
            }
            else
            {
               eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[i]).OrderedFor = true;
            }
            if(eval("Scene.Table" + Scene.W.Tnum).Places[i] > 0)
            {
               eval("Scene.Table" + Scene.W.Tnum).OrderD[i] = random(4) + 1;
               eval("Scene.Table" + Scene.W.Tnum).OrderP[i] = random(4) + 1;
               eval("Menu.List" + Scene.W.Tnum)._visible = true;
               AddToList(Scene.W.Tnum,eval("Scene.Table" + Scene.W.Tnum).OrderP[i] + 4);
               AddToList(Scene.W.Tnum,eval("Scene.Table" + Scene.W.Tnum).OrderD[i]);
            }
            i++;
         }
         Cancel = true;
      }
      if(Cancel)
      {
         Scene.W.Mode = 6;
      }
   }
   if(Scene.W.Mode == 8)
   {
      if(Scene.W._currentFrame < 77 or Scene.W._currentFrame > 79 and Scene.W.Serve == 0)
      {
         Scene.W.gotoAndPlay(77);
      }
      if(Scene.W._currentFrame == 79)
      {
         Scene.W.Serve = 1;
      }
      if(Scene.W.Serve == 1)
      {
         Item = 0;
         Item = FindPlate(eval("Scene.Table" + Scene.W.Tnum).OrderP[1]);
         if(Item > 0)
         {
            Scene.W.ServeDish = true;
            Scene.W.Clean = false;
            eval("Scene.Table" + Scene.W.Tnum).Plate1._visible = true;
            eval("Scene.Table" + Scene.W.Tnum).Plate1.gotoAndStop(eval("Scene.Table" + Scene.W.Tnum).OrderP[1]);
            eval("scene.Table" + Scene.W.Tnum).Plate1.filled = 50;
            if(Scene.W._currentFrame < 97 or Scene.W._currentFrame > 105)
            {
               Scene.W.gotoAndPlay(97);
            }
            if(Scene.W._currentFrame == 105)
            {
               Scene.W.Serve = 2;
               Scene.W.Plates[Item] = 0;
               Scene.W.gotoAndPlay(78);
               eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[1]).Plate = eval("Scene.Table" + Scene.W.Tnum).OrderP[1];
               RemoveFromList(Scene.W.Tnum,eval("Scene.Table" + Scene.W.Tnum).OrderP[1] + 4);
               eval("Scene.Table" + Scene.W.Tnum).OrderP[1] = 0;
               Scene.W.ServeDish = false;
               eval("Scene.Table" + Scene.W.Tnum).Fork1._visible = true;
            }
         }
         else
         {
            Scene.W.Serve = 2;
         }
      }
      if(Scene.W.Serve == 2)
      {
         Item = 0;
         Item = FindDrink(eval("Scene.Table" + Scene.W.Tnum).OrderD[1]);
         if(Item > 0)
         {
            Scene.W.Clean = false;
            eval("Scene.Table" + Scene.W.Tnum).Drink1._visible = true;
            eval("Scene.Table" + Scene.W.Tnum).Drink1.gotoAndStop(eval("Scene.Table" + Scene.W.Tnum).OrderD[1]);
            eval("scene.Table" + Scene.W.Tnum).Drink1.filled = 10;
            if(Scene.W._currentFrame < 97 or Scene.W._currentFrame > 104)
            {
               Scene.W.gotoAndPlay(97);
            }
            if(Scene.W._currentFrame == 104)
            {
               Scene.W.Serve = 3;
               Scene.W.Drinks[Item] = 0;
               eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[1]).Drink = eval("Scene.Table" + Scene.W.Tnum).OrderD[1];
               RemoveFromList(Scene.W.Tnum,eval("Scene.Table" + Scene.W.Tnum).OrderD[1]);
               eval("Scene.Table" + Scene.W.Tnum).OrderD[1] = 0;
            }
         }
         else
         {
            Scene.W.Serve = 3;
         }
      }
      if(Scene.W.Serve == 3)
      {
         Item = 0;
         Item = FindPlate(eval("Scene.Table" + Scene.W.Tnum).OrderP[2]);
         if(Item > 0)
         {
            Scene.W.Clean = false;
            if(!Scene.W.ServeDish)
            {
               eval("Scene.Table" + Scene.W.Tnum).Plate2._x = -0.8;
               eval("Scene.Table" + Scene.W.Tnum).Plate2._y = -68;
            }
            Scene.W.ServeDish = true;
            eval("Scene.Table" + Scene.W.Tnum).Plate2._visible = true;
            eval("Scene.Table" + Scene.W.Tnum).Plate2.gotoAndStop(eval("Scene.Table" + Scene.W.Tnum).OrderP[2]);
            eval("scene.Table" + Scene.W.Tnum).Plate2.filled = 50;
            if(Scene.W._currentFrame < 79 or Scene.W._currentFrame > 88)
            {
               Scene.W.gotoAndPlay(79);
            }
            if(Scene.W._currentFrame == 88)
            {
               Scene.W.Serve = 4;
               Scene.W.Plates[Item] = 0;
               Scene.W.ServeDish = false;
               eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[2]).Plate = eval("Scene.Table" + Scene.W.Tnum).OrderP[2];
               RemoveFromList(Scene.W.Tnum,eval("Scene.Table" + Scene.W.Tnum).OrderP[2] + 4);
               eval("Scene.Table" + Scene.W.Tnum).OrderP[2] = 0;
               eval("Scene.Table" + Scene.W.Tnum).Fork2._visible = true;
            }
         }
         else
         {
            Scene.W.Serve = 4;
         }
      }
      if(Scene.W.Serve == 4)
      {
         Item = 0;
         Item = FindDrink(eval("Scene.Table" + Scene.W.Tnum).OrderD[2]);
         if(Item > 0)
         {
            Scene.W.Clean = false;
            eval("Scene.Table" + Scene.W.Tnum).Drink2._visible = true;
            eval("Scene.Table" + Scene.W.Tnum).Drink2.gotoAndStop(eval("Scene.Table" + Scene.W.Tnum).OrderD[2]);
            eval("scene.Table" + Scene.W.Tnum).Drink2.filled = 10;
            if(Scene.W._currentFrame < 89 or Scene.W._currentFrame > 96)
            {
               Scene.W.gotoAndPlay(89);
            }
            if(Scene.W._currentFrame == 96)
            {
               eval("Scene.C" + eval("Scene.Table" + Scene.W.Tnum).Places[2]).Drink = eval("Scene.Table" + Scene.W.Tnum).OrderD[2];
               RemoveFromList(Scene.W.Tnum,eval("Scene.Table" + Scene.W.Tnum).OrderD[2]);
               eval("Scene.Table" + Scene.W.Tnum).OrderD[2] = 0;
               Scene.W.Drinks[Item] = 0;
               Scene.W.Serve = 0;
               if(eval("Scene.Table" + Scene.W.Tnum).Dirty)
               {
                  Scene.W.Mode = 9;
               }
               else
               {
                  Scene.W.Mode = 6;
               }
            }
            OrganizeTray();
            ResetTable(Scene.W.Tnum);
         }
         else
         {
            Scene.W.Serve = 0;
            if(eval("Scene.Table" + Scene.W.Tnum).Dirty)
            {
               Scene.W.Mode = 9;
            }
            else
            {
               Scene.W.Mode = 6;
            }
         }
         OrganizeTray();
         ResetTable(Scene.W.Tnum);
      }
   }
   if(Scene.W.Mode == 9)
   {
      if(Scene.W._currentFrame < 77 or Scene.W._currentFrame > 79 and Scene.W.Serve == 0)
      {
         Scene.W.gotoAndPlay(77);
      }
      if(Scene.W._currentFrame == 79)
      {
         Scene.W.Serve = 1;
      }
      if(Scene.W.Serve == 1)
      {
         if(PlaceOnTray(2) and eval("Scene.Table" + Scene.W.Tnum).DirtyP[1] > 0)
         {
            Scene.W.ServeDish = true;
            Scene.W.Clean = true;
            eval("Scene.Table" + Scene.W.Tnum).Fork1._visible = false;
            if(Scene.W._currentFrame < 97 or Scene.W._currentFrame > 105)
            {
               Scene.W.gotoAndPlay(97);
            }
            if(Scene.W._currentFrame == 105)
            {
               Scene.W.Serve = 2;
               eval("Scene.Table" + Scene.W.Tnum).Plate1._visible = false;
               eval("Scene.Table" + Scene.W.Tnum).DirtyP[1] = 0;
               Scene.W.gotoAndPlay(78);
               Scene.W.TotalPlates++;
               Scene.W.Plates[Scene.W.TotalPlates] = 5;
               Scene.W.ServeDish = false;
            }
         }
         else
         {
            Scene.W.Serve = 2;
         }
      }
      if(Scene.W.Serve == 2)
      {
         if(PlaceOnTray(1) and eval("Scene.Table" + Scene.W.Tnum).DirtyD[1] > 0)
         {
            Scene.W.ServeDish = false;
            Scene.W.Clean = true;
            if(Scene.W._currentFrame < 97 or Scene.W._currentFrame > 105)
            {
               Scene.W.gotoAndPlay(97);
            }
            if(Scene.W._currentFrame == 105)
            {
               Scene.W.Serve = 3;
               eval("Scene.Table" + Scene.W.Tnum).Drink1._visible = false;
               Scene.W.TotalDrinks++;
               Scene.W.Drinks[Scene.W.TotalDrinks] = eval("Scene.Table" + Scene.W.Tnum).DirtyD[1] + 4;
               eval("Scene.Table" + Scene.W.Tnum).DirtyD[1] = 0;
            }
         }
         else
         {
            Scene.W.Serve = 3;
         }
      }
      if(Scene.W.Serve == 3)
      {
         if(PlaceOnTray(2) and eval("Scene.Table" + Scene.W.Tnum).DirtyP[2] > 0)
         {
            Scene.W.ServeDish = true;
            Scene.W.Clean = true;
            eval("Scene.Table" + Scene.W.Tnum).Fork2._visible = false;
            if(Scene.W._currentFrame < 79 or Scene.W._currentFrame > 88)
            {
               Scene.W.gotoAndPlay(79);
            }
            if(Scene.W._currentFrame == 88)
            {
               Scene.W.Serve = 4;
               eval("Scene.Table" + Scene.W.Tnum).Plate2._visible = false;
               eval("Scene.Table" + Scene.W.Tnum).DirtyP[2] = 0;
               Scene.W.TotalPlates++;
               Scene.W.Plates[Scene.W.TotalPlates] = 5;
               Scene.W.ServeDish = false;
            }
         }
         else
         {
            Scene.W.Serve = 4;
         }
      }
      if(Scene.W.Serve == 4)
      {
         if(PlaceOnTray(1) and eval("Scene.Table" + Scene.W.Tnum).DirtyD[2] > 0)
         {
            Scene.W.ServeDish = false;
            Scene.W.Clean = true;
            if(Scene.W._currentFrame < 89 or Scene.W._currentFrame > 96)
            {
               Scene.W.gotoAndPlay(89);
            }
            if(Scene.W._currentFrame == 96)
            {
               Scene.W.Serve = 0;
               eval("Scene.Table" + Scene.W.Tnum).Drink2._visible = false;
               Scene.W.TotalDrinks++;
               Scene.W.Drinks[Scene.W.TotalDrinks] = eval("Scene.Table" + Scene.W.Tnum).DirtyD[2] + 4;
               eval("Scene.Table" + Scene.W.Tnum).DirtyD[2] = 0;
               eval("Scene.Table" + Scene.W.Tnum).Dirty = IsDirty(Scene.W.Tnum);
               Scene.W.Mode = 6;
            }
            ResetTable(Scene.W.Tnum);
         }
         else
         {
            Scene.W.Serve = 0;
            eval("Scene.Table" + Scene.W.Tnum).Dirty = IsDirty(Scene.W.Tnum);
            Scene.W.Mode = 6;
            ResetTable(Scene.W.Tnum);
         }
      }
   }
   if(Scene.W.Mode == 10)
   {
      i = 1;
      while(i <= 8)
      {
         if(Scene.W.Drinks[i] > 4 and TrashCan < 20 and Scene.TCan._visible)
         {
            Scene.W.Drinks[i] = 0;
            TrashCan++;
            DDOT++;
         }
         i++;
      }
      if(DDOT > 0)
      {
         if(Scene.W._currentFrame < 106 or Scene.W._currentFrame > 125)
         {
            Scene.W.gotoAndPlay(106);
         }
      }
      if(Scene.W._currentFrame == 125)
      {
         Scene.W.Mode = 6;
         DDOT = 0;
      }
      if(DDOT == 0)
      {
         Scene.W.Mode = 6;
      }
      OrganizeTray;
   }
   if(Scene.W.Mode == 11)
   {
      if(Cups <= 0 or !PlaceOnTray(1))
      {
         Scene.W.Mode = 6;
      }
      else
      {
         if(Scene.W._currentFrame < 126 or Scene.W._currentFrame > 158)
         {
            Scene.W.gotoAndPlay(126);
         }
         if(Scene.W._currentFrame == 131)
         {
            Cups--;
         }
         if(Scene.W._currentFrame == 158)
         {
            Scene.W.Mode = 6;
            Scene.W.TotalDrinks++;
            Scene.W.Drinks[Scene.W.TotalDrinks] = 4;
         }
      }
   }
   if(Scene.W.Mode == 12)
   {
      Scene.W.Busy = true;
      if(PinB < 9 and FindPlate(5) > 0)
      {
         Scene.W.Mode = 12.5;
      }
      else
      {
         Scene.W.Mode = 0;
      }
   }
   if(Scene.W.Mode == 12.5)
   {
      item = FindPlate(5);
      if(Scene.W._currentFrame < 183 or Scene.W._currentFrame > 193)
      {
         Scene.W.gotoAndPlay(183);
      }
      else
      {
         Scene.W.play();
      }
      if(Scene.W._currentFrame == 188)
      {
         PinB++;
      }
      if(Scene.W._currentFrame == 185)
      {
         Scene.W.Plates[item] = 0;
         OrganizeTray();
      }
      if(Scene.W._currentFrame == 193)
      {
         Scene.W.Mode = 12;
         Scene.W.gotoAndStop(183);
      }
   }
   if(Scene.W.Mode == 13)
   {
      Scene.W.MenuActive = true;
      Scene.W.stop();
      Scene.W.SelectDrink = 0;
      Menu.Buttons.gotoAndStop(2);
      Scene.W.Mode = 14;
   }
   if(Scene.W.Mode == 14)
   {
      if(Scene.W.SelectDrink > 0 and PlaceOnTray(1) and ColdDrinks[Scene.W.SelectDrink] > 0)
      {
         Scene.W.Mode = 15;
      }
      if(Scene.W.Tnum != 8)
      {
         Scene.W.Mode = 6;
         Menu.Buttons.gotoAndStop(1);
         if(Scene.W._x <= Scene.W.XDes)
         {
            Scene.W.dir = 1;
         }
         else
         {
            Scene.W.dir = 0;
         }
      }
   }
   if(Scene.W.Mode == 15)
   {
      Scene.W.Busy = true;
      if(Scene.W._currentFrame < 169 or Scene.W._currentFrame > 182)
      {
         Scene.W.gotoAndPlay(169);
      }
      if(Scene.W._currentFrame == 172)
      {
         ColdDrinks[Scene.W.SelectDrink]--;
      }
      if(Scene.W._currentFrame == 182)
      {
         Scene.W.TotalDrinks++;
         Scene.W.Drinks[Scene.W.TotalDrinks] = Scene.W.SelectDrink;
         Scene.W.SelectDrink = 0;
         Scene.W.gotoAndStop(168);
         Scene.W.Busy = false;
         Scene.W.Mode = 14;
      }
   }
   if(Scene.W.Mode == 16)
   {
      if(!Scene.Cook.Busy and !DishReady)
      {
         Scene.W.stop();
         Scene.Cook.gotoAndPlay(2);
         Scene.W.MenuActive = true;
         Menu.Buttons.gotoAndStop(3);
         Scene.W.Mode = 17;
         SelectDish = 0;
      }
      if(Scene.Cook.Busy)
      {
         Scene.W.Mode = 6;
      }
      if(DishReady)
      {
         Scene.W.Mode = 18;
         Scene.W.Busy = true;
      }
   }
   if(Scene.W.Mode == 17)
   {
      if(Scene.W.Tnum != 9)
      {
         Menu.Buttons.gotoAndStop(1);
         Scene.Cook.gotoAndPlay(23);
         Scene.W.Mode = 6;
         if(Scene.W._x <= Scene.W.XDes)
         {
            Scene.W.dir = 1;
         }
         else
         {
            Scene.W.dir = 0;
         }
      }
      if(SelectDish > 0)
      {
         Scene.Cook.Busy = true;
         Scene.Cook.Type = SelectDish;
         Scene.Cook.gotoAndPlay(12);
         Scene.W.MenuActive = false;
         Menu.Buttons.gotoAndStop(4);
         Menu.Buttons.Plate.gotoAndStop(SelectDish);
         Scene.W.Mode = 17.5;
      }
   }
   if(Scene.W.Mode == 18)
   {
      if(PlaceOnTray(2))
      {
         if(Scene.W._currentFrame < 159 or Scene.W._currentFrame > 168)
         {
            Scene.W.gotoAndPlay(159);
         }
         if(Scene.W._currentFrame == 168)
         {
            Scene.W.TotalPlates++;
            Scene.W.Plates[Scene.W.TotalPlates] = Scene.KitPlate.Type;
            Scene.KitPlate.gotoAndStop(1);
            DishReady = false;
            StopAtDish = false;
            Scene.W.Busy = false;
            Scene.W.Mode = 6;
         }
      }
      else
      {
         Scene.W.Mode = 6;
      }
   }
   if(Scene.W.Mode == 19)
   {
      Scene.W.stop();
      Scene.W.MenuActive = true;
      Menu.Buttons.gotoAndStop(5);
      SelectAction = 0;
      Scene.W.Mode = 20;
   }
   if(Scene.W.Mode == 20)
   {
      if(Scene.W.Tnum != 10)
      {
         Menu.Buttons.gotoAndStop(1);
         Scene.W.Mode = 6;
         if(Scene.W._x <= Scene.W.XDes)
         {
            Scene.W.dir = 1;
         }
         else
         {
            Scene.W.dir = 0;
         }
      }
      if(SelectAction == 1)
      {
         Scene.Worker.gotoAndPlay(2);
      }
      if(SelectAction == 2 and Cups < 20)
      {
         Scene.Worker.CupN = 20 - Cups;
         Scene.Worker.gotoAndPlay(59);
      }
      if(SelectAction == 3 and ColdDrinks[1] + ColdDrinks[2] + ColdDrinks[3] < 30)
      {
         Scene.Worker.gotoAndPlay(84);
      }
      if(SelectAction == 4 and PinB > 0)
      {
         Scene.PBox.gotoAndPlay(2);
      }
      if(SelectAction > 0)
      {
         Scene.W.MenuActive = false;
         Menu.Buttons.gotoAndStop(1);
         Scene.W.Mode = 6;
      }
   }
}
function Wgo(X)
{
   oldDir = Scene.W.dir;
   if(X < Scene.W._x)
   {
      Scene.W.dir = 0;
   }
   else
   {
      Scene.W.dir = 1;
   }
   if(oldDir != Scene.W.dir)
   {
      Scene.W.Mode = 3;
   }
   else
   {
      Scene.W.Mode = 1;
   }
   Scene.W.DesX = X;
   Scene.W.DesReached = false;
}
function InitTables()
{
   i = 1;
   while(i <= TT)
   {
      eval("Scene.Table" + i).index = i;
      eval("Scene.Table" + i).Places = new Array(0,0,0);
      eval("Scene.Table" + i).OrderD = new Array(0,0,0);
      eval("Scene.Table" + i).OrderP = new Array(0,0,0);
      eval("Scene.Table" + i).DirtyD = new Array(0,0,0);
      eval("Scene.Table" + i).DirtyP = new Array(0,0,0);
      eval("Scene.Table" + i).Plate1._visible = false;
      eval("Scene.Table" + i).Plate2._visible = false;
      eval("Scene.Table" + i).Drink1._visible = false;
      eval("Scene.Table" + i).Drink2._visible = false;
      eval("Scene.Table" + i).Fork1._visible = false;
      eval("Scene.Table" + i).Fork2._visible = false;
      eval("Scene.Table" + i).Dirty = false;
      i++;
   }
}
function FindPlate(type)
{
   var _loc1_ = type;
   resp = 0;
   i = 1;
   while(i <= 2)
   {
      if(Scene.W.Plates[i] == _loc1_ and _loc1_ > 0)
      {
         resp = i;
      }
      i++;
   }
   return resp;
}
function FindDrink(type)
{
   var _loc1_ = type;
   i = 1;
   while(i <= 8)
   {
      if(Scene.W.Drinks[i] == _loc1_ and _loc1_ > 0)
      {
         return i;
      }
      i++;
   }
}
function OrganizeTray()
{
   if(Scene.W.Plates[2] > 0 and Scene.W.Plates[1] == 0)
   {
      Scene.W.Plates[1] = Scene.W.Plates[2];
      Scene.W.Plates[2] = 0;
   }
   Scene.W.TotalPlates = 0;
   if(Scene.W.Plates[1] > 0)
   {
      Scene.W.TotalPlates++;
   }
   if(Scene.W.Plates[2] > 0)
   {
      Scene.W.TotalPlates++;
   }
   i = 1;
   while(i <= 7)
   {
      if(Scene.W.Drinks[i] == 0)
      {
         j = i + 1;
         while(j <= 8)
         {
            if(Scene.W.Drinks[j] > 0)
            {
               Scene.W.Drinks[i] = Scene.W.Drinks[j];
               Scene.W.Drinks[j] = 0;
               break;
            }
            j++;
         }
      }
      i++;
   }
   Scene.W.TotalDrinks = 0;
   i = 1;
   while(i <= 8)
   {
      if(Scene.W.Drinks[i] > 0)
      {
         Scene.W.TotalDrinks++;
      }
      i++;
   }
}
function CheckOrder(table)
{
   i = 1;
   while(i <= 2)
   {
      if(eval("Scene.Table" + table).OrderP[i] > 0 or eval("Scene.Table" + i).OrderD[i] > 0)
      {
         return true;
      }
      i++;
   }
}
function PlaceOnTray(dp)
{
   YES = false;
   OrganizeTray();
   if(dp == 1)
   {
      if(Scene.W.TotalPlates == 0 and Scene.W.TotalDrinks < 8)
      {
         YES = true;
      }
      if(Scene.W.TotalPlates == 1 and Scene.W.TotalDrinks < 5)
      {
         YES = true;
      }
      if(Scene.W.TotalPlates == 2 and Scene.W.TotalDrinks < 2)
      {
         YES = true;
      }
   }
   if(dp == 2)
   {
      if(Scene.W.TotalPlates == 0 and Scene.W.TotalDrinks <= 5)
      {
         YES = true;
      }
      if(Scene.W.TotalPlates == 1 and Scene.W.TotalDrinks <= 2)
      {
         YES = true;
      }
   }
   if(!YES)
   {
      Menu.Buttons.Flash.gotoAndPlay(2);
   }
   return YES;
}
function IsDirty(num)
{
   result = true;
   if(eval("Scene.Table" + num).DirtyP[1] == 0 and eval("Scene.Table" + num).DirtyP[2] == 0 and eval("Scene.Table" + num).DirtyD[1] == 0 and eval("Scene.Table" + num).DirtyD[2] == 0)
   {
      result = false;
   }
   return result;
}
function InitLists()
{
   i = 1;
   while(i <= 4)
   {
      eval("Menu.List" + i).List = new Array(0,0,0,0,0);
      eval("Menu.List" + i).Done = new Array(false,false,false,false,false);
      eval("Menu.List" + i).TotalItems = 0;
      eval("Menu.List" + i)._visible = false;
      i++;
   }
}
function ResetList(table)
{
   i = 1;
   while(i <= 4)
   {
      eval("Menu.List" + table).List[i] = 0;
      eval("Menu.List" + table).Done[i] = false;
      i++;
   }
   eval("Menu.List" + table).TotalItems = 0;
   eval("Menu.List" + table)._visible = false;
}
function AddToList(table, item)
{
   eval("Menu.List" + table).TotalItems++;
   eval("Menu.List" + table).List[eval("Menu.List" + table).TotalItems] = item;
}
function RemoveFromList(table, item)
{
   i = 1;
   while(i <= 4)
   {
      if(eval("Menu.List" + table).List[i] == item and !eval("Menu.List" + table).Done[i])
      {
         eval("Menu.List" + table).Done[i] = true;
         break;
      }
      i++;
   }
}
function PointerSymbol()
{
   Symbol = 0;
   if(Scene.Table1.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 1;
   }
   if(Scene.Table2.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 2;
   }
   if(Scene.Table3.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 3;
   }
   if(Scene.Table4.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 4;
   }
   if(Scene.TCan.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 5;
   }
   if(Scene.CMachine.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 6;
   }
   if(Scene.PBox.Body.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 7;
   }
   if(Scene.Fridge.hitTest(_xmouse,_ymouse,true))
   {
      Symbol = 8;
   }
   if(Scene.Kitchen.hitTest(_xmouse,_ymouse,false))
   {
      Symbol = 9;
   }
   if(Scene.Worker.hitTest(_xmouse,_ymouse,true))
   {
      Symbol = 10;
   }
   if(Symbol == 0)
   {
      Menu.Pointer._visible = false;
   }
   else
   {
      Menu.Pointer._visible = true;
      Menu.Pointer.gotoAndStop(Symbol);
   }
   if(Scene.W.Tnum > 0)
   {
      Menu.Target._visible = true;
      Menu.Target.Symbol.gotoAndStop(Scene.W.Tnum);
      if(Scene.W.dir == 0 and !Scene.W.Busy)
      {
         Menu.Target.Status.gotoAndStop(1);
      }
      if(Scene.W.dir == 1 and !Scene.W.Busy)
      {
         Menu.Target.Status.gotoAndStop(2);
      }
      if(Scene.W.MenuActive)
      {
         Menu.Target.Status.gotoAndStop(4);
      }
      if(Scene.W.Busy)
      {
         Menu.Target.Status.gotoAndStop(3);
      }
   }
   else
   {
      Menu.Target._visible = false;
   }
   if(Scene.W.Busy)
   {
      Menu.Busy._visible = true;
   }
   else
   {
      Menu.Busy._visible = false;
   }
}
function ResetTable(tn)
{
   eval("Scene.Table" + tn).Plate1._x = -26.4;
   eval("Scene.Table" + tn).Plate1._y = -43.2;
   eval("Scene.Table" + tn).Plate2._x = 26.6;
   eval("Scene.Table" + tn).Plate2._y = -43.2;
   eval("Scene.Table" + tn).Drink1._x = -12.4;
   eval("Scene.Table" + tn).Drink1._y = -45.6;
   eval("Scene.Table" + tn).Drink2._x = 12.6;
   eval("Scene.Table" + tn).Drink2._y = -45.7;
}
Pause = false;
Cmax = 0;
Cups = 20;
PinB = 0;
TT = 4;
PlacesX = new Array(-20,112.5,263.9,396.6,538.8,671.5,813.7,946.5);
TablesOc = new Array(false,false,false,false);
Dexchange = new Array(1,2,6,7,8,3,4,5);
ColdDrinks = new Array(0,10,10,10);
DishReady = false;
TrashCan = 0;
Ko = 1;
Level = 1;
MinWTime = 0;
Score = 0;
Lives = 3;
Digits = new Array(10);
Fanfare = new Sound();
Fanfare.attachSound("FANFARE");
Scene.ClientExample._visible = false;
Scene.Cook.Type = 1;
InitTables();
InitLists();
AddClient();
Scene.WExample.duplicateMovieClip("W",20);
InitWaitress();
UpdateScore();
UpdateLives();
HLP._visible = false;
