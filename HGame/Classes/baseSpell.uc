//================================================================================
// baseSpell.
//================================================================================

class baseSpell extends Projectile;

var ESpellType SpellType;
var Texture SpellIcon;
var float SpellCharge;
var float SpellLifeTime;
var baseWand SpellWand;
var Actor TargetActor;
var Vector TargetOffset;
var() float SeekSpeed;
var Vector CurrentDir;
var(VisualFX) ParticleFX fxFlyParticleEffect;
var(VisualFX) Class<ParticleFX> fxFlyParticleEffectClass;
var(VisualFX) ParticleFX fxHitParticleEffect;
var(VisualFX) Class<ParticleFX> fxHitParticleEffectClass;
var(VisualFX) ParticleFX fxHitWallParticleEffect;
var(VisualFX) Class<ParticleFX> fxHitWallParticleEffectClass;
var(VisualFX) ParticleFX fxReactParticleEffect;
var(VisualFX) Class<ParticleFX> fxReactParticleEffectClass;
var Sound CastSound;
var string SpellIncantation;
var string QuietSpellIncantation;
var harry PlayerHarry;
var bool bUseDebugMode;

function SetDebugMode (bool bOn)
{
  bUseDebugMode = bOn;
}

function InitSpell (Actor CastedBy, Actor CastedAt, optional Vector CastedAtOffset, optional float CastedChargeAmount, optional baseWand CastedFromWand)
{
  local float Scale;

  SetOwner(CastedBy);
  TargetActor = CastedAt;
  TargetOffset = CastedAtOffset;
  SpellWand = CastedFromWand;
  if ( (fxFlyParticleEffect == None) && (fxFlyParticleEffectClass != None) )
  {
    fxFlyParticleEffect = Spawn(fxFlyParticleEffectClass);
    fxFlyParticleEffect.SetLocation(Location);
    fxFlyParticleEffect.SetRotation(Rotation);
  }
  SetSpellCharge(CastedChargeAmount);
  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("InitSpell: " $ string(self) $ " owner: " $ string(Owner) $ " target: " $ string(TargetActor) $ " charge: " $ string(SpellCharge) $ " speed: " $ string(Speed));
  }
  OnSpellInit();
}

simulated function PostBeginPlay ()
{
  local float Scale;

  Super.PostBeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
  CurrentDir = vector(Rotation);
}

event Destroyed ()
{
  if ( SpellWand != None )
  {
    SpellWand.SubtractFromCastedSpellList(self);
  }
  if ( fxFlyParticleEffect != None )
  {
    fxFlyParticleEffect.Shutdown();
  }
  OnSpellShutdown();
}

function OnSpellInit ()
{
}

function OnSpellShutdown ()
{
}

event FellOutOfWorld ()
{
}

function PlayIncantationSound (Actor Instigator)
{
  if ( Instigator.IsA('harry') )
  {
    harry(Instigator).HandleSpellIncantationSound(SpellType);
  } else //{
    if ( Instigator.IsA('HPawn') )
    {
      HPawn(Instigator).HandleSpellIncantationSound(SpellType);
    }
  //}
}

event Tick (float fTimeDelta)
{
  if ( (SpellLifeTime -= fTimeDelta) < 0 )
  {
    if ( bUseDebugMode )
    {
      PlayerHarry.ClientMessage("Spell " $ string(self) $ " LifeTime is up!");
    }
    OnSpellShutdown();
    Destroy();
  }
}

function bool OnSpellHitHarry (Actor aHit, Vector HitLocation)
{
  return False;
}

function bool OnSpellHitHPawn (Actor aHit, Vector HitLocation)
{
  return False;
}

function bool OnSpellHitWall (Actor aWall, Vector HitNormal)
{
  fxHitWallParticleEffect = Spawn(fxHitWallParticleEffectClass,self,,Location);
  return True;
}

simulated function HitWall (Vector HitNormal, Actor Wall)
{
  if ( Wall.IsA('GridMover') )
  {
    if ( bUseDebugMode )
    {
      PlayerHarry.ClientMessage("Spell: " $ string(self) $ " HitWall GridMover: " $ string(Wall));
    }
    CreateHitEffects(Wall,Location);
  } else {
    if ( bUseDebugMode )
    {
      PlayerHarry.ClientMessage("Spell: " $ string(self) $ " HitWall Other: " $ string(Wall));
    }
    if ( False == OnSpellHitWall(Wall,HitNormal) )
    {
      return;
    }
  }
  OnSpellShutdown();
  Destroy();
}

function ProcessTouch (Actor Other, Vector HitLocation)
{
  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("Spell::ProcessTouch : " $ string(self) $ " other :" $ string(Other));
  }
  if ( (Other == Owner) || Other.IsA('baseSpell') || Other.IsA('ParticleFX') )
  {
    if ( bUseDebugMode )
    {
      PlayerHarry.ClientMessage("Spell: " $ string(self) $ " *INVALID* Touch to :" $ string(Other) $ "will not die yet.");
    }
    return;
  } else //{
    if ( Other.IsA('harry') )
    {
      if ( False == OnSpellHitHarry(Other,HitLocation) )
      {
        if ( bUseDebugMode )
        {
          PlayerHarry.ClientMessage("Spell:" $ string(self.Name) $ " *INVALID* Touch to Harry:" $ string(Other.Name) $ " NOT RELEVANT, OnSpellHitHarry() returned false!");
        }
        return;
      }
      if ( bUseDebugMode )
      {
        PlayerHarry.ClientMessage("Spell: " $ string(self) $ " VALID Touch to Harry:" $ string(Other) $ " SpellCharge: " $ string(SpellCharge));
      }
      CreateHitEffects(Other,HitLocation);
    } else //{
      if ( Other.IsA('HPawn') )
      {
        if ( False == OnSpellHitHPawn(Other,HitLocation) )
        {
          if ( bUseDebugMode )
          {
            PlayerHarry.ClientMessage("Spell:" $ string(self.Name) $ " *INVALID* Touch to HPAWN:" $ string(Other.Name) $ " NOT RELEVANT, OnSpellHitHPawn() returned false!");
          }
          return;
        }
        if ( bUseDebugMode )
        {
          PlayerHarry.ClientMessage("Spell: " $ string(self) $ " VALID Touch to HPAWN:" $ string(Other) $ " SpellCharge: " $ string(SpellCharge));
        }
        HPawn(Other).OnSpellHit(self,HitLocation);
        CreateHitEffects(Other,HitLocation);
      } else //{
        if ( Other.IsA('spellTrigger') )
        {
          if ( bUseDebugMode )
          {
            PlayerHarry.ClientMessage("Spell: " $ string(self) $ " VALID Touch to spellTrigger:" $ string(Other));
          }
          CreateHitEffects(Other,HitLocation);
        } else //{
          if ( bUseDebugMode )
          {
            PlayerHarry.ClientMessage("Spell: " $ string(self) $ " Touched ***UNCLASSIFIED***:" $ string(Other));
          }
        // }
      // }
    // }
  // }
  SetPhysics(PHYS_None);
  OnSpellShutdown();
  Destroy();
}

static function Texture GetSpellIcon ()
{
  return Default.SpellIcon;
}

function bool IsRelevantToMover ()
{
  return True;
}

function ScaleParticles (ParticleFX FX, float Scale)
{
  FX.ParticlesPerSec.Base = FX.Default.ParticlesPerSec.Base * Scale;
  FX.SourceHeight.Base = FX.Default.SourceHeight.Base * Scale;
  FX.SourceWidth.Base = FX.Default.SourceWidth.Base * Scale;
  FX.SourceDepth.Base = FX.Default.SourceDepth.Base * Scale;
  FX.SizeWidth.Base = FX.Default.SizeWidth.Base * Scale;
  FX.SizeLength.Base = FX.Default.SizeLength.Base * Scale;
  FX.AngularSpreadWidth.Base = FX.Default.AngularSpreadWidth.Base * Scale;
  FX.AngularSpreadHeight.Base = FX.Default.AngularSpreadHeight.Base * Scale;
  FX.SpinRate.Base = FX.Default.SpinRate.Base * Scale;
}

function CreateHitEffects (Actor ActorHit, Vector vHitLocation)
{
  local float Scale;
  local float lTime;

  if ( ImpactSound != None )
  {
    // PlaySound(ImpactSound,0,1.0,False,2000.0,1.0);
	PlaySound( ImpactSound, SLOT_None,  1.0, false, 2000.0, 1);
  }
  if ( bUseDebugMode )
  {
    PlayerPawn(Instigator).ClientMessage("Spell::CreateHitEffects using hitFXClass = " $ string(fxHitParticleEffectClass) $ " reactFXClass = " $ string(fxReactParticleEffectClass));
  }
  if ( fxHitParticleEffectClass != None )
  {
    fxHitParticleEffect = Spawn(fxHitParticleEffectClass);
    fxHitParticleEffect.SetLocation(vHitLocation);
    fxHitParticleEffect.SetRotation(fxHitParticleEffect.Default.Rotation);
    fxHitParticleEffect.SetOwner(ActorHit);
    if ( fxHitParticleEffect.IsA('duelRictusempra_hit') || fxHitParticleEffect.IsA('duelMimblewimble_hit') )
    {
      if ( fxHitParticleEffect.IsA('duelRictusempra_hit') )
      {
        duelRictusempra_hit(fxHitParticleEffect).HitActor = ActorHit;
      } else //{
        if ( fxHitParticleEffect.IsA('duelMimblewimble_hit') )
        {
          duelMimblewimble_hit(fxHitParticleEffect).HitActor = ActorHit;
        }
      //}
      if ( ActorHit.IsA('harry') )
      {
        lTime = PlayerHarry.fTimeAfterHit;
      } else //{
        if ( ActorHit.IsA('Duellist') )
        {
          lTime = Duellist(PlayerHarry.DuelOpponent).fTimeAfterHit;
        }
    }
  }
}

function SetSpellDirection (Vector Dir)
{
  CurrentDir = Normal(Dir);
  DesiredRotation = rotator(CurrentDir);
  SetRotation(DesiredRotation);
  fxFlyParticleEffect.SetRotation(DesiredRotation);
}

function Vector GetTargetHitLocation ()
{
  return TargetActor.Location + TargetOffset;
}

function UpdateRotationWithSeeking (float fTimeDelta)
{
  local Vector TargetDir;

  if ( TargetActor == None )
  {
    return;
  }
  TargetDir = Normal(GetTargetHitLocation() - Location);
  CurrentDir += (TargetDir - CurrentDir) * FMin(1.0,SeekSpeed * fTimeDelta);
  CurrentDir = Normal(CurrentDir);
  DesiredRotation = rotator(CurrentDir);
  SetRotation(DesiredRotation);
  Velocity = CurrentDir * Speed;
}

function SetSpellCharge (float fNewCharge)
{
  local float Scale;

  SpellCharge = fNewCharge;
  if ( (SpellCharge > 0) && (SpellWand != None) )
  {
    ScaleParticles(fxFlyParticleEffect,SpellWand.GetChargeParticleFXScale(SpellCharge));
  }
}

function Reflect (Actor aNewOwner, float fNewCharge, float fNewSpeed)
{
  local Pawn PawnOwner;

  if ( SpellWand != None )
  {
    SpellWand.SubtractFromCastedSpellList(self);
  }
  if ( aNewOwner.IsA('Pawn') )
  {
    PawnOwner = Pawn(aNewOwner);
    if ( PawnOwner.Weapon.IsA('baseWand') )
    {
      SpellWand = baseWand(PawnOwner.Weapon);
      SpellWand.AddToCastedSpellList(self);
    }
  }
  TargetActor = Owner;
  SetOwner(aNewOwner);
  SetSpellCharge(fNewCharge);
  SetSpellDirection(GetTargetHitLocation() - Location);
  Speed = fNewSpeed;
  Velocity = CurrentDir * Speed;
  SpellLifeTime = Default.SpellLifeTime;
  LifeSpan = Default.LifeSpan;
  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("*Spell REFLECTED by " $ string(aNewOwner) $ ", new owner = " $ string(Owner) $ " new target: " $ string(TargetActor) $ " new charge: " $ string(SpellCharge) $ " new speed: " $ string(Speed));
  }
}

defaultproperties
{
    SpellIcon=Texture'Icons.defaultSpellIcon'

    SpellLifeTime=8.00

    SeekSpeed=7.00

    fxHitWallParticleEffectClass=Class'HPParticle.DustCloud02_small'

    Speed=500.00

    Damage=5.00

    ImpactSound=Sound'HPSounds.Magic_sfx.spell_hit'

    bNetTemporary=False

    RemoteRole=2

    LifeSpan=10.00

    Style=3

    DrawScale=0.30

    bUnlit=True

    CollisionRadius=2.00

    CollisionHeight=2.00

    bProjTarget=True

    LightType=1

    LightEffect=13

    LightBrightness=201

    LightHue=165

    LightSaturation=72

    LightRadius=10

    bFixedRotationDir=True

}
