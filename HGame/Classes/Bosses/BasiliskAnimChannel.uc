//================================================================================
// BasiliskAnimChannel.
//================================================================================

class BasiliskAnimChannel extends AnimChannel;

var Basilisk Basil;
var bool bAnimDone;

function _SetOwner (Actor o)
{
  SetOwner(o);
  Basil = Basilisk(o);
}

function AnimEnd()
{
  bAnimDone = True;
  Basil.RealAnimEnd();
}

function PlayHissSound()
{
  Basil.PlayHissSound();
}

