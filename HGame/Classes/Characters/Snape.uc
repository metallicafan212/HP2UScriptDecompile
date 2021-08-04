//================================================================================
// Snape.
//================================================================================

class Snape extends Characters;

var float fWaitTime;
var float fCurrTime;
var float fDuration;
var int iPointsToDeduct;

function AdjustHousePoints (int Points)
{
  local StatusGroup sgHousePoints;
  local int Count;

  if ( Points == 0 )
  {
    return;
  }
  Count = HousePointsCount();
  if ( Count + Points < 0 )
  {
    Points =  -Count;
  }
  sgHousePoints = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupHousePoints');
  sgHousePoints.IncrementCount(Class'StatusItemGryffindorPts',Points);
}

function int HousePointsCount()
{
  local StatusGroup sgHousePoints;
  local int Count;

  sgHousePoints = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupHousePoints');
  Count = sgHousePoints.GetStatusItem(Class'StatusItemGryffindorPts').nCount;
  return Count;
}

function float PlaySnapeSoundText()
{
  local float duration;

  switch (Rand(6))
  {
    case 0:
    duration = DeliverLocalizedDialog("PC_Snp_SnpDeductHP_03",True,0.0);
    iPointsToDeduct = 0;
    break;
    case 1:
    duration = DeliverLocalizedDialog("PC_Snp_SnpDeductHP_04",True,0.0);
    iPointsToDeduct = 5;
    break;
    case 2:
    duration = DeliverLocalizedDialog("PC_Snp_SnpDeductHP_05",True,0.0);
    iPointsToDeduct = 10;
    break;
    case 3:
    duration = DeliverLocalizedDialog("PC_Snp_SnpDeductHP_06",True,0.0);
    iPointsToDeduct = 15;
    break;
    case 4:
    duration = DeliverLocalizedDialog("PC_Snp_SnpDeductHP_07",True,0.0);
    iPointsToDeduct = 20;
    break;
    case 5:
    duration = DeliverLocalizedDialog("PC_Snp_SnpDeductHP_08",True,0.0);
    iPointsToDeduct = 0;
    break;
    default:
    duration = 0.0;
    iPointsToDeduct = 0;
    break;
  }
  return duration;
}

function PreBeginPlay()
{
  Super.PreBeginPlay();
}

function Tick (float DeltaTime)
{
  Super.Tick(DeltaTime);
  if ( GetStateName() != 'patrol' )
  {
    return;
  }
  if ( PlayerHarry.CutNotifyActor != None )
  {
    return;
  }
  if ( HousePointsCount() <= 0 )
  {
    return;
  }
  fCurrTime += DeltaTime;
  if ( fCurrTime < fWaitTime )
  {
    return;
  }
  fCurrTime = 0.0;
  fWaitTime = 1.0;
  if ( VSize(Location - PlayerHarry.Location) < SightRadius )
  {
    if ( LineOfSightTo(PlayerHarry) )
    {
      vLastLocation = Location;
      GotoState('stateGotoHarry');
    }
  }
}

function Bump (Actor Other)
{
  if ( Other != PlayerHarry )
  {
    return;
  }
  if ( GetStateName() != 'stateGotoHarry' )
  {
    return;
  }
  GotoState('stateSaySomething');
}

state stateSaySomething
{
begin:
  fWaitTime = 10.0;
  if ( PlayerHarry.CutNotifyActor == None )
  {
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
    TurnTo(PlayerHarry.Location);
    PlayerHarry.CutCommand("Capture","");
    PlayerHarry.CutNotifyActor = self;
    fDuration = PlaySnapeSoundText();
    switch (Rand(3))
    {
      case 0:
      LoopAnim('talk_rhand');
      break;
      case 1:
      LoopAnim('talk_lhand');
      break;
      case 2:
      LoopAnim('talk_bothhands');
      break;
      default:
    }
    Sleep(fDuration - 1);
    FinishAnim();
    LoopAnim('Idle');
    Sleep(1.0);
    FinishAnim();
    PlayerHarry.CutCommand("Release","");
    PlayerHarry.CutNotifyActor = None;
    AdjustHousePoints( -iPointsToDeduct);
  }
  GotoState('patrol');
}

state stateGotoHarry
{
begin:
  LoopAnim('Walk');
  MoveTo(PlayerHarry.Location);
  FinishAnim();
  GotoState('patrol');
}

defaultproperties
{
    fWaitTime=1.00

    bLoopPath=True

    SightRadius=150.00

    IdleAnimName=Walk

    RunAnimName=Walk

    Mesh=SkeletalMesh'HPModels.skProfSnapeMesh'

    AmbientGlow=65

    CollisionRadius=20.00

    CollisionHeight=48.00

}
