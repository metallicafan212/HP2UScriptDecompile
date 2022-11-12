//================================================================================
// WillowRoot.
//================================================================================

class WillowRoot extends HChar;

var() float fGetAngryDistance;
var() float fAvgSoundPeriod;
var() float WillowSoundRadius;
var int LastAnimFrame;
var int NumWillowRootFrames;
var() int Damage;

function PreBeginPlay()
{
  local GenericColObj A;

  Super.PreBeginPlay();
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone03');
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone05');
  A = Spawn(Class'GenericColObj',self);
  A.AttachToOwner('Bone07');
  SetTimer(RandRange(0.1,0.89999998),True);
}

function ColObjTouch (Actor Other, GenericColObj ColObj)
{
  harry(Other).TakeDamage(Damage,self,ColObj.Location,vect(0.00,0.00,0.00),'None');
}

auto state stateIdle
{
  function Timer()
  {
    SetTimer(RandRange(0.60,0.89999998),True);
    if ( VSize2D(PlayerHarry.Location - Location) < fGetAngryDistance )
    {
      GotoState('stateAngry');
    }
  }
  
 begin:
  LoopAnim('Idle',RandRange(0.40,1.10),1.0);
  AnimFrame = RandRange(0.0,0.69999999);
  do
  {
    Sleep(fAvgSoundPeriod + RandRange( -fAvgSoundPeriod * 0.5,fAvgSoundPeriod * 0.5));
    AnimRate = RandRange(0.40,1.10);
  } 
  until(false);
  //if (! False ) goto JL002D;
}

state stateAngry
{
  function Timer()
  {
    SetTimer(RandRange(0.60,0.89999998),True);
    if ( VSize2D(PlayerHarry.Location - Location) > fGetAngryDistance + 50 )
    {
      GotoState('stateIdle');
    }
  }
  
  function Tick (float dtime)
  {
    local int Frame;
    local Sound snd;
    local bool bPlaySound;
    //local float Scale;
	local float fScale;
  
    Frame = AnimFrame * NumWillowRootFrames;
	if ( (Frame >= 23) && (LastAnimFrame < 23) || (Frame >= 68) && (LastAnimFrame < 68) || (Frame >= 124) && (LastAnimFrame < 124) || (Frame >= 165) && (LastAnimFrame < 165) )
    {
      bPlaySound = True;
    }
    if ( bPlaySound )
    {
      switch (Rand(6))
      {
        case 0:
        snd = Sound'whomp01';
        break;
        case 1:
        snd = Sound'whomp02';
        break;
        case 2:
        snd = Sound'whomp03';
        break;
        case 3:
        snd = Sound'whomp04';
        break;
        case 4:
        snd = Sound'whomp05';
        break;
        case 5:
        snd = Sound'whomp06';
        break;
        default:
      }
    }
    if ( snd != None )
    {
      PlaySound(snd,SLOT_None,RandRange(0.69999999,1.0),False,WillowSoundRadius,RandRange(0.80,1.20));
    }
    if ( (Frame >= 28) && (LastAnimFrame < 28) || (Frame >= 73) && (LastAnimFrame < 73) || (Frame >= 127) && (LastAnimFrame < 127) || (Frame >= 169) && (LastAnimFrame < 169) )
    {
      snd = Sound'Big_whomp2';
      fScale = -2.0 / fGetAngryDistance * VSize2D(PlayerHarry.Location - Location) + 2.5;
      fScale = Clamp(fScale, 0,1);
      PlaySound(snd,SLOT_None,RandRange(0.4,1.0),False,WillowSoundRadius,RandRange(0.2,0.89999998));
      PlayerHarry.ShakeView(0.5,50.0 * fScale,50.0 * fScale);
    }
    LastAnimFrame = Frame;
  }
  
 begin:
  LastAnimFrame = 0;
  LoopAnim('Attack',RandRange(0.1,0.3),1.0);
  do
  {
    Sleep(fAvgSoundPeriod + RandRange( -fAvgSoundPeriod * 0.5,fAvgSoundPeriod * 0.5));
    AnimRate = RandRange(0.1,0.3);
  }
  until(false);
  //if (! False ) goto JL0021;
}

defaultproperties
{
    fGetAngryDistance=300.00

    fAvgSoundPeriod=2.00

    WillowSoundRadius=400.00

    NumWillowRootFrames=191

    Damage=5

    ShadowScale=0.33

    Mesh=SkeletalMesh'HPModels.skWillowRootMesh'

}
