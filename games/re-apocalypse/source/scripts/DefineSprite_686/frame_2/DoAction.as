function buildMap(map)
{
   attachMovie("empty","tiles",1);
   game.clip = tiles;
   var mapWidth = map[0].length;
   var mapHeight = map.length;
   var _loc3_ = 0;
   var _loc2_;
   var _loc1_;
   while(_loc3_ < mapHeight)
   {
      _loc2_ = 0;
      while(_loc2_ < mapWidth)
      {
         _loc1_ = "t_" + _loc3_ + "_" + _loc2_;
         game[_loc1_] = new game["Tile" + map[_loc3_][_loc2_]]();
         game.clip.attachMovie("tile",_loc1_,_loc3_ * 100 + _loc2_ * 2);
         game.clip[_loc1_]._x = _loc2_ * game.tileW;
         game.clip[_loc1_]._y = _loc3_ * game.tileH;
         game.clip[_loc1_].gotoAndStop(game[_loc1_].frame);
         _loc2_ = _loc2_ + 1;
      }
      _loc3_ = _loc3_ + 1;
   }
   points = game.points;
   game.clip.attachMovie("char","char",500);
   char.clip = game.clip.char;
   char.x = char.xtile * game.tileW + game.tileW / 2;
   char.y = char.ytile * game.tileH + game.tileH / 2;
   char.clip._x = char.x;
   char.clip._y = char.y;
}
function getMyCorners(x, y, ob)
{
   var _loc1_ = ob;
   _loc1_.downY = Math.floor((y + _loc1_.height - 1) / game.tileH);
   _loc1_.upY = Math.floor((y - _loc1_.height) / game.tileH);
   _loc1_.leftX = Math.floor((x - _loc1_.width) / game.tileW);
   _loc1_.rightX = Math.floor((x + _loc1_.width - 1) / game.tileW);
   _loc1_.upleft = game["t_" + _loc1_.upY + "_" + _loc1_.leftX].walkable;
   _loc1_.downleft = game["t_" + _loc1_.downY + "_" + _loc1_.leftX].walkable;
   _loc1_.upright = game["t_" + _loc1_.upY + "_" + _loc1_.rightX].walkable;
   _loc1_.downright = game["t_" + _loc1_.downY + "_" + _loc1_.rightX].walkable;
}
function moveChar(ob, dirx, diry)
{
   var _loc1_ = ob;
   var _loc2_ = diry;
   var _loc3_ = dirx;
   _loc1_.dirx = _loc3_;
   _loc1_.diry = _loc2_;
   getMyCorners(_loc1_.x,_loc1_.y + _loc1_.speed * _loc2_,_loc1_);
   if(_loc2_ == -1)
   {
      if(_loc1_.upleft and _loc1_.upright)
      {
         _loc1_.y += _loc1_.speed * _loc2_;
      }
      else
      {
         _loc1_.y = _loc1_.ytile * game.tileH + _loc1_.height;
      }
   }
   if(_loc2_ == 1)
   {
      if(_loc1_.downleft and _loc1_.downright)
      {
         _loc1_.y += _loc1_.speed * _loc2_;
      }
      else
      {
         _loc1_.y = (_loc1_.ytile + 1) * game.tileH - _loc1_.height;
      }
   }
   getMyCorners(_loc1_.x + _loc1_.speed * _loc3_,_loc1_.y,_loc1_);
   if(_loc3_ == -1)
   {
      if(_loc1_.downleft and _loc1_.upleft)
      {
         _loc1_.x += _loc1_.speed * _loc3_;
      }
      else
      {
         _loc1_.x = _loc1_.xtile * game.tileW + _loc1_.width;
      }
   }
   if(_loc3_ == 1)
   {
      if(_loc1_.upright and _loc1_.downright)
      {
         _loc1_.x += _loc1_.speed * _loc3_;
      }
      else
      {
         _loc1_.x = (_loc1_.xtile + 1) * game.tileW - _loc1_.width;
      }
   }
   var itemname = game["item" + _loc1_.xtile + "_" + _loc1_.ytile];
   if(itemname and _loc1_ == char)
   {
      _loc1_.weapon = itemname.weapon;
      _loc1_.shots = itemname.shots;
      _loc1_.clip.gotoAndStop(_loc1_.weapon);
      removeMovieClip(itemname.clip);
      delete game["item" + _loc1_.ytile + "_" + _loc1_.xtile];
   }
   _loc1_.clip._x = _loc1_.x;
   _loc1_.clip._y = _loc1_.y;
   _loc1_.xtile = Math.floor(_loc1_.clip._x / game.tileW);
   _loc1_.ytile = Math.floor(_loc1_.clip._y / game.tileH);
   if(_loc3_ == 0 and _loc2_ == -1)
   {
      _loc1_.clip.obj.gotoAndStop(1);
   }
   else if(_loc3_ == 1 and _loc2_ == 0)
   {
      _loc1_.clip.obj.gotoAndStop(2);
   }
   else if(_loc3_ == 0 and _loc2_ == 1)
   {
      _loc1_.clip.obj.gotoAndStop(3);
   }
   else if(_loc3_ == -1 and _loc2_ == 0)
   {
      _loc1_.clip.obj.gotoAndStop(4);
   }
   else if(_loc3_ == 1 and _loc2_ == -1)
   {
      _loc1_.clip.obj.gotoAndStop(5);
   }
   else if(_loc3_ == -1 and _loc2_ == -1)
   {
      _loc1_.clip.obj.gotoAndStop(6);
   }
   else if(_loc3_ == 1 and _loc2_ == 1)
   {
      _loc1_.clip.obj.gotoAndStop(7);
   }
   else if(_loc3_ == -1 and _loc2_ == 1)
   {
      _loc1_.clip.obj.gotoAndStop(8);
   }
   _loc1_.clip.swapDepths((_loc1_.ytile * 100 + _loc1_.xtile * 2) * 100 + _loc1_.id);
   return true;
}
function shoot(ob)
{
   var _loc2_ = ob;
   if(char.shots > 0)
   {
      char.shots--;
      if(char.shots == 0)
      {
         char.weapon = 1;
         char.clip.gotoAndStop(char.weapon);
      }
   }
   _loc2_.lastshot = getTimer();
   game.bulletcounter++;
   if(game.bulletcounter > 100)
   {
      game.bulletcounter = 0;
   }
   var _loc1_ = "bullet" + game.bulletcounter;
   game[_loc1_] = new game.Bullet();
   game[_loc1_].id = game.bulletcounter;
   game.bullets.push(game[_loc1_]);
   if(_loc2_.dirx or _loc2_.diry)
   {
      game[_loc1_].dirx = _loc2_.dirx;
      game[_loc1_].diry = _loc2_.diry;
   }
   game[_loc1_].xtile = _loc2_.xtile;
   game[_loc1_].ytile = _loc2_.ytile;
   game.clip.attachMovie("bullet",_loc1_,10100 + game.bulletcounter);
   game[_loc1_].clip = game.clip[_loc1_];
   var _loc3_;
   if(char.weapon == 2)
   {
      _loc3_ = 1;
   }
   else
   {
      _loc3_ = 0;
   }
   game[_loc1_].x = _loc2_.x + game[_loc1_].dirx + bulletOffsets[_loc3_][char.dir][0];
   game[_loc1_].y = _loc2_.y + game[_loc1_].diry + bulletOffsets[_loc3_][char.dir][1];
   game.clip[_loc1_]._x = game[_loc1_].x;
   game.clip[_loc1_]._y = game[_loc1_].y;
   if(char.weapon == 2)
   {
      game.bulletcounter++;
      if(game.bulletcounter > 100)
      {
         game.bulletcounter = 0;
      }
      _loc1_ = "bullet" + game.bulletcounter;
      game[_loc1_] = new game.Bullet();
      game[_loc1_].id = game.bulletcounter;
      game.bullets.push(game[_loc1_]);
      if(_loc2_.dirx or _loc2_.diry)
      {
         game[_loc1_].dirx = _loc2_.dirx;
         game[_loc1_].diry = _loc2_.diry;
      }
      game[_loc1_].xtile = _loc2_.xtile;
      game[_loc1_].ytile = _loc2_.ytile;
      game.clip.attachMovie("bullet",_loc1_,10100 + game.bulletcounter);
      game[_loc1_].clip = game.clip[_loc1_];
      game[_loc1_].x = _loc2_.x + game[_loc1_].dirx + bulletOffsets[2][char.dir][0];
      game[_loc1_].y = _loc2_.y + game[_loc1_].diry + bulletOffsets[2][char.dir][1];
      game.clip[_loc1_]._x = game[_loc1_].x;
      game.clip[_loc1_]._y = game[_loc1_].y;
   }
   _loc2_.clip.obj.char.top.fire.gotoAndPlay(2);
}
function moveBullets()
{
   var i = 0;
   var _loc1_;
   var _loc2_;
   var _loc3_;
   while(i < game.bullets.length)
   {
      _loc1_ = game.bullets[i];
      getMyCorners(_loc1_.x + _loc1_.speed * _loc1_.dirx,_loc1_.y + _loc1_.speed * _loc1_.diry,_loc1_);
      if(_loc1_.downleft and _loc1_.upleft and _loc1_.downright and _loc1_.upright)
      {
         moveChar(_loc1_,_loc1_.dirx,_loc1_.diry);
      }
      else
      {
         _loc1_.clip.removeMovieClip();
         delete game["bullet" + game.bullets[i].id];
         game.bullets.splice(i,1);
      }
      _loc2_ = 0;
      while(_loc2_ < game.currentEnemies.length)
      {
         var name = "enemy" + game.currentEnemies[_loc2_].id;
         _loc3_ = game[name];
         var xdist = _loc1_.x - _loc3_.x;
         var ydist = _loc1_.y - _loc3_.y;
         if(Math.sqrt(xdist * xdist + ydist * ydist) < _loc1_.width + _loc3_.width)
         {
            _loc3_.clip.obj.char.gotoAndPlay("explode");
            if(char.weapon == 3)
            {
               game.clip.attachMovie("bigExplosion","bang" + bulletcount,1000000);
               game.clip["bang" + bulletcount]._x = _loc1_.x - bigBang._width / 2;
               game.clip["bang" + bulletcount]._y = _loc1_.y - bigBang._height / 2;
               game.clip["bang" + bulletcount].gotoAndPlay(2);
            }
            _root.zombieTotal++;
            delete game["enemy" + game.currentEnemies[_loc2_].id];
            game.currentEnemies.splice(_loc2_,1);
            enemywavetrigger++;
            _loc1_.clip.removeMovieClip();
            delete game["bullet" + game.bullets[i].id];
            game.bullets.splice(i,1);
            if(game.currentEnemies.length == 0 or enemywavetrigger == 3)
            {
               createEnemyWave();
            }
         }
         _loc2_ = _loc2_ + 1;
      }
      i++;
   }
}
function createEnemyWave()
{
   game.currentEnemyWave++;
   if(game.currentEnemyWave >= myEnemies.length)
   {
      game.currentEnemyWave = 1;
      game.Enemyp1.prototype.speed += 0.5;
   }
   enemywavetrigger = 0;
   var _loc3_ = myEnemies[game.currentEnemyWave];
   var _loc2_ = 0;
   var _loc1_;
   while(_loc2_ < _loc3_.length)
   {
      game.enemycounter++;
      if(game.enemycounter > 100)
      {
         game.enemycounter = 0;
      }
      _loc1_ = "enemy" + game.enemycounter;
      game[_loc1_] = new game["Enemyp" + _loc3_[_loc2_][0]]();
      game[_loc1_].id = game.enemycounter;
      game.currentEnemies.push(game[_loc1_]);
      game.clip.attachMovie("enemy" + _loc3_[_loc2_][0],_loc1_,_loc3_[_loc2_][2] * 100 + _loc3_[_loc2_][1] * 2);
      game[_loc1_].clip = game.clip[_loc1_];
      game[_loc1_].xtile = _loc3_[_loc2_][1];
      game[_loc1_].ytile = _loc3_[_loc2_][2];
      game[_loc1_].x = game[_loc1_].xtile * game.tileW + game.tileW / 2;
      game[_loc1_].y = game[_loc1_].ytile * game.tileH + game.tileH / 2;
      game[_loc1_].clip._x = game[_loc1_].x;
      game[_loc1_].clip._y = game[_loc1_].y;
      _loc2_ = _loc2_ + 1;
   }
   var rand = Math.floor(random(4) + 1);
   zombiesounds.gotoAndPlay("g" + rand);
   createItems();
}
function enemyBrain()
{
   var _loc2_ = 0;
   var _loc1_;
   var _loc3_;
   while(_loc2_ < game.currentEnemies.length)
   {
      _loc1_ = game.currentEnemies[_loc2_];
      getMyCorners(_loc1_.x + _loc1_.speed * _loc1_.xMove,_loc1_.y + _loc1_.speed * _loc1_.yMove,_loc1_);
      if(_loc1_.downleft and _loc1_.upleft and _loc1_.downright and _loc1_.upright)
      {
         if(_loc1_.xtile > char.xtile)
         {
            var dx = -1;
         }
         else if(_loc1_.xtile < char.xtile)
         {
            var dx = 1;
         }
         else
         {
            var dx = 0;
         }
         if(_loc1_.ytile > char.ytile)
         {
            var dy = -1;
         }
         else if(_loc1_.ytile < char.ytile)
         {
            var dy = 1;
         }
         else
         {
            var dy = 0;
         }
         moveChar(_loc1_,dx,dy);
      }
      else if(_loc1_.xMove == 0)
      {
         _loc1_.xMove = random(2) * 2 - 1;
         _loc1_.yMove = 0;
         getMyCorners(_loc1_.x + _loc1_.speed * _loc1_.xMove,_loc1_.y + _loc1_.speed * _loc1_.yMove,_loc1_);
         if(!_loc1_.downleft or !_loc1_.upleft or !_loc1_.downright or !_loc1_.upright)
         {
            _loc1_.xMove = - _loc1_.xMove;
         }
      }
      else
      {
         _loc1_.xMove = 0;
         _loc1_.yMove = random(2) * 2 - 1;
         getMyCorners(_loc1_.x + _loc1_.speed * _loc1_.xMove,_loc1_.y + _loc1_.speed * _loc1_.yMove,_loc1_);
         if(!_loc1_.downleft or !_loc1_.upleft or !_loc1_.downright or !_loc1_.upright)
         {
            _loc1_.yMove = - _loc1_.yMove;
         }
      }
      var xdist = _loc1_.x - char.x;
      _loc3_ = _loc1_.y - char.y;
      if(Math.sqrt(xdist * xdist + _loc3_ * _loc3_) < _loc1_.width + char.width)
      {
         char.clip.obj.gotoAndStop(9);
         if(_loc1_.x < char.x)
         {
            _loc1_.clip.obj.gotoAndStop(2);
         }
         else
         {
            _loc1_.clip.obj.gotoAndStop(4);
         }
         _loc1_.clip._y = char.clip._y;
         _loc1_.clip.obj.char.top.gotoAndPlay("eat");
         _loc1_.clip.swapDepths(100000);
         gotoAndStop("gameOver");
         play();
      }
      _loc2_ = _loc2_ + 1;
   }
}
function createItems()
{
   var _loc3_ = myItems[game.currentEnemyWave];
   var _loc2_ = 0;
   var _loc1_;
   while(_loc2_ < _loc3_.length)
   {
      game.itemcounter++;
      if(game.itemcounter > 100)
      {
         game.itemcounter = 0;
      }
      _loc1_ = "item" + _loc3_[_loc2_][1] + "_" + _loc3_[_loc2_][2];
      game[_loc1_] = new game["itemp" + _loc3_[_loc2_][0]]();
      game[_loc1_].id = game.itemcounter;
      game[_loc1_].xtile = _loc3_[_loc2_][1];
      game[_loc1_].ytile = _loc3_[_loc2_][2];
      game.clip.attachMovie("item" + _loc3_[_loc2_][0],_loc1_,_loc3_[_loc2_][1] * 100 + _loc3_[_loc2_][2] * 2);
      game[_loc1_].clip = game.clip[_loc1_];
      game[_loc1_].x = game[_loc1_].xtile * game.tileW + game.tileW / 2;
      game[_loc1_].y = game[_loc1_].ytile * game.tileH + game.tileH / 2;
      game.clip[_loc1_]._x = game[_loc1_].x;
      game.clip[_loc1_]._y = game[_loc1_].y;
      _loc2_ = _loc2_ + 1;
   }
}
function detectKeys()
{
   var _loc1_ = char;
   var _loc2_ = false;
   if(Key.isDown(38) and !Key.isDown(39) and !Key.isDown(40) and !Key.isDown(37))
   {
      char.dir = 1;
      _loc2_ = moveChar(_loc1_,0,-1);
   }
   if(!Key.isDown(38) and Key.isDown(39) and !Key.isDown(40) and !Key.isDown(37))
   {
      char.dir = 2;
      _loc2_ = moveChar(_loc1_,1,0);
   }
   if(!Key.isDown(38) and !Key.isDown(39) and Key.isDown(40) and !Key.isDown(37))
   {
      char.dir = 3;
      _loc2_ = moveChar(_loc1_,0,1);
   }
   if(!Key.isDown(38) and !Key.isDown(39) and !Key.isDown(40) and Key.isDown(37))
   {
      char.dir = 4;
      _loc2_ = moveChar(_loc1_,-1,0);
   }
   if(Key.isDown(38) and Key.isDown(39) and !Key.isDown(40) and !Key.isDown(37))
   {
      char.dir = 5;
      _loc2_ = moveChar(_loc1_,1,-1);
   }
   if(Key.isDown(38) and !Key.isDown(39) and !Key.isDown(40) and Key.isDown(37))
   {
      char.dir = 6;
      _loc2_ = moveChar(_loc1_,-1,-1);
   }
   if(!Key.isDown(38) and Key.isDown(39) and Key.isDown(40) and !Key.isDown(37))
   {
      char.dir = 7;
      _loc2_ = moveChar(_loc1_,1,1);
   }
   if(!Key.isDown(38) and !Key.isDown(39) and Key.isDown(40) and Key.isDown(37))
   {
      char.dir = 8;
      _loc2_ = moveChar(_loc1_,-1,1);
   }
   if(Key.isDown(32) and getTimer() > _loc1_.lastshot + _loc1_.shootspeed)
   {
      shoot(_loc1_);
   }
   if(!_loc2_)
   {
      _loc1_.clip.obj.char.legs.gotoAndStop(1);
      _loc1_.clip.obj.char.slegs.gotoAndStop(1);
   }
   else
   {
      _loc1_.clip.obj.char.legs.play();
      _loc1_.clip.obj.char.slegs.play();
   }
   moveBullets();
   enemyBrain();
   game.delaycount++;
   var _loc3_;
   if(game.delaycount >= 5)
   {
      _loc3_ = getTimer();
      _root.timer = Math.floor((_loc3_ - game.starttime) / 1000);
      game.delaycount = 0;
   }
}
myMap1 = [[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],[1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1],[1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1],[1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1],[1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1],[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],[1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1],[1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1],[1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]];
game = {tileW:40,tileH:40,currentMap:1,currentEnemyWave:0,enemywavetrigger:0,enemycounter:0,starttime:0,bulletcounter:0,itemcounter:0,points:0};
game.Tile0 = function()
{
};
game.Tile0.prototype.walkable = true;
game.Tile0.prototype.frame = 1;
game.Tile1 = function()
{
};
game.Tile1.prototype.walkable = false;
game.Tile1.prototype.frame = 2;
char = {xtile:8,ytile:5,width:15,height:15,weapon:1,dir:1,speed:4,shots:0,shootspeed:400};
game.bullets = new Array();
game.Bullet = function()
{
};
game.Bullet.prototype.speed = 15;
game.Bullet.prototype.dirx = 0;
game.Bullet.prototype.diry = -1;
game.Bullet.prototype.width = 2;
game.Bullet.prototype.height = 2;
bulletOffsets = [[[0],[0,0],[0,-10],[0,0],[0,-10],[0,0],[0,0],[0,0],[0,0]],[[0],[-10,-10],[10,-10],[10,10],[-10,-10],[0,-10],[0,-10],[0,10],[-10,10]],[[0],[10,10],[-10,-20],[-10,-10],[10,-20],[10,0],[-10,0],[10,0],[-10,-10]]];
game.currentEnemies = new Array();
myEnemies = [[0],[[1,1,5],[1,1,9]],[[1,8,10],[1,3,10]],[[1,1,5],[1,15,8]],[[1,1,5],[1,6,12],[1,15,8]],[[1,1,5],[1,8,12],[1,4,12],[1,1,12]],[[1,1,6],[1,7,12],[1,15,8],[1,10,1]],[[1,1,7],[1,6,12],[1,15,8],[1,10,1]],[[1,5,1],[1,2,12],[1,13,1],[1,10,1]],[[1,1,5],[1,6,12],[1,15,8]]];
game.Enemyp1 = function()
{
};
game.Enemyp1.prototype.xMove = 0;
game.Enemyp1.prototype.yMove = 1;
game.Enemyp1.prototype.speed = 2;
game.Enemyp1.prototype.turning = 5;
game.Enemyp1.prototype.width = 20;
game.Enemyp1.prototype.height = 20;
myItems = [[0],[[0]],[[0]],[[2,11,3]],[[0]],[[0]],[[0]],[[3,6,3]],[[0]]];
game.itemp1 = function()
{
};
game.itemp1.prototype.weapon = 1;
game.itemp3.prototype.shots = 0;
game.itemp2 = function()
{
};
game.itemp2.prototype.weapon = 2;
game.itemp2.prototype.shots = 20;
game.itemp3 = function()
{
};
game.itemp3.prototype.weapon = 3;
game.itemp3.prototype.shots = 10;
buildMap(eval("myMap" + game.currentMap));
game.starttime = getTimer();
game.delaycount = 0;
createEnemyWave();
