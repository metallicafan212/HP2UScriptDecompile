//================================================================================
// BroomHoopTrail.
//================================================================================

class BroomHoopTrail extends Actor;

const MaxHoops= 5;
var harry PlayerHarry;
var Director Director;
var Actor Emitter;
var BroomHoop Hoops[5];
var float fHoopSpacing;
var int TrailLen;
var int InitialTrailEnd;
var bool bHoopsVisible;
var bool bTrackProgress;
var int HoopsToHit;
var int NextHoopToUse;
var int ValidHoops;
var float fBirthTimeOfNewestHoop;
var int TrailEnd;
var int NextHoopToHit;
var int CurrentStage;
var bool bSpeedBoostSuggested;
var int HoopsToGo;
var Sound HoopSounds[16];

function PostBeginPlay()
{
  local int I;
  local Vector Position;

  Super.PostBeginPlay();

  foreach AllActors(Class'harry',PlayerHarry)
  {
	break;
  }
  foreach AllActors(Class'Director',Director)
  {
	break;
  }
  CurrentStage = 1;

  for(I = 0; I < 5; ++I)
  {
    Position.X = (I + 1) * 20;
    Position.Y = 0.0;
    Position.Z = -100.0;
    Hoops[I] = Spawn(Class'BroomHoop',None,'Hoop',Position,rot(0,0,0));
    Hoops[I].HoopNumber = I;
    Hoops[I].Stage = 0;
  }
  InitialState = 'TrailOff';
}

function SetTrailProperties (float fNewHoopSpacing, int NewTrailLen, int NewInitialTrailEnd, bool bNewHoopsVisible, bool bNewTrackProgress)
{
  fHoopSpacing = fNewHoopSpacing;
  TrailLen = NewTrailLen;
  InitialTrailEnd = NewInitialTrailEnd;
  bHoopsVisible = bNewHoopsVisible;
  bTrackProgress = bNewTrackProgress;
}

function SetHoopsToHit (int NewHoopsToHit)
{
  HoopsToHit = NewHoopsToHit;
}

function ChangeHoopAppearance (BroomHoop Hoop, int ParticleStage)
{
  switch (ParticleStage)
  {
    case 1:
    Hoop.attachedParticleClass[0] = Class'Ring1';
    break;
    case 2:
    Hoop.attachedParticleClass[0] = Class'Ring2';
    break;
    case 3:
    Hoop.attachedParticleClass[0] = Class'Ring3';
    break;
    case 4:
    Hoop.attachedParticleClass[0] = Class'Ring4';
    break;
    case 5:
    Hoop.attachedParticleClass[0] = Class'Ring5';
    break;
    default:
  }
  if ( bHoopsVisible )
  {
    Hoop.changeAttachedParticleFX(Hoop.attachedParticleClass[0]);
  }
}

function SetTrailEnd (int NewTrailEnd)
{
  local BroomHoop Hoop;
  local int HoopsToDo;
  local int I;

  I = NewTrailEnd;

  for(HoopsToDo = MaxHoops - TrailLen; HoopsToDo > 0; --HoopsToDo)
  {
    --I;
    if ( I < 0 )
    {
      I += MaxHoops;
    }
    Hoop = Hoops[I];
    if (  !Hoop.IsInState('HoopInvisible') || Hoop.IsInState('HoopDisappearing') )
    {
      Hoop.GotoState('HoopDisappearing');
    }
  }
  I = NewTrailEnd;

  for(HoopsToDo = TrailLen; (HoopsToDo > 0) && (I != NextHoopToUse); --HoopsToDo)
  {
    Hoop = Hoops[I];
    if ( (I < ValidHoops) && (Hoop.IsInState('HoopInvisible') || Hoop.IsInState('HoopDisappearing')) )
    {
      if ( Hoop.Stage != CurrentStage )
      {
        Hoop.Stage = CurrentStage;
        ChangeHoopAppearance(Hoop,CurrentStage);
      }
      Hoop.GotoState('HoopNextToHit');
    }
    ++I;
    if ( I >= 5 )
    {
      I = 0;
    }
  }
}

function UpdateStage()
{
  local int NewStage;

  NewStage = 5 - (4 * HoopsToGo / HoopsToHit);
  if ( CurrentStage != NewStage )
  {
    CurrentStage = NewStage;
  }
}

function OnHoopTouch (BroomHoop Hoop)
{
}

state TrailOff
{
  function BeginState()
  {
    local int I;
  
	for(I = 0; I < MaxHoops; ++I)
    {
      Hoops[I].GotoState('HoopInvisible');
    }
  }
  
}

state TrailOn
{
  function BeginState()
  {
    NextHoopToUse = 0;
    ValidHoops = 0;
    TrailEnd = NextHoopToUse - InitialTrailEnd;
    if ( TrailEnd < 0 )
    {
      TrailEnd += 5;
    }
    SetTrailEnd(TrailEnd);
    HoopsToGo = HoopsToHit;
    NextHoopToHit = -1;
    SetTimer(fHoopSpacing,True);
  }
  
  function Timer()
  {
    local BroomHoop Hoop;
    local int HoopToShow;
    local int EndSetBack;
    local int OldHoopsToGo;
  
    Hoop = Hoops[NextHoopToUse];
    Hoop.GotoState('HoopInvisible');
    if ( Emitter != None )
    {
      Hoop.SetLocation(Emitter.Location);
      Hoop.SetRotation(Emitter.Rotation);
    }
    ++ValidHoops;
    fBirthTimeOfNewestHoop = Level.TimeSeconds;
    ++NextHoopToUse;
    if ( NextHoopToUse >= 5 )
    {
      NextHoopToUse = 0;
    }
    OldHoopsToGo = HoopsToGo;
    EndSetBack = NextHoopToUse - 1 - TrailEnd;
    if ( EndSetBack < 0 )
    {
      EndSetBack += 5;
    }
    if ( EndSetBack > InitialTrailEnd )
    {
      TrailEnd = NextHoopToUse - 1 - InitialTrailEnd;
      if ( TrailEnd < 0 )
      {
        TrailEnd += 5;
      }
      NextHoopToHit = TrailEnd;
      SetTrailEnd(TrailEnd);
      HoopsToGo += EndSetBack - InitialTrailEnd;
      if ( HoopsToGo >= HoopsToHit )
      {
        NextHoopToHit = -1;
        HoopsToGo = HoopsToHit;
      }
      if ( bTrackProgress )
      {
        bSpeedBoostSuggested = False;
        UpdateStage();
      }
    } else //{
      if ( EndSetBack < TrailLen )
      {
        SetTrailEnd(TrailEnd);
      }
    //}
    if ( bTrackProgress && (HoopsToGo != OldHoopsToGo) )
    {
      Director.Trigger(self,None);
    }
  }
  
  function OnHoopTouch (BroomHoop Hoop)
  {
    local int NewStage;
    local int HoopsSkipped;
    local int OldHoopsToGo;
    local int VisibleLen;
    local int HoopSound;
  
    if (  !Hoop.IsInState('HoopInvisible') || Hoop.IsInState('HoopDisappearing') )
    {
      OldHoopsToGo = HoopsToGo;
      --HoopsToGo;
      if ( Hoop.HoopNumber == NextHoopToHit )
      {
        if ( HoopsToGo < 0 )
        {
          HoopsToGo = 0;
        }
      } else {
        if ( NextHoopToHit != -1 )
        {
          HoopsSkipped = Hoop.HoopNumber - NextHoopToHit;
          if ( HoopsSkipped < 0 )
          {
            HoopsSkipped += 5;
          }
          HoopsToGo += HoopsSkipped;
          if ( HoopsToGo >= HoopsToHit )
          {
            HoopsToGo = HoopsToHit - 1;
          }
        }
      }
      NextHoopToHit = Hoop.HoopNumber + 1;
      if ( NextHoopToHit >= 5 )
      {
        NextHoopToHit = 0;
      }
      TrailEnd = NextHoopToHit;
      VisibleLen = NextHoopToUse - TrailEnd;
      if ( VisibleLen < 0 )
      {
        VisibleLen += 5;
      }
      if ( HoopsToGo < VisibleLen )
      {
        HoopsToGo = VisibleLen;
        bSpeedBoostSuggested = True;
      } else {
        bSpeedBoostSuggested = False;
      }
      HoopSound = 15 - HoopsToGo;
      if ( HoopSound < 1 )
      {
        HoopSound = 1;
      }
      Hoop.PlaySound(HoopSounds[HoopSound]);
      UpdateStage();
      SetTrailEnd(TrailEnd);
      if ( HoopsToGo != OldHoopsToGo )
      {
        if ( HoopsToGo == 0 )
        {
          PlayerHarry.ClientMessage("Hit all the hoops!");
        }
        Director.Trigger(self,None);
      }
    }
  }
  
  function EndState()
  {
    SetTimer(0.0,False);
    bSpeedBoostSuggested = False;
    if ( bTrackProgress && (HoopsToGo != 0) && (HoopsToGo != HoopsToHit) )
    {
      HoopsToGo = HoopsToHit;
      Director.Trigger(self,None);
    }
  }
  
}

defaultproperties
{
    fHoopSpacing=1.00

    TrailLen=3

    InitialTrailEnd=3

    HoopsToHit=10

    bHidden=True
}
