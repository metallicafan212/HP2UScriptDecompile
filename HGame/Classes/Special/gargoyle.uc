//================================================================================
// gargoyle.
//================================================================================

class gargoyle extends HChar;

var() bool ignoreCutCam;
var() bool bMakeLumosInfinite;

function Trigger (Actor Other, Pawn EventInstigator)
{
  local Actor A;

  GotoState('Green');
  if ( Event != 'None' )
  {
    foreach AllActors(Class'Actor',A,Event)
    {
      A.Trigger(self,self);
    }
  }
}

function bool HandleSpellLumos (optional baseSpell spell, optional Vector vHitLocation)
{
  baseWand(PlayerHarry.Weapon).LumosTurnOn();
  if ( bMakeLumosInfinite )
  {
    baseWand(PlayerHarry.Weapon).TheLumosLight.bInfiniteLumos = True;
  }
  GotoState('Green');
  return True;
}

auto state lookaround
{
begin:
  Enable('Trigger');
  LoopAnim('Red');
}

state Green
{
  function switchCamera ()
  {
    local BaseCam C;
  
  }
  
  function returnCamera ()
  {
    local BaseCam C;
  
    foreach AllActors(Class'BaseCam',C)
    {
      // goto JL0014;
	  break;
    }
  }
  
  function AnimEnd ()
  {
    if ( AnimSequence == 'Green' )
    {
      LoopAnim('Red',1.0,2.0);
    }
  }
  
 begin:
  PlayAnim('change2green',1.0,0.5);
  Sleep(1.0);
  PlaySound(Sound'Fawkes_wing_flap',/*0*/SLOT_None,,,,1.75);
  Sleep(0.25);
  PlaySound(Sound'owl_wing_flap',/*0*/SLOT_None,,,,1.75);
  Sleep(73.0 / 30.0 - 1.25 - 0.25);
  PlaySound(Sound'dragon_statue_roar',/*0*/SLOT_None);
  FinishAnim();
  LoopAnim('Green',1.0,0.5);
  Sleep(1.0);
  if (  !ignoreCutCam )
  {
    switchCamera();
    Sleep(2.0);
    returnCamera();
  }
}

defaultproperties
{
    ignoreCutCam=True

    bStatic=True

    // eVulnerableToSpell=4
	eVulnerableToSpell=SPELL_Lumos

    Mesh=SkeletalMesh'HPModels.skgargoyleMesh'

    AmbientGlow=75

    CollisionRadius=50.00

    CollisionHeight=50.00

    bBlockCamera=True
}
