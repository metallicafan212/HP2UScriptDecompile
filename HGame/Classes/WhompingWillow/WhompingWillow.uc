//================================================================================
// WhompingWillow.
//================================================================================

class WhompingWillow extends HChar;

struct cRootTiming
{
  var() float step1_UpAnimRate;
  var() float step2_UpTime;
  var() float step3_DownAnimRate;
  var() float step4_OnGroundTime;
};

var() cRootTiming Root1Timing[10];
var() cRootTiming Root2Timing[10];
var() cRootTiming Root3Timing[10];
var() int Damage1;
var() int Damage2;
var() int Damage3;


function PostBeginPlay ()
{
  local WhompWRController Root;

  Root = WhompWRController(CreateAnimChannel(Class'WhompWRController',AT_Replace,'Root1'));
  Root.SetOwner(self);
  Root.WhichRoot = 1;
  Root.RootAnimNameUp = 'Root1UP';
  Root.RootAnimNameLoop = 'Root1Loop';
  Root.RootAnimNameDown = 'Root1Down';
  Root.ColObj[0] = FindColObj('BlockPlayerRoot1_1');
  Root.ColObj[1] = FindColObj('BlockPlayerRoot1_2');
  Root.ColObj[2] = FindColObj('BlockPlayerRoot1_3');
  Root.Damage = Damage1;
  Root.Tag = 'Root1Tag';
  Root = WhompWRController(CreateAnimChannel(Class'WhompWRController',AT_Replace,'Root2'));
  Root.SetOwner(self);
  Root.WhichRoot = 2;
  Root.RootAnimNameUp = 'Root2UP';
  Root.RootAnimNameLoop = 'Root2Loop';
  Root.RootAnimNameDown = 'Root2Down';
  Root.ColObj[0] = FindColObj('BlockPlayerRoot2_1');
  Root.ColObj[1] = FindColObj('BlockPlayerRoot2_2');
  Root.ColObj[2] = FindColObj('BlockPlayerRoot2_3');
  Root.Damage = Damage2;
  Root.Tag = 'Root2Tag';
  Root = WhompWRController(CreateAnimChannel(Class'WhompWRController',AT_Replace,'Root3'));
  Root.SetOwner(self);
  Root.WhichRoot = 3;
  Root.RootAnimNameUp = 'Root3UP';
  Root.RootAnimNameLoop = 'Root3Loop';
  Root.RootAnimNameDown = 'Root3Down';
  Root.ColObj[0] = FindColObj('BlockPlayerRoot3_1');
  Root.ColObj[1] = FindColObj('BlockPlayerRoot3_2');
  Root.ColObj[2] = FindColObj('BlockPlayerRoot3_3');
  Root.Damage = Damage3;
  Root.Tag = 'Root3Tag';
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  local WhompWRController A;

  foreach AllActors(Class'WhompWRController',A)
  {
    A.bGoDisabled = True;
  }
}

function GenericColObj FindColObj (name Tag)
{
  local GenericColObj A;

  foreach AllActors(Class'GenericColObj',A,Tag)
  {
    return A;
  }
  return None;
}

function float GetUpAnimRate (int WhichRoot, int TimingStage)
{
  switch (WhichRoot)
  {
    case 1:
    return Root1Timing[TimingStage].step1_UpAnimRate;
    case 2:
    return Root2Timing[TimingStage].step1_UpAnimRate;
    case 3:
    return Root3Timing[TimingStage].step1_UpAnimRate;
    default:
  }
  return 0.0;
}

function float GetUpTime (int WhichRoot, int TimingStage)
{
  switch (WhichRoot)
  {
    case 1:
    return Root1Timing[TimingStage].step2_UpTime;
    case 2:
    return Root2Timing[TimingStage].step2_UpTime;
    case 3:
    return Root3Timing[TimingStage].step2_UpTime;
    default:
  }
  return 0.0;
}

function float GetDownAnimRate (int WhichRoot, int TimingStage)
{
  switch (WhichRoot)
  {
    case 1:
    return Root1Timing[TimingStage].step3_DownAnimRate;
    case 2:
    return Root2Timing[TimingStage].step3_DownAnimRate;
    case 3:
    return Root3Timing[TimingStage].step3_DownAnimRate;
    default:
  }
  return 0.0;
}

function float GetOnGroundTime (int WhichRoot, int TimingStage)
{
  switch (WhichRoot)
  {
    case 1:
    return Root1Timing[TimingStage].step4_OnGroundTime;
    case 2:
    return Root2Timing[TimingStage].step4_OnGroundTime;
    case 3:
    return Root3Timing[TimingStage].step4_OnGroundTime;
    default:
  }
  return 0.0;
}

defaultproperties
{
    Root1Timing(0)=(step1_UpAnimRate=1.00,step2_UpTime=0.00,step3_DownAnimRate=1.00,step4_OnGroundTime=0.25)

    Root1Timing(1)=(step1_UpAnimRate=1.00,step2_UpTime=0.00,step3_DownAnimRate=2.00,step4_OnGroundTime=2.00)

    Root2Timing(0)=(step1_UpAnimRate=1.50,step2_UpTime=0.00,step3_DownAnimRate=2.00,step4_OnGroundTime=0.25)

    Root2Timing(1)=(step1_UpAnimRate=1.00,step2_UpTime=0.00,step3_DownAnimRate=1.00,step4_OnGroundTime=2.00)

    Root3Timing(0)=(step1_UpAnimRate=1.00,step2_UpTime=0.25,step3_DownAnimRate=1.00,step4_OnGroundTime=0.25)

    Root3Timing(1)=(step1_UpAnimRate=1.00,step2_UpTime=0.00,step3_DownAnimRate=1.00,step4_OnGroundTime=0.00)

    Root3Timing(2)=(step1_UpAnimRate=3.00,step2_UpTime=0.00,step3_DownAnimRate=2.00,step4_OnGroundTime=0.00)

    Root3Timing(3)=(step1_UpAnimRate=3.00,step2_UpTime=0.00,step3_DownAnimRate=2.00,step4_OnGroundTime=0.00)

    Root3Timing(4)=(step1_UpAnimRate=3.00,step2_UpTime=0.00,step3_DownAnimRate=2.00,step4_OnGroundTime=1.00)

    Damage1=13

    Damage2=13

    Damage3=13

    Mesh=SkeletalMesh'HPModels.skWhompingWIllowMesh'

    DrawScale=10.00

}
