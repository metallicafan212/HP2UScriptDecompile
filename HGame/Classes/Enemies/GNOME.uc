//================================================================================
// GNOME.
//================================================================================

class GNOME extends HChar;

const BOOL_DEBUG_AI= false;
enum EObject {
  OBJECT_BEAN,
  OBJECT_MUSHROOM,
  OBJECT_TOTAL
};

var Vector vHome;
var Vector tempHome;
var PatrolPoint pP;
var Vector pPLoc;
var Vector vNewLoc;
var Vector vTargetDir;
var Vector tempTargetDir;
var Vector vTargetLocation;
var Actor aTargetGoody;
var int iBeans;
var int Lives;
var int LastAnimFrame;
var bool bPlayThrowAnim;
var bool bHome;
var bool bJustCreated;
var float HitByFlipendoTime;
var float SoundDuration;
var float SoundPlayTime;
var bool bCurrentSoundOver;
var float savedCollisionRadius;
var float savedCollisionHeight;
var() bool bHasHome;
var() int HarryBeans;
var() int HarryPotions;
var() int MaxGoodies;
var float hunger;

function PlayerCutCapture ()
{
  Velocity = vect(0.00,0.00,0.00);
  Acceleration = vect(0.00,0.00,0.00);
  LoopAnim('tauntass',1.0,2.0);
  GotoState('stateJustStandThere');
}

function PlayerCutRelease ()
{
  GotoState('stateIdle');
}

function bool VeryCloseToPatrolPoint ()
{
  if ( VSize2D(Location - pPLoc) < 10.0 )
  {
    return True;
  }
  return False;
}

function bool MyLineOfSightTo (Actor End)
{
  local Vector HitLocation;
  local Vector HitNormal;
  local Actor HitActor;

  foreach TraceActors(Class'Actor',HitActor,HitLocation,HitNormal,End.Location,Location)
  {
    if ( HitActor == End )
    {
      return True;
    }
    if ( HitActor == self )
    {
      continue;
    } //else {
      if ( HitActor == Level )
      {
        return False;
      }
      if ( HitActor.bBlockActors )
      {
        return False;
      }
    //}
  }
  return False;
}

function bool FindClosestPP ()
{
  local PatrolPoint ClosestPP;
  local PatrolPoint CurPP;
  local float fClosestDist;
  local float fDist;

  ClosestPP = None;
  fClosestDist = 999999.0;
  foreach AllActors(Class'PatrolPoint',CurPP)
  {
    if ( LineOfSightTo(CurPP) )
    {
      fDist = VSize(CurPP.Location - Location);
      if ( fDist < fClosestDist )
      {
        ClosestPP = CurPP;
        fClosestDist = fDist;
      }
    }
  }
  if ( ClosestPP != None )
  {
    pP = ClosestPP;
    pPLoc = ClosestPP.Location;
    return True;
  }
  pP = None;
  pPLoc = Location;
  return False;
}

function Class<Actor> FindClassType (EObject otype)
{
  local Class<Actor> classtype;

  switch (otype)
  {
    // case 0:
	case OBJECT_BEAN:
		classtype = Class'Jellybean';
		break;
    // case 1:
	case OBJECT_MUSHROOM:
		classtype = Class'Horklumps';
		break;
    default:
  }
  return classtype;
}

function Class<Actor> FindPotionClassType ()
{
  local Class<Actor> pclasstype;

  pclasstype = Class'WWellBlueBottle';
  return pclasstype;
}

function Actor FindClosestObject (EObject otype)
{
  local Class<Actor> classtype;
  local Actor ClosestActor;
  local Actor CurrActor;
  local float fClosestDist;
  local float fDist;

  classtype = FindClassType(otype);
  ClosestActor = None;
  fClosestDist = 999999.0;
  foreach AllActors(classtype,CurrActor)
  {
    fDist = VSize(CurrActor.Location - Location);
    if ( (fDist < SightRadius) && (fDist < fClosestDist) )
    {
      if ( MyLineOfSightTo(CurrActor) )
      {
        if ( CurrActor.Owner == None )
        {
          ClosestActor = CurrActor;
          fClosestDist = fDist;
        }
      }
    }
  }
  if ( ClosestActor != None )
  {
    return ClosestActor;
  }
  return None;
}

function bool HasTooManyGoodies ()
{
  if ( iBeans >= MaxGoodies )
  {
    return True;
  }
  return False;
}

function Actor FindClosestMushroom ()
{
  local Actor M;

  // M = FindClosestObject(1);
  M = FindClosestObject(OBJECT_MUSHROOM);
  return M;
}

function Actor FindClosestGoody ()
{
  local float fDistJB;
  local float fDistWW;
  local Actor jb;
  local Actor ww;
  local Actor M;

  M = FindClosestMushroom();
  if ( (M != None) && (aHolding == None) )
  {
    aTargetGoody = M;
    return aTargetGoody;
  }
  jb = FindClosestObject(/*0*/OBJECT_BEAN);
  ww = None;
  if ( (jb == None) && (ww == None) )
  {
    aTargetGoody = None;
  } else //{
    if ( ww == None )
    {
      aTargetGoody = jb;
    }
  //}
  return aTargetGoody;
}

function PlaySoundAndSetDuration (Sound snd)
{
  local float Dist;

  if (  !bCurrentSoundOver )
  {
    return;
  }
  if ( baseHUD(PlayerHarry.myHUD).bCutSceneMode )
  {
    return;
  }
  Dist = VSize(PlayerHarry.Location - Location);
  if ( Dist > SightRadius )
  {
    return;
  }
  PlaySound(snd);
  SoundDuration = GetSoundDuration(snd);
  bCurrentSoundOver = False;
}

function PlaySoundGetOff ()
{
  switch (Rand(3))
  {
    case 0:
    PlaySoundAndSetDuration(Sound'gnome_talk01');
    break;
    case 1:
    PlaySoundAndSetDuration(Sound'gnome_talk02');
    break;
    case 2:
    PlaySoundAndSetDuration(Sound'gnome_talk03');
    break;
    default:
  }
}

function PlaySoundOuch ()
{
  switch (Rand(8))
  {
    case 0:
    PlaySoundAndSetDuration(Sound'gnome_ouch01');
    break;
    case 1:
    PlaySoundAndSetDuration(Sound'gnome_ouch02');
    break;
    case 2:
    PlaySoundAndSetDuration(Sound'gnome_ouch03');
    break;
    case 3:
    PlaySoundAndSetDuration(Sound'gnome_ouch04');
    break;
    case 4:
    PlaySoundAndSetDuration(Sound'gnome_ouch05');
    break;
    case 5:
    PlaySoundAndSetDuration(Sound'gnome_ouch06');
    break;
    case 6:
    PlaySoundAndSetDuration(Sound'gnome_ouch07');
    break;
    case 7:
    PlaySoundAndSetDuration(Sound'gnome_ouch08');
    break;
    default:
  }
}

function PlaySoundTalk ()
{
  switch (Rand(16))
  {
    case 0:
    PlaySoundAndSetDuration(Sound'gnome_talk01');
    break;
    case 1:
    PlaySoundAndSetDuration(Sound'gnome_talk02');
    break;
    case 2:
    PlaySoundAndSetDuration(Sound'gnome_talk03');
    break;
    case 3:
    PlaySoundAndSetDuration(Sound'gnome_talk04');
    break;
    case 4:
    PlaySoundAndSetDuration(Sound'gnome_talk05');
    break;
    case 5:
    PlaySoundAndSetDuration(Sound'gnome_talk06');
    break;
    case 6:
    PlaySoundAndSetDuration(Sound'gnome_talk07');
    break;
    case 7:
    PlaySoundAndSetDuration(Sound'gnome_talk08');
    break;
    case 8:
    PlaySoundAndSetDuration(Sound'gnome_talk09');
    break;
    case 9:
    PlaySoundAndSetDuration(Sound'gnome_talk10');
    break;
    case 10:
    PlaySoundAndSetDuration(Sound'gnome_talk11');
    break;
    case 11:
    PlaySoundAndSetDuration(Sound'gnome_talk12');
    break;
    case 12:
    PlaySoundAndSetDuration(Sound'gnome_talk13');
    break;
    case 13:
    PlaySoundAndSetDuration(Sound'gnome_talk14');
    break;
    case 14:
    PlaySoundAndSetDuration(Sound'gnome_talk15');
    break;
    case 15:
    PlaySoundAndSetDuration(Sound'gnome_talk16');
    break;
    default:
  }
}

function PlaySoundDie ()
{
  switch (Rand(6))
  {
    case 0:
    PlaySoundAndSetDuration(Sound'gnome_die01');
    break;
    case 1:
    PlaySoundAndSetDuration(Sound'gnome_die02');
    break;
    case 2:
    PlaySoundAndSetDuration(Sound'gnome_die03');
    break;
    case 3:
    PlaySoundAndSetDuration(Sound'gnome_die04');
    break;
    case 4:
    PlaySoundAndSetDuration(Sound'gnome_die05');
    break;
    case 5:
    PlaySoundAndSetDuration(Sound'gnome_die06');
    break;
    default:
  }
}

function PlaySoundGetsThrown ()
{
  switch (Rand(10))
  {
    case 0:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown01');
    break;
    case 1:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown02');
    break;
    case 2:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown03');
    break;
    case 3:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown04');
    break;
    case 4:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown05');
    break;
    case 5:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown06');
    break;
    case 6:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown07');
    break;
    case 7:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown08');
    break;
    case 8:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown09');
    break;
    case 9:
    PlaySoundAndSetDuration(Sound'gnome_gets_thrown10');
    break;
    default:
  }
}

function PlaySoundEat ()
{
  switch (Rand(4))
  {
    case 0:
    PlaySoundAndSetDuration(Sound'gnome_eat01');
    break;
    case 1:
    PlaySoundAndSetDuration(Sound'gnome_eat02');
    break;
    case 2:
    PlaySoundAndSetDuration(Sound'gnome_eat03');
    break;
    case 3:
    PlaySoundAndSetDuration(Sound'gnome_eat04');
    break;
    default:
  }
}

function PlaySoundCrash ()
{
  switch (Rand(5))
  {
    case 0:
    PlaySoundAndSetDuration(Sound'GNO_crash1');
    break;
    case 1:
    PlaySoundAndSetDuration(Sound'GNO_crash2');
    break;
    case 2:
    PlaySoundAndSetDuration(Sound'GNO_crash3');
    break;
    case 3:
    PlaySoundAndSetDuration(Sound'GNO_crash4');
    break;
    case 4:
    PlaySoundAndSetDuration(Sound'GNO_crash5');
    break;
    default:
  }
}

function DropGoodies (EObject otype, int nums, Vector Loc, float Height, bool backward)
{
  local Class<Actor> classtype;
  local Actor A;
  local Vector sloc;
  local Vector v1;
  local Vector v2;
  local float angle;
  local float Length;

  if ( backward )
  {
    sloc = Loc + (PlayerHarry.Location - Loc) * 40.0 / VSize(PlayerHarry.Location - Loc);
  } else {
    sloc = Loc;
  }
  sloc.Z += Height + 30;
  // if ( nums > 0 )
  while (nums > 0)
  {
    classtype = FindClassType(otype);
    A = Spawn(classtype,,,sloc,RotRand());
    HPawn(A).bDespawnable = False;
    angle = RandRange(0.0,6.28319979);
    Length = RandRange(50.0,100.0);
    A.Velocity.X = Length * Cos(angle);
    A.Velocity.Y = Length * Sin(angle);
    A.Velocity.Z = 100.0 + FRand() * 100;
    if ( backward )
    {
      v2.X =  -Velocity.X;
      v2.Y =  -Velocity.Y;
      v2.Z = 0.0;
      // if ( True )
	  while (True)
      {
        angle = RandRange(0.0,6.28319979);
        v1.X = Cos(angle);
        v1.Y = Sin(angle);
        v1.Z = 0.0;
        if ( (v2.X == 0.0) && (v2.Y == 0.0) )
        {
          // goto JL021D;
		  break;
        }
        if ( v1 Dot v2 > 0 )
        {
          // goto JL021D;
		  break;
        }
        // goto JL018C;
      }
      A.Velocity.X = Length * Cos(angle);
      A.Velocity.Y = Length * Sin(angle);
    }
    nums--;
    // goto JL006F;
  }
}

function GnomeDropBeans ()
{
  if ( iBeans == 0 )
  {
    return;
  }
  DropGoodies(/*0*/OBJECT_BEAN,iBeans,Location,CollisionHeight,False);
  iBeans = 0;
}

function HarryDropBeans (int beans)
{
  if ( beans == 0 )
  {
    return;
  }
  DropGoodies(/*0*/OBJECT_BEAN,beans,PlayerHarry.Location,PlayerHarry.CollisionHeight,False);
}

function GnomePickupObject (Actor A)
{
  if ( A == None )
  {
    return;
  }
  if ( A.IsA('Horklumps') )
  {
    A.Destroy();
    A = None;
    return;
  }
  PlaySoundTalk();
  if ( A.IsA('Jellybean') )
  {
    iBeans++;
  }
  if ( aHolding != None )
  {
    aHolding.Destroy();
    aHolding = None;
  }
  ObjectPickup(A,'GNOME R Hand');
}

function bool HarryHasSomeStuff ()
{
  local int stuff;

  stuff = PlayerHarry.JellyBeansCount();
  if ( stuff > 0 )
  {
    return True;
  }
  return False;
}

// function PreBeginPlay ();
function PreBeginPlay ()
{ 
	//all this is added from the proto because UTPT didn't add any of it -AdamJD
	//
	Super.PreBeginPlay();
	
	bJustCreated = true;

	bHome = true;

	DrawScale	= RandRange(1.0, 1.5);
	Fatness		= RandRange(112, 160);

	FindClosestPP();

	// set our home location to be were we started
	vHome = location;
	
	//playerHarry.addJellyBeansPoints(HarryBeans);		// just for testing
	//playerHarry.addPotionsPoints(HarryPotions);  	 	// just for testing

	// save collision information
	savedCollisionRadius = CollisionRadius;
	savedCollisionHeight = CollisionHeight;

	bFlipPushable	= true;
	lockSpell		= true;

	// have our run normal the default animation
	LoopAnim('runNormal');
}

function Bump (Actor Other)
{
  local int beans;
  local int potions;

  if ( Other != PlayerHarry )
  {
    return;
  }
  if ( GetStateName() != 'stateGotoHarry' )
  {
    return;
  }
  beans = PlayerHarry.JellyBeansCount();
  GetSomethingFromHarry(beans,0);
  GotoState('stateGoSomeWhere');
}

function Touch (Actor Other)
{
  Super.Touch(Other);
  if ( Other.IsA('Jellybean') || Other.IsA('WiggenWell') )
  {
    if ( (GetStateName() != 'stateGettingUp') && (GetStateName() != 'stateDied') )
    {
      GotoState('statePickupTargetObject');
    }
  }
  if ( (aHolding == None) && Other.IsA('Horklumps') )
  {
    if ( GetStateName() != 'stateGettingUp' )
    {
      GotoState('stateEatMushroom');
    }
  }
}

function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
{
  Super.HandleSpellFlipendo(spell,vHitLocation);
  GotoState('stateHitByFlip');
  return True;
}

function Tick (float Delta)
{
  Super.Tick(Delta);
  if ( HitByFlipendoTime > 0 )
  {
    HitByFlipendoTime -= Delta;
  }
  SoundPlayTime += Delta;
  if ( SoundPlayTime > SoundDuration )
  {
    bCurrentSoundOver = True;
    SoundPlayTime = 0.0;
  }
  if ( (GetStateName() == 'stateBeingThrown') || (HitByFlipendoTime > 0) )
  {
    bDespawnable = True;
  } else {
    bDespawnable = False;
  }
  if ( bDespawned )
  {
    bDespawnable = True;
    if ( GetStateName() != 'stateDied' )
    {
      GotoState('stateDied');
    }
  }
  if ( (Owner == PlayerHarry) && (GetStateName() != 'stateWasHoldingByHarry') )
  {
    GotoState('stateWasHoldingByHarry');
  }
}

function Landed (Vector HitNormal)
{
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  Super.Landed(HitNormal);
  SetCollisionSize(savedCollisionRadius,savedCollisionHeight);
  if ( GetStateName() != 'stateDied' )
  {
    GotoState('stateGettingUp');
  }
}

function HitWall (Vector HitNormal, Actor HitWall)
{
  if ( IsInState('stateWasHoldingByHarry') )
  {
    return;
  }
  if ( IsInState('stateBeingThrown') )
  {
    return;
  }
  if ( IsInState('stateHitByFlip') )
  {
    return;
  }
  if ( IsInState('stateGettingUp') )
  {
    return;
  }
  if ( IsInState('statePickupTargetObject') )
  {
    return;
  }
  if ( IsInState('stateThrowMushroomLump') )
  {
    return;
  }
  if ( IsInState('stateEatMushroom') )
  {
    return;
  }
  if ( IsInState('stateHitWall') )
  {
    return;
  }
  vNewLoc = Location + 5 * HitNormal / VSize(HitNormal);
  vNewLoc.Z = Location.Z;
  GotoState('stateHitWall');
}

function FindTargetLocation ()
{
  vTargetLocation = aTargetGoody.Location;
}

function ShrinkActor (Actor A, float coeff)
{
  A.DrawScale *= coeff;
  A.SetCollisionSize(A.CollisionRadius * coeff,A.CollisionHeight * coeff);
}

function GetSomethingFromHarry (int beans, int potions)
{
  local int howManyBeans;
  local int howManyPotions;

  PlaySoundTalk();
  PlayerHarry.HarryKnockBack();
  if ( (beans == 0) && (potions == 0) )
  {
    return;
  }
  if ( beans > 0 )
  {
    howManyBeans = Rand(5) + 1;
  } else {
    howManyBeans = 0;
  }
  if ( howManyBeans > beans )
  {
    howManyBeans = beans;
  }
  if ( potions > 0 )
  {
    howManyPotions = Rand(2) + 1;
  } else {
    howManyPotions = 0;
  }
  if ( howManyPotions > potions )
  {
    howManyPotions = potions;
  }
  if ( (howManyPotions == 0) && (howManyBeans == 0) )
  {
    return;
  }
  if ( howManyPotions == 0 )
  {
    HarryDropBeans(howManyBeans);
    PlayerHarry.AddJellyBeansPoints( -howManyBeans);
    return;
  }
}

function DestroyHolding ()
{
  if ( aHolding == None )
  {
    return;
  }
  aHolding.SetOwner(None);
  aHolding.Destroy();
  aHolding = None;
}

function DestroyHoldingAndTakeAwayAllGoodies ()
{
  iBeans = 0;
  DestroyHolding();
}

function PlayIdleAnim ()
{
  local int Output;

  PlaySoundTalk();
  Output = Rand(7);
  if ( aHolding != None )
  {
    if ( (Output == 0) || (Output == 1) )
    {
      PlayAnim('idlecarryobject');
    } else //{
      if ( (Output == 2) || (Output == 3) )
      {
        PlayAnim('carry_taunt2');
      } else {
        PlayAnim('carry_taunt1');
      }
    //}
  } else {
    Output = Rand(7);
    if ( Output == 0 )
    {
      PlayAnim('sidestep');
    } else //{
      if ( Output == 1 )
      {
        PlayAnim('Look');
      } else //{
        if ( (Output == 2) || (Output == 3) )
        {
          PlayAnim('tauntjump');
        } else {
          PlayAnim('tauntass');
        }
      //}
    //}
  }
}

function LoopRunAnimNormal ()
{
  PlaySoundTalk();
  if ( aHolding != None )
  {
    LoopAnim('runcarryobject');
  } else {
    LoopAnim('runnormal');
  }
}

function LoopRunAnimAttack ()
{
  PlaySoundTalk();
  if ( aHolding != None )
  {
    LoopAnim('runcarryobject');
  } else {
    LoopAnim('runattack');
  }
}

function LoopRunAnimAttackBite ()
{
  PlaySoundTalk();
  if ( aHolding != None )
  {
    LoopAnim('runcarryobject');
  } else {
    LoopAnim('runattackbite');
  }
}

state stateJustStandThere
{
begin:
  Sleep(RandRange(1.0,2.0));
  switch (Rand(7))
  {
    case 0:
    PlayAnim('Look',1.0,0.5);
    break;
    case 1:
    PlayAnim('sidestep',1.0,0.5);
    break;
    case 2:
    PlayAnim('introangry',1.0,0.5);
    break;
    case 3:
    PlayAnim('tauntass',1.0,0.5);
    break;
    case 4:
    PlayAnim('eat',1.0,0.5);
    break;
    case 5:
    PlayAnim('idlecarryobject',1.0,0.5);
    break;
    case 6:
    PlayAnim('carry_taunt1',1.0,0.5);
    break;
    default:
  }
  FinishAnim();
  goto ('Begin');
}

auto state stateIdle //extends stateIdle
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": auto stateIdle");
  }
  if (  !bJustCreated )
  {
    Acceleration = vect(0.00,0.00,0.00);
    Velocity = vect(0.00,0.00,0.00);
  } else {
    bJustCreated = False;
  }
  PlayIdleAnim();
  FinishAnim();
  if ( bHome )
  {
    bHome = False;
    DestroyHoldingAndTakeAwayAllGoodies();
    GotoState('stateGotoPatrolPointForce');
  } else {
    GotoState('statePatrol');
  }
}

state stateWasHoldingByHarry
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateWasHoldingByHarry");
  }
  PlayAnim('Pickup',1.5);
  FinishAnim();
  PlaySoundGetOff();
  goto ('Begin');
}

state stateGotoPatrolPointForce
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateGotoPatrolPointForce");
  }
  LoopRunAnimNormal();
  MoveTo(pPLoc);
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  PlayIdleAnim();
  FinishAnim();
  if ( VeryCloseToPatrolPoint() )
  {
    GotoState('statePatrol');
  } else {
    GotoState('stateGoHome');
  }
}

state stateGotoPatrolPointBack
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateGotoPatrolPointBack");
  }
  LoopRunAnimAttack();
  MoveTo(pPLoc);
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  PlayIdleAnim();
  FinishAnim();
  if ( bHasHome && (iBeans > 0) )
  {
    GotoState('stateGoHome');
  } else {
    GotoState('statePatrol');
  }
}

state stateGoHome
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateGoHome");
  }
  LoopRunAnimAttack();
  MoveTo(vHome);
  bHome = True;
  GotoState('stateIdle');
}

state stateBeingThrown //extends stateBeingThrown
{
  // ignores  Landed; //UTPT added this for some reason -AdamJD
  
  //UTPT didn't add this for some reason -AdamJD
  function Landed(vector HitNormal)	
  { 
	Global.Landed(HitNormal); 
  }
  
 begin:
  SetCollisionSize(10.0,13.0);
  PlaySoundGetsThrown();
  SoundDuration = 0.0;
  Lives = 2;
  PlayAnim('KnockBack',1.5);
  FinishAnim();
  Sleep(1.0);
  SetCollisionSize(savedCollisionRadius,savedCollisionHeight);
  GotoState('stateGettingUp');
}

state stateRunAway
{
begin:
  vNewLoc = Location + 100 * VRand();
  vNewLoc.Z = Location.Z;
  LoopAnim('runscared');
  TurnTo(vNewLoc);
  MoveTo(vNewLoc);
  DesiredRotation.Yaw = Rotation.Yaw;
  PlayIdleAnim();
  FinishAnim();
  GotoState('statePatrol');
}

state stateHitByFlip
{
  function BeginState ()
  {
    if ( Lives > 0 )
    {
      Lives--;
    }
    GnomeDropBeans();
    DestroyHolding();
    PlaySoundOuch();
    PlayAnim('KnockBack');
    vTargetDir = Normal(PlayerHarry.Location - Location);
    DesiredRotation = rotator(vTargetDir);
    HitByFlipendoTime = 2.0;
  }
  
 begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateHitByFlip");
  }
}

state stateGettingUp
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateGettingUp");
  }
  DestroyHoldingAndTakeAwayAllGoodies();
  SetCollisionSize(savedCollisionRadius,savedCollisionHeight);
  if (  !bDespawned )
  {
    PlaySoundDie();
    bObjectCanBePickedUp = True;
  } else {
    bObjectCanBePickedUp = False;
  }
  LoopAnim('downbreath');
  Sleep(3.0);
  PlayAnim('downdizzy');
  FinishAnim();
  LoopAnim('downbreath');
  Sleep(2.0);
  PlayAnim('downdizzy');
  FinishAnim();
  if ( bDespawned || (Lives == 0) )
  {
    goto ('Begin');
  }
  PlayAnim('GetUp');
  FinishAnim();
  bObjectCanBePickedUp = False;
  GotoState('stateRunAway');
}

state statePatrol
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": statePatrol");
  }
  if ( HasTooManyGoodies() )
  {
    if ( LineOfSightTo(pP) )
    {
      GotoState('stateGotoPatrolPointBack');
    } else {
      GotoState('stateGoSomeWhere');
    }
  }
  if ( FindClosestGoody() != None )
  {
    vTargetDir = Normal(aTargetGoody.Location - Location);
    DesiredRotation = rotator(vTargetDir);
    GotoState('stateGotoTargetObject');
  }
  if ( HarryHasSomeStuff() )
  {
    if ( MyLineOfSightTo(PlayerHarry) )
    {
      vTargetDir = PlayerHarry.Location - Location;
      if ( VSize(vTargetDir) < SightRadius )
      {
        vNewLoc = Location + 20 * vTargetDir / VSize(vTargetDir);
        GotoState('stateGotoHarry');
      } else {
        GotoState('stateGoSomeWhere');
      }
    } else {
      GotoState('stateGoSomeWhere');
    }
  } else {
    if ( Rand(2) == 0 )
    {
      if ( MyLineOfSightTo(PlayerHarry) )
      {
        vTargetDir = PlayerHarry.Location - Location;
        if ( VSize(vTargetDir) < SightRadius )
        {
          vNewLoc = PlayerHarry.Location;
          GotoState('stateGotoHarry');
        } else {
          GotoState('stateGoSomeWhere');
        }
      } else {
        GotoState('stateGoSomeWhere');
      }
    } else {
      if ( LineOfSightTo(pP) )
      {
        GotoState('stateGotoPatrolPointBack');
      } else {
        GotoState('stateGoSomeWhere');
      }
    }
  }
  GotoState('stateGoSomeWhere');
}

state stateGotoHarry
{
begin:
  LoopRunAnimAttackBite();
  TurnTo(vNewLoc);
  MoveTo(vNewLoc);
  DesiredRotation.Yaw = Rotation.Yaw;
  GotoState('statePatrol');
}

state stateThrowMushroomLump
{
  function Tick (float dtime)
  {
    local int Frame;
  
    Super(HChar).Tick(dtime);
    Frame = AnimFrame * 46;
	if ( bPlayThrowAnim && (Frame >= 30) && (LastAnimFrame < 30) )
    {
      ObjectThrow(vTargetDir,True,True);
    }
    LastAnimFrame = Frame;
  }
  
 begin:
  bPlayThrowAnim = False;
  vNewLoc = Location + 100 * VRand();
  vNewLoc.Z = Location.Z;
  LoopRunAnimNormal();
  TurnTo(vNewLoc);
  MoveTo(vNewLoc);
  DesiredRotation.Yaw = Rotation.Yaw;
  TurnTo(PlayerHarry.Location);
  DesiredRotation.Yaw = Rotation.Yaw;
  vTargetDir = ComputeTrajectoryByTime(Location,PlayerHarry.Location,0.5);
  bPlayThrowAnim = True;
  PlayAnim('throw',1.0);
  FinishAnim();
  bPlayThrowAnim = False;
  GotoState('statePatrol');
}

state stateGoSomeWhere
{
begin:
  vNewLoc = Location + 100 * VRand();
  vNewLoc.Z = Location.Z;
  LoopRunAnimNormal();
  TurnTo(vNewLoc);
  MoveTo(vNewLoc);
  DesiredRotation.Yaw = Rotation.Yaw;
  PlayIdleAnim();
  FinishAnim();
  GotoState('statePatrol');
}

state stateGotoTargetObject
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateGotoTargetObject");
  }
  vNewLoc = Location + 20 * VRand();
  vNewLoc.Z = Location.Z;
  LoopRunAnimAttack();
  TurnTo(vNewLoc);
  MoveTo(vNewLoc);
  DesiredRotation.Yaw = Rotation.Yaw;
  FindTargetLocation();
  LoopRunAnimAttack();
  MoveTo(vTargetLocation);
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  DesiredRotation.Yaw = Rotation.Yaw;
  GotoState('statePatrol');
}

state stateEatMushroom
{
  function Tick (float dtime)
  {
    Super(HChar).Tick(dtime);
    ShrinkActor(aTargetGoody,hunger);
  }
  
 begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateEatMushroom");
  }
  if ( aTargetGoody == None )
  {
    GotoState('statePatrol');
  }
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  if ( aTargetGoody.IsA('Horklumps') )
  {
    PlaySoundEat();
    PlayAnim('eatloop');
    FinishAnim();
    aTargetGoody.Destroy();
    aTargetGoody = None;
    DropGoodies(/*0*/OBJECT_BEAN,Rand(2) + 1,Location,CollisionHeight,False);
  } else {
    GotoState('statePatrol');
  }
  GotoState('statePatrol');
}

state statePickupTargetObject
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": statePickupTargetObject");
  }
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  if ( aTargetGoody == None )
  {
    GotoState('statePatrol');
  }
  if ( aTargetGoody.IsA('Horklumps') )
  {
    GotoState('statePatrol');
  }
  if ( aTargetGoody.Owner != None )
  {
    GotoState('statePatrol');
  }
  TurnTo(aTargetGoody.Location);
  GnomePickupObject(aTargetGoody);
  PlayIdleAnim();
  FinishAnim();
  vTargetDir = PlayerHarry.Location - Location;
  if ( VSize(vTargetDir) < 50 )
  {
    vNewLoc = Location - 50 * vTargetDir / VSize(vTargetDir);
    GotoState('stateGotoHarry');
  }
  GotoState('statePatrol');
}

state stateHitWall
{
begin:
  Acceleration = vect(0.00,0.00,0.00);
  Velocity = vect(0.00,0.00,0.00);
  LoopRunAnimNormal();
  TurnTo(vNewLoc);
  MoveTo(vNewLoc);
  DesiredRotation.Yaw = Rotation.Yaw;
  GotoState('statePatrol');
}

state stateDied
{
begin:
  if ( False )
  {
    PlayerHarry.ClientMessage("" $ string(Name) $ ": stateDied");
  }
  PlaySoundCrash();
  if ( Rand(2) == 0 )
  {
    Spawn(Class'DustCloud01_tiny',self,,Location,Rotation);
  } else {
    Spawn(Class'DustCloud02_small',self,,Location,Rotation);
  }
  DropGoodies(/*0*/OBJECT_BEAN,Rand(3) + 1,Location,0.0,True);
  Destroy();
}

defaultproperties
{
    Lives=2

    bCurrentSoundOver=True

    bHasHome=True

    MaxGoodies=15

    hunger=0.94

    soundFalling(0)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown01'

    soundFalling(1)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown02'

    soundFalling(2)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown03'

    soundFalling(3)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown04'

    soundFalling(4)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown05'

    soundFalling(5)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown06'

    soundFalling(6)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown07'

    soundFalling(7)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown08'

    soundFalling(8)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown09'

    soundFalling(9)=Sound'HPSounds.Critters_sfx.gnome_gets_thrown10'

    bThrownObjectDamage=True

    bAccurateThrowing=True

    GroundSpeed=150.00

    SightRadius=400.00

    PeripheralVision=1.00

    BaseEyeHeight=15.00

    EyeHeight=15.00

    // eVulnerableToSpell=13
	eVulnerableToSpell=SPELL_Flipendo

    Mesh=SkeletalMesh'HPModels.skgnomeMesh'

    DrawScale=1.25

    AmbientGlow=75

    CollisionRadius=12.00

    CollisionHeight=20.00
}
