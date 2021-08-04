//================================================================================
// Snitch.
//================================================================================

class Snitch extends QuidditchPawn;

const FlashPeriod= 0.05;
const JerkSpeed= 400;
const NUM_POSITION_HISTORY= 4;
var BroomHoopTrail HoopTrail;
var(Quidditch) bool bHasHoopTrail;
var(Quidditch) float fHoopSpacing;
var(Quidditch) int HoopTrailLen;
var(Quidditch) int InitialHoopTrailEnd;
var(Quidditch) bool bHoopsVisible;
var(Quidditch) bool bTrackProgress;
var float fApparentScale;
var float fNormalScale;
var float fNormalHaloScale;
var bool bJerking;
var float fTimeForNextJerk;
var Vector DestJerkOffset;
var Vector JerkOffset;
var Vector NormalHaloPrePivot;
var Vector NormalTrailPrePivot;
var bool bFlashing;
var float fTimeForNextFlash;
var bool bAltTrailScheme;
var Color TrailOrgColorStartBase;
var Color TrailOrgColorEndBase;
var(Quidditch) Color TrailAltColorStartBase;
var(Quidditch) Color TrailAltColorEndBase;
var Vector vPositionHistory[4];
var int iNextHistorySlot;
var float HistoryTimer;
var HPawn CatchProxy;

function PostBeginPlay()
{
  if ( Mesh == None )
  {
    Mesh = SkeletalMesh'skSnitchMesh';
  }
  if ( ParticleTrail == None )
  {
    ParticleTrail = Class'Snitch_FX';
  }
  bHasHoopTrail = True;
  fHoopSpacing = 1.5;
  HoopTrailLen = 2;
  InitialHoopTrailEnd = 0;
  bHoopsVisible = True;
  bJerking = False;
  DestJerkOffset = PrePivot;
  JerkOffset = PrePivot;
  bFlashing = False;
  bAltTrailScheme = False;
  Super.PostBeginPlay();
  if ( bHasHoopTrail )
  {
    HoopTrail = Spawn(Class'BroomHoopTrail',,'HoopTrail',);
    HoopTrail.Emitter = self;
    HoopTrail.SetTrailProperties(fHoopSpacing,HoopTrailLen,InitialHoopTrailEnd,bHoopsVisible,bTrackProgress);
    HoopTrail.GotoState('TrailOn');
  } else {
    HoopTrail = None;
  }
  LoopAnim('flap');
  if ( Halo != None )
  {
    NormalHaloPrePivot = Halo.PrePivot;
    Halo.bTrailerPrePivot = True;
  }
  if ( Trail != None )
  {
    TrailOrgColorStartBase = Trail.ColorStart.Base;
    TrailOrgColorEndBase = Trail.ColorEnd.Base;
    NormalTrailPrePivot = Trail.PrePivot;
    Trail.bTrailerPrePivot = True;
  }
  fApparentScale = 1.0;
  fNormalScale = DrawScale;
  if ( Halo != None )
  {
    fNormalHaloScale = Halo.DrawScale;
  } else {
    fNormalHaloScale = 1.0;
  }
  CatchProxy = None;
}

function Hide()
{
  Super.Hide();
  if ( HoopTrail != None )
  {
    HoopTrail.GotoState('TrailOff');
  }
}

function Show()
{
  Super.Show();
  if ( HoopTrail != None )
  {
    HoopTrail.GotoState('TrailOn');
  }
}

function SetApparentScale (float fNewScale)
{
  fApparentScale = fNewScale;
  DrawScale = fNormalScale * fApparentScale;
  if ( Halo != None )
  {
    Halo.DrawScale = fNormalHaloScale * fApparentScale;
  }
}

function SetJerking (bool bOn)
{
  if ( bJerking != bOn )
  {
    if ( bOn )
    {
      fTimeForNextJerk = Level.TimeSeconds;
    } else {
      DestJerkOffset = vect(0.00,0.00,0.00);
      JerkOffset = vect(0.00,0.00,0.00);
      PrePivot = vect(0.00,0.00,0.00);
      if ( Halo != None )
      {
        Halo.PrePivot = NormalHaloPrePivot;
      }
      if ( Trail != None )
      {
        Trail.PrePivot = NormalTrailPrePivot;
      }
    }
    bJerking = bOn;
  }
}

function SetFlashing (bool bOn)
{
  if ( bFlashing != bOn )
  {
    if ( bOn )
    {
      fTimeForNextFlash = Level.TimeSeconds;
    } else {
      if ( Halo != None )
      {
        Halo.bHidden = False;
      }
    }
    bFlashing = bOn;
  }
}

function SetAltTrail (bool bOn)
{
  if ( (Trail != None) && (bAltTrailScheme != bOn) )
  {
    if ( bOn )
    {
      Trail.ColorStart.Base = TrailAltColorStartBase;
      Trail.ColorEnd.Base = TrailAltColorEndBase;
    } else {
      Trail.ColorStart.Base = TrailOrgColorStartBase;
      Trail.ColorEnd.Base = TrailOrgColorEndBase;
    }
    bAltTrailScheme = bOn;
  }
}

function ClearAllEffects()
{
  SetJerking(False);
  SetApparentScale(1.0);
  SetFlashing(False);
  SetAltTrail(False);
  if ( Halo != None )
  {
    Halo.bHidden = True;
  }
  if ( HoopTrail != None )
  {
    HoopTrail.GotoState('TrailOff');
  }
}

function ResetAllEffects()
{
  if ( Halo != None )
  {
    Halo.bHidden = False;
  }
  if ( HoopTrail != None )
  {
    HoopTrail.GotoState('TrailOn');
  }
}

function HPawn CreateCatchProxy()
{
  if ( CatchProxy != None )
  {
    Log(string(Name) $ ": Already create a catch proxy");
  } else {
    CatchProxy = Spawn(Class'HPawn',None,,vect(5744.00,8224.00,4832.00),rot(0,0,0));
    if ( CatchProxy == None )
    {
      Log(string(Name) $ ": Couldn't create a catch proxy");
    }
    // CatchProxy.DrawType = 2;
	CatchProxy.DrawType = DT_Mesh;
    CatchProxy.Mesh = SkeletalMesh'skSnitchMesh';
    CatchProxy.DrawScale = 1.0;
    CatchProxy.bAlignBottom = False;
    CatchProxy.bHidden = False;
    CatchProxy.bCollideWorld = False;
    CatchProxy.SetCollision(False,False,False);
    CatchProxy.LoopAnim('flap');
  }
  Trail.SetOwner(CatchProxy);
  ClearAllEffects();
  bHidden = True;
  return CatchProxy;
}

function DisposeCatchProxy()
{
  Trail.SetOwner(self);
  ResetAllEffects();
  bHidden = False;
  if ( CatchProxy == None )
  {
    Log(string(Name) $ ": No catch proxy to dispose");
  } else {
    CatchProxy.Destroy();
    CatchProxy = None;
  }
}

function FlyOnPath (name Path, optional int StartPoint)
{
  SetJerking(True);
  Super.FlyOnPath(Path,StartPoint);
}

function StopFlyingOnPath()
{
  SetJerking(False);
  Super.StopFlyingOnPath();
}

event Tick (float DeltaTime)
{
  local Vector Dir;
  local Vector RelJerkOffset;
  //local float Dist;

  if ( bJerking && (Level.TimeSeconds > fTimeForNextJerk) )
  {
    DestJerkOffset.X = RandRange(-40.0,40.0);
    DestJerkOffset.Y = RandRange(-40.0,40.0);
    DestJerkOffset.Z = RandRange(-40.0,40.0);
    fTimeForNextJerk = Level.TimeSeconds + RandRange(0.41,1.25);
  }
  if ( bJerking )
  {
    Dir = DestJerkOffset - JerkOffset;
    Dist = VSize(Dir);
    if ( Dist > 0.0 )
    {
      if ( Dist > 0.01 )
      {
        JerkOffset += Normal(Dir) * Min(Dist,JerkSpeed * DeltaTime);
      }
	  //UTPT added this in the if statement above, the snitch used to be too snappy/unnatural looking -AdamJD
	  else
	  {
		JerkOffset = DestJerkOffset;
	  }
      if ( Halo != None )
      {
        Halo.PrePivot = NormalHaloPrePivot + JerkOffset;
      }
    }
    RelJerkOffset = JerkOffset << Rotation;
    PrePivot = RelJerkOffset;
    if ( Trail != None )
    {
      Trail.PrePivot = RelJerkOffset;
    }
  }
  if ( bFlashing && (Level.TimeSeconds > fTimeForNextFlash) )
  {
    if ( Halo != None )
    {
      Halo.bHidden =  !Halo.bHidden;
    }
    fTimeForNextFlash += 0.05;
    if ( fTimeForNextFlash < Level.TimeSeconds )
    {
      fTimeForNextFlash = Level.TimeSeconds;
    }
  }
  HistoryTimer += DeltaTime;
  if ( HistoryTimer > 0.151 )
  {
    HistoryTimer = 0.0;
    vPositionHistory[iNextHistorySlot] = Location;
    iNextHistorySlot++;
    if ( iNextHistorySlot >= 4 )
    {
      iNextHistorySlot = 0;
    }
  }
}

function Vector GetTargetVector (Vector vActor, float BestDistance)
{
  local float cd;
  local float D;
  local Vector V;
  local int I;

  cd = 999999.0;

  for(I = 0; I < NUM_POSITION_HISTORY; I++)
  {
    D = Abs(VSize(vPositionHistory[I] - vActor) - BestDistance);
    if ( D < cd )
    {
      cd = D;
      V = vPositionHistory[I];
    }
  }
  return V;
}

defaultproperties
{
    bHasHoopTrail=True

    fHoopSpacing=1.50

    HoopTrailLen=2

    bHoopsVisible=True

    TrailAltColorStartBase=(R=255,G=0,B=0,A=0)

    TrailAltColorEndBase=(R=255,G=0,B=0,A=0)

    Path=IPSnitch

    fSpeedChangeFirstTime=240.00

    MaxSpeedChanges=3

    ParticleTrail=Class'HPParticle.Snitch_FX'

    HaloClass=Class'HPParticle.Snitch_Halo'

    bCanWoosh=False

    FlyingSound=Sound'HPSounds.Quidditch_sfx.Q_snitch_loop'

    IPSpeed=800.00

    Mesh=SkeletalMesh'HPModels.skSnitchMesh'

    CollisionRadius=50.00

    CollisionHeight=50.00
}
