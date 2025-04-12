function onEnterFrame()
{
   var _loc2_ = _root.getBytesLoaded() / _root.getBytesTotal() * 100;
   if(_loc2_ != 100)
   {
      bar._xscale = Math.round(_loc2_);
   }
   else
   {
      bar._xscale = 100;
      play();
      delete onEnterFrame;
   }
}
stop();
Stage.showMenu = false;
var trackSound = new Sound(this);
