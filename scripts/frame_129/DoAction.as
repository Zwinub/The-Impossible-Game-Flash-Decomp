function onMouseDown()
{
   if(!(_xmouse < 341 && _xmouse > 139 && _ymouse > 241 && _ymouse < 312) && !(_xmouse > 6 && _xmouse < 70 && _ymouse > 6 && _ymouse < 44))
   {
      touching = true;
   }
}
function onMouseUp()
{
   touching = false;
}
function pauseCode()
{
   paused = true;
   soundPosition = trackSound.position / 1000;
   trackSound.stop();
   paused_menu.nextFrame();
   menu_button.enabled = false;
   flag_button.enabled = false;
   flagdelete_button.enabled = false;
}
function flagPress()
{
   if(!exploding && !finished && flagsLeft > 0)
   {
      if(!practiceMode)
      {
         practiceMode = true;
         practiceHeader._visible = true;
         trackSound.stop();
         trackSound.attachSound("practicetrack");
         trackSound.start(0,1);
      }
      addFlag(player._x,player._y + 15,player._y + 15 - (floor._y - 213));
      onFlag++;
      flagsLeft--;
      flagsLeftT.text = "Flags Left: " + flagsLeft;
   }
}
function flagDelete()
{
   if(onFlag > 0 && !finished)
   {
      flags[onFlag].removeMovieClip();
      flags.pop();
      onFlag--;
      flagsLeft++;
      flagsLeftT.text = "Flags Left: " + flagsLeft;
      flags[onFlag].flagOpacity = 100;
   }
}
function onEnterFrame()
{
   if(!paused)
   {
      if(Key.isDown(80))
      {
         pauseCode();
      }
      if(Key.isDown(68))
      {
         if(Drelease)
         {
            flagDelete();
            Drelease = false;
         }
      }
      else
      {
         Drelease = true;
      }
      if(exploding)
      {
         var _loc1_ = 0;
         while(_loc1_ < particles.length)
         {
            particles[_loc1_]._x += particles[_loc1_].speedX;
            particles[_loc1_]._y += particles[_loc1_].speedY;
            particles[_loc1_].speedX *= 0.8;
            particles[_loc1_].speedY *= 0.8;
            particles[_loc1_]._alpha *= 0.9;
            if(particles[_loc1_]._alpha < 1)
            {
               resetGame();
            }
            _loc1_ = _loc1_ + 1;
         }
      }
      else
      {
         if(Key.isDown(70))
         {
            if(Frelease)
            {
               flagPress();
               Frelease = false;
            }
         }
         else
         {
            Frelease = true;
         }
         if((touching || Key.isDown(32)) && !jump)
         {
            jump = true;
            gravity = -17;
         }
         if(jump)
         {
            player._y += gravity;
            if(gravity < 20)
            {
               gravity += 2.7;
            }
            player._rotation += 12.9;
            if(player._y > 198 && !inAir)
            {
               jump = false;
               player._y = 198;
               player._rotation = 0;
            }
         }
         if(player._y < 70)
         {
            inAir = true;
            var _loc3_ = player._y - 70;
            _loc1_ = 0;
            while(_loc1_ < blocks.length)
            {
               blocks[_loc1_]._y -= _loc3_;
               _loc1_ = _loc1_ + 1;
            }
            _loc1_ = 0;
            while(_loc1_ < spikes.length)
            {
               spikes[_loc1_]._y -= _loc3_;
               _loc1_ = _loc1_ + 1;
            }
            _loc1_ = 0;
            while(_loc1_ < pits.length)
            {
               pits[_loc1_]._y -= _loc3_;
               _loc1_ = _loc1_ + 1;
            }
            if(practiceMode)
            {
               _loc1_ = 0;
               while(_loc1_ < flags.length)
               {
                  flags[_loc1_]._y -= _loc3_;
                  _loc1_ = _loc1_ + 1;
               }
            }
            floor._y -= _loc3_;
            player._y = 70;
         }
         else if(player._y > 198)
         {
            _loc3_ = 198 - player._y;
            _loc1_ = 0;
            while(_loc1_ < blocks.length)
            {
               blocks[_loc1_]._y += _loc3_;
               _loc1_ = _loc1_ + 1;
            }
            _loc1_ = 0;
            while(_loc1_ < spikes.length)
            {
               spikes[_loc1_]._y += _loc3_;
               _loc1_ = _loc1_ + 1;
            }
            _loc1_ = 0;
            while(_loc1_ < pits.length)
            {
               pits[_loc1_]._y += _loc3_;
               _loc1_ = _loc1_ + 1;
            }
            if(practiceMode)
            {
               _loc1_ = 0;
               while(_loc1_ < flags.length)
               {
                  flags[_loc1_]._y += _loc3_;
                  _loc1_ = _loc1_ + 1;
               }
            }
            floor._y += _loc3_;
            player._y = 198;
         }
         if(inAir && floor._y < 213)
         {
            player._y = 198;
            floor._y = 213;
            inAir = false;
            _loc1_ = 0;
            while(_loc1_ < blocks.length)
            {
               blocks[_loc1_]._y = blocks[_loc1_].origY;
               _loc1_ = _loc1_ + 1;
            }
            _loc1_ = 0;
            while(_loc1_ < spikes.length)
            {
               spikes[_loc1_]._y = spikes[_loc1_].origY;
               _loc1_ = _loc1_ + 1;
            }
            _loc1_ = 0;
            while(_loc1_ < pits.length)
            {
               pits[_loc1_]._y = 213;
               _loc1_ = _loc1_ + 1;
            }
            if(practiceMode)
            {
               _loc1_ = 0;
               while(_loc1_ < flags.length)
               {
                  flags[_loc1_]._y = flags[_loc1_].origY;
                  _loc1_ = _loc1_ + 1;
               }
            }
         }
         if(imaginaryMove < 7800)
         {
            imaginaryMove += 11;
         }
         else
         {
            trackSound.stop();
            finished = true;
            end.nextFrame();
            flag_button.enabled = false;
            flagdelete_button.enabled = false;
            menu_button.enabled = false;
            delete onEnterFrame;
         }
         _loc1_ = startOfList;
         while(_loc1_ < objectPos.length)
         {
            var _loc2_ = objectPos[_loc1_] - imaginaryMove;
            if(!(_loc2_ < 500 && _loc2_ > 488))
            {
               break;
            }
            var _loc6_ = objectPos[_loc1_ + 1] - 213 + floor._y;
            var _loc5_ = objectPos[_loc1_ + 2];
            var _loc4_ = objectPos[_loc1_ + 1];
            if(_loc5_ == 1)
            {
               addBlock(_loc2_,_loc6_,_loc4_,0,false);
            }
            else if(_loc5_ == 2)
            {
               addSpike(_loc2_,_loc6_,_loc4_,0);
            }
            startOfList += 3;
            _loc1_ += 3;
         }
         _loc1_ = startOfList2;
         while(_loc1_ < pitsPos.length)
         {
            _loc2_ = pitsPos[_loc1_] - imaginaryMove;
            if(!(_loc2_ < 500 && _loc2_ > 488))
            {
               break;
            }
            addPit(_loc2_,floor._y,0);
            startOfList2++;
            _loc1_ = _loc1_ + 1;
         }
         var _loc7_ = false;
         playerRectTop._x = player._x - 15;
         playerRectTop._y = player._y - 15;
         playerRectTop2._x = player._x - 15;
         playerRectTop2._y = player._y - 15;
         playerRect._x = player._x;
         playerRect._y = player._y;
         var _loc10_ = spikes.slice();
         _loc1_ = 0;
         while(_loc1_ < spikes.length)
         {
            if(spikes[_loc1_]._alpha > 0 && spikes[_loc1_]._x < 100)
            {
               spikes[_loc1_]._alpha -= 10;
            }
            else if(spikes[_loc1_]._alpha < 100 && spikes[_loc1_]._x < 480)
            {
               spikes[_loc1_]._alpha += 10;
            }
            spikes[_loc1_]._x -= 11;
            if(spikes[_loc1_]._x < 180 && spikes[_loc1_]._x > 80)
            {
               if(playerRectTop.hitTest(spikes[_loc1_].rect1) || playerRectTop.hitTest(spikes[_loc1_].rect2))
               {
                  _loc7_ = true;
               }
            }
            if(spikes[_loc1_]._x < -20)
            {
               spikes[_loc1_].removeMovieClip();
               _loc10_.splice(_loc1_,1);
            }
            _loc1_ = _loc1_ + 1;
         }
         spikes = _loc10_.slice();
         var _loc8_ = blocks.slice();
         _loc1_ = 0;
         while(_loc1_ < blocks.length)
         {
            if(blocks[_loc1_]._alpha > 0 && blocks[_loc1_]._x < 100)
            {
               blocks[_loc1_]._alpha -= 10;
            }
            else if(blocks[_loc1_]._alpha < 100 && blocks[_loc1_]._x < 480)
            {
               blocks[_loc1_]._alpha += 10;
            }
            blocks[_loc1_]._x -= 11;
            if(blocks[_loc1_]._x < 180 && blocks[_loc1_]._x > 80)
            {
               if(playerRectTop2.hitTest(blocks[_loc1_]))
               {
                  _loc7_ = true;
               }
               else if(playerRect.hitTest(blocks[_loc1_]))
               {
                  jump = false;
                  player._y = blocks[_loc1_]._y - 29;
                  player._rotation = 0;
                  blocks[_loc1_].playerBlock = true;
               }
               else if(blocks[_loc1_].playerBlock && !jump)
               {
                  jump = true;
                  gravity = 0;
                  blocks[_loc1_].playerBlock = false;
               }
            }
            if(blocks[_loc1_]._x < -20)
            {
               blocks[_loc1_].removeMovieClip();
               _loc8_.splice(_loc1_,1);
            }
            _loc1_ = _loc1_ + 1;
         }
         blocks = _loc8_.slice();
         var _loc9_ = pits.slice();
         _loc1_ = 0;
         while(_loc1_ < pits.length)
         {
            if(pits[_loc1_]._alpha > 0 && pits[_loc1_]._x < 100)
            {
               pits[_loc1_]._alpha -= 10;
            }
            else if(pits[_loc1_]._alpha < 100 && pits[_loc1_]._x < 480)
            {
               pits[_loc1_]._alpha += 10;
            }
            pits[_loc1_]._x -= 11;
            if(pits[_loc1_]._x < 180 && pits[_loc1_]._x > 80)
            {
               if(playerRect.hitTest(pits[_loc1_].rect))
               {
                  _loc7_ = true;
               }
            }
            if(pits[_loc1_]._x < -20)
            {
               pits[_loc1_].removeMovieClip();
               _loc9_.splice(_loc1_,1);
            }
            _loc1_ = _loc1_ + 1;
         }
         pits = _loc9_.slice();
         if(practiceMode)
         {
            _loc1_ = 0;
            while(_loc1_ < flags.length)
            {
               if(flags[_loc1_]._alpha > 0 && flags[_loc1_]._x < 100)
               {
                  flags[_loc1_]._alpha -= 10;
               }
               flags[_loc1_]._x -= 11;
               _loc1_ = _loc1_ + 1;
            }
         }
         if(_loc7_)
         {
            exploding = true;
            particleSpawn(player._x,player._y);
            player._visible = false;
            if(!practiceMode)
            {
               trackSound.stop();
            }
            explosionSound.start(0,1);
         }
      }
   }
}
function resetGame()
{
   var _loc1_ = 0;
   while(_loc1_ < particles.length)
   {
      particles[_loc1_].removeMovieClip();
      _loc1_ = _loc1_ + 1;
   }
   _loc1_ = 0;
   while(_loc1_ < spikes.length)
   {
      spikes[_loc1_].removeMovieClip();
      _loc1_ = _loc1_ + 1;
   }
   _loc1_ = 0;
   while(_loc1_ < blocks.length)
   {
      blocks[_loc1_].removeMovieClip();
      _loc1_ = _loc1_ + 1;
   }
   _loc1_ = 0;
   while(_loc1_ < pits.length)
   {
      pits[_loc1_].removeMovieClip();
      _loc1_ = _loc1_ + 1;
   }
   spikes = new Array();
   blocks = new Array();
   pits = new Array();
   particles = new Array();
   if(practiceMode)
   {
      flags[onFlag]._x = flags[onFlag].flagsX;
      flags[onFlag]._y = flags[onFlag].flagsY;
      imaginaryMove = flags[onFlag].imaginaryMove;
      startOfList = flags[onFlag].startOfList;
      startOfList2 = flags[onFlag].startOfList2;
      floor._y = flags[onFlag].flagFloorY;
      inAir = flags[onFlag].flagInAir;
      _loc1_ = 0;
      while(_loc1_ < flags.length)
      {
         flags[_loc1_]._x = flags[_loc1_].flagsX + flags[_loc1_].imaginaryMove - imaginaryMove;
         flags[_loc1_]._y = flags[_loc1_].origY - 213 + floor._y;
         flags[_loc1_]._alpha = flags[_loc1_].flagOpacity;
         _loc1_ = _loc1_ + 1;
      }
      player._x = flags[onFlag].flagPlayerX;
      player._y = flags[onFlag].flagPlayerY;
      gravity = flags[onFlag].flagPlayerGravity;
      jump = flags[onFlag].flagPlayerJump;
      player._rotation = flags[onFlag].flagPlayerRotation;
      _loc1_ = 0;
      while(_loc1_ < flags[onFlag].flagObjects.length)
      {
         var _loc3_ = flags[onFlag].flagObjects[_loc1_];
         var _loc5_ = flags[onFlag].flagObjects[_loc1_ + 1];
         var _loc4_ = flags[onFlag].flagObjects[_loc1_ + 2];
         var _loc2_ = flags[onFlag].flagObjects[_loc1_ + 3];
         var _loc6_ = flags[onFlag].flagObjects[_loc1_ + 4];
         var _loc7_ = flags[onFlag].flagObjects[_loc1_ + 5];
         if(_loc3_ == 1)
         {
            addBlock(_loc5_,_loc4_,_loc6_,_loc2_,_loc7_);
         }
         else if(_loc3_ == 2)
         {
            addSpike(_loc5_,_loc4_,_loc6_,_loc2_);
         }
         else if(_loc3_ == 3)
         {
            addPit(_loc5_,_loc4_,_loc2_);
         }
         _loc1_ += 6;
      }
   }
   else
   {
      trackSound.start(0,1);
      imaginaryMove = 0;
      startOfList = 0;
      startOfList2 = 0;
      jump = false;
      gravity = 0;
      jumpTime = 0;
      inAir = false;
      player._x = 130;
      player._y = 198;
      player._rotation = 0;
      d = 100;
   }
   player._visible = true;
   exploding = false;
   attempt++;
   attemptText.text = "Attempt " + attempt;
}
function addBlock(x, y, origY, alpha, bool)
{
   var _loc1_ = c.attachMovie("block","block" + d++,d);
   _loc1_._x = x;
   _loc1_._y = y;
   _loc1_._alpha = alpha;
   _loc1_.playerBlock = false;
   _loc1_.origY = origY;
   blocks.push(_loc1_);
}
function addSpike(x, y, origY, alpha)
{
   var _loc1_ = c.attachMovie("spike","spike" + d++,d);
   _loc1_._x = x;
   _loc1_._y = y;
   _loc1_._alpha = alpha;
   _loc1_.origY = origY;
   _loc1_.rect1._visible = false;
   _loc1_.rect2._visible = false;
   spikes.push(_loc1_);
}
function addPit(x, y, alpha)
{
   var _loc1_ = c.attachMovie("pit","pit" + d++,d);
   _loc1_._x = x;
   _loc1_._y = y;
   _loc1_._alpha = alpha;
   _loc1_.rect._visible = false;
   pits.push(_loc1_);
}
function addS(x, y)
{
   y *= -1;
   y += 198;
   objectPos.push(x);
   objectPos.push(y);
   objectPos.push(2);
}
function addB(x, y)
{
   y *= -1;
   y += 198;
   objectPos.push(x);
   objectPos.push(y);
   objectPos.push(1);
}
function addP(x, endX)
{
   var _loc1_ = x;
   while(_loc1_ <= endX)
   {
      pitsPos.push(_loc1_);
      _loc1_ += 30;
   }
}
function particleSpawn(posX, posY)
{
   var _loc4_ = 0;
   while(_loc4_ <= 20)
   {
      var _loc1_ = c2.attachMovie("particle","particle" + d++,d);
      _loc1_._x = posX;
      _loc1_._y = posY;
      _loc1_._rotation = random(360);
      var _loc2_ = random(7) + 10;
      var _loc3_ = (_loc1_._rotation - 90) / 57.29577951308232;
      _loc1_.speedX = _loc2_ * Math.cos(_loc3_);
      _loc1_.speedY = _loc2_ * Math.sin(_loc3_);
      particles.push(_loc1_);
      _loc4_ = _loc4_ + 1;
   }
}
function addFlag(posX, posY, origY)
{
   var _loc1_ = c.attachMovie("flag","flag" + d++,d);
   _loc1_._x = posX;
   _loc1_._y = posY;
   _loc1_.origY = origY;
   _loc1_.imaginaryMove = imaginaryMove;
   _loc1_.startOfList = startOfList;
   _loc1_.startOfList2 = startOfList2;
   _loc1_.flagsX = posX;
   _loc1_.flagsY = posY;
   _loc1_.flagFloorY = floor._y;
   _loc1_.flagInAir = inAir;
   _loc1_.flagPlayerX = player._x;
   _loc1_.flagPlayerY = player._y;
   _loc1_.flagPlayerGravity = gravity;
   _loc1_.flagPlayerJump = jump;
   _loc1_.flagPlayerRotation = player._rotation;
   _loc1_.flagOpacity = 100;
   _loc1_.flagObjects = new Array();
   var _loc2_ = 0;
   while(_loc2_ < blocks.length)
   {
      _loc1_.flagObjects.push(1,blocks[_loc2_]._x,blocks[_loc2_]._y,blocks[_loc2_]._alpha,blocks[_loc2_].origY,blocks[_loc2_].playerBlock);
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ < spikes.length)
   {
      _loc1_.flagObjects.push(2,spikes[_loc2_]._x,spikes[_loc2_]._y,spikes[_loc2_]._alpha,spikes[_loc2_].origY,false);
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ < pits.length)
   {
      _loc1_.flagObjects.push(3,pits[_loc2_]._x,pits[_loc2_]._y,pits[_loc2_]._alpha,pits[_loc2_].origY,false);
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ < flags.length)
   {
      flags[_loc2_].flagOpacity = flags[_loc2_]._alpha;
      _loc2_ = _loc2_ + 1;
   }
   flags.push(_loc1_);
}
function initObjectPos()
{
   addS(1020,0);
   addS(1500,0);
   addS(1530,0);
   addB(2000,0);
   addB(2150,0);
   addP(2030,2120);
   addS(2700,0);
   addS(2730,0);
   addS(3200,0);
   addS(3470,0);
   addS(3500,0);
   addB(3750,0);
   addB(3882,30);
   addB(4014,60);
   addB(4184,30);
   addB(4354,0);
   addP(3780,4320);
   addS(4550,0);
   addS(5000,0);
   addB(5400,0);
   addB(5532,30);
   addB(5607,30);
   addS(5607,60);
   addB(5682,30);
   addB(5853,0);
   addS(6040,0);
   addP(5430,5820);
   addS(6300,0);
   addS(6600,0);
   addS(6800,0);
   addS(7000,0);
   addP(7280,9000);
   addB(7250,0);
   addB(7382,30);
   addB(7514,60);
   addB(7646,90);
   addB(7778,120);
   addB(7808,120);
   addB(7838,120);
   addB(7868,120);
   addB(7898,120);
   addB(7928,120);
   addB(7958,120);
   addB(7988,120);
   addB(8018,120);
   addB(8048,120);
   addB(8078,120);
   addB(8108,120);
   addS(8108,150);
   addB(8210,150);
   addB(8240,150);
   addB(8270,150);
   addB(8300,150);
}
stop();
var jump = false;
var gravity = 0;
var jumpTime = 0;
var touching = false;
var inAir = false;
var objectPos = new Array();
var pitsPos = new Array();
var startOfList = 0;
var startOfList2 = 0;
var imaginaryMove = 0;
var practiceMode = false;
var attempt = 1;
var exploding = false;
var d = 100;
var onFlag = -1;
var finished = false;
var flagsLeft = 10;
var paused = false;
var soundPosition = 0;
var Frelease = true;
var Drelease = true;
var flags = new Array();
var spikes = new Array();
var blocks = new Array();
var pits = new Array();
var particles = new Array();
initObjectPos();
playerRect._visible = false;
playerRectTop._visible = false;
playerRectTop2._visible = false;
practiceHeader._visible = false;
trackSound.attachSound("soundtrack");
trackSound.start(0,1);
var explosionSound = new Sound(this);
explosionSound.attachSound("explosion");
attemptText.text = "Attempt " + attempt;
flag_button.onRelease = function()
{
   flagPress();
};
flagdelete_button.onRelease = function()
{
   flagDelete();
};
