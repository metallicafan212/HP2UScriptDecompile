//================================================================================
// spellDuelExpelliarmus.
//================================================================================

class spellDuelExpelliarmus extends baseSpell;

function Color Col (float R, float G, float B)
{
  local Color C;
  
  //UTPT didn't add this... -AdamJD
  C.R = R;
  C.G = G;
  C.B = B;
  
  //or this... -AdamJD
  return C;
}

function PostBeginPlay()
{
  Super.PostBeginPlay();
}

function OnSpellInit()
{
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellDuelExpelliarmus(self,vHitLocation);
}

function bool OnSpellHitHarry (Actor aHit, Vector vHitLocation)
{
  return harry(aHit).HandleSpellDuelExpelliarmus(self,vHitLocation);
}

auto state stateIdle
{
begin:
  GotoState('StateFlying');
}

state StateFlying
{
  function BeginState()
  {
  }
  
  event Tick (float fTimeDelta)
  {
    local Rotator Rot;
  
    Super.Tick(fTimeDelta);
    SetLocation(SpellWand.GetWandEndPoint());
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
  }
  begin:
}

defaultproperties
{
    // SpellType=27
	SpellType=SPELL_DuelExpelliarmus

    SpellIcon=None

    SpellLifeTime=1.00

    SeekSpeed=0.00

    fxHitParticleEffectClass=Class'HPParticle.Lumos_hit'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    Speed=0.00

    // DrawType=0
	DrawType=DT_None
}
