//================================================================================
// spellSnakeHeadFire.
//================================================================================

class spellSnakeHeadFire extends baseSpell;

function PostBeginPlay()
{
  Super.PostBeginPlay();
  InitSpell(None,None);
}

event BeginEvent()
{
}

event EndEvent()
{
}

event KilledBy (Pawn EventInstigator)
{
}

function OnSpellShutdown()
{
}

function bool OnSpellHitHPawn (Actor aHit, Vector vHitLocation)
{
  return HPawn(aHit).HandleSpellFlipendo(self,vHitLocation);
}

auto state StateFlying
{
  function BeginState()
  {
    Velocity = vector(Rotation) * Speed;
  }
  
  function ProcessTouch (Actor Other, Vector HitLocation)
  {
    if ( Pawn(Other) == Instigator )
    {
      return;
    }
    if (  !Other.bBlockActors )
    {
      return;
    }
    if ( Other.IsA('harry') )
    {
      Other.TakeDamage(Damage, Instigator,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
      CreateHitEffects(Other,HitLocation);
    }
    OnSpellShutdown();
    Destroy();
  }
  
  event Tick (float fTimeDelta)
  {
    Super.Tick(fTimeDelta);
    if ( fxFlyParticleEffect != None )
    {
      fxFlyParticleEffect.SetLocation(Location);
    }
  }
  begin:
}

defaultproperties
{
    // SpellType=13
	SpellType=SPELL_Flipendo

    SpellIcon=None

    SeekSpeed=50.00

    fxFlyParticleEffectClass=Class'HPParticle.TorchFire04'

    fxHitParticleEffectClass=Class'HPParticle.Flip_hit'

    SpellIncantation="spells1"

    QuietSpellIncantation="spells10"

    Damage=10.00

    // DrawType=0
	DrawType=DT_None

    CollisionRadius=30.00

    CollisionHeight=30.00
}
