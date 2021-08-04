//================================================================================
// spellDuelRictusempra.
//================================================================================

class spellDuelRictusempra extends baseSpell;

function PostBeginPlay()
{
  Super.PostBeginPlay();
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellDuelRictusempra(self,vHitLocation);
}

function bool OnSpellHitHarry (Actor aHit, Vector vHitLocation)
{
  return harry(aHit).HandleSpellDuelRictusempra(self,vHitLocation);
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
    Velocity = vector(Rotation) * Speed;
    Acceleration = Velocity;
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    UpdateRotationWithSeeking(fTimeDelta);
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
  }
  begin:
}

defaultproperties
{
    // SpellType=25
	SpellType=SPELL_DuelRictusempra

    SpellIcon=None

    SeekSpeed=0.00

    fxFlyParticleEffectClass=Class'HPParticle.duelRictusempra_fly'

    fxHitParticleEffectClass=Class'HPParticle.duelRictusempra_hit'

    SpellIncantation="spells3"

    QuietSpellIncantation="spells4"

    // DrawType=0
	DrawType=DT_None
}
