//================================================================================
// baseWand.
//================================================================================

class baseWand extends HWeapon;

const MAX_NUM_CASTED_SPELLS= 8;
var bool bAutoSelectSpell;
var Class<baseSpell> CurrentSpell;
var float fAutoHitDistance;
var baseSpell CastedSpellList[8];
var baseSpell LastCastedSpell;
var int NumCastedSpells;
var ParticleFX fxChargeParticles;
var Class<ParticleFX> fxChargeParticleFXClass;
var LumosLight TheLumosLight;
var bool bInstantFire;
var bool bSpellCharges;
var float fSpellCharge;
var float fSpellChargeTime;
var float fSpellChargeTimeSpan;
var float fSpellChargeStartScale;
var float fSpellChargeEndScale;
var bool bUsingSword;
var float fSwordFXTime;
var float fSwordFXTimeSpan;
var float fSwordLength;
var float fSwordFXStartScale;
var float fSwordFXEndScale;
var ParticleFX fxSwordParticles;
var bool bGlowingWand;
var bool bUseDebugMode;
var harry PlayerHarry;

function SetDebugMode (bool bOn)
{
  bUseDebugMode = bOn;
}

simulated function PostBeginPlay()
{
  Super.PostBeginPlay();
  PlayerHarry = harry(Level.PlayerHarryActor);
  TheLumosLight = Spawn(Class'LumosLight',self,,Location);
  if ( TheLumosLight == None )
  {
    PlayerHarry.ClientMessage("ERROR!!! LumosLight could not be spawned!!!!!");
  }
}

function PreBeginPlay()
{
  fxSwordParticles = Spawn(Class'SwordBlade2FX');
  fxSwordParticles.EnableEmission(False);
}

event Destroyed()
{
  if ( fxChargeParticles != None )
  {
    fxChargeParticles.Destroy();
  }
  if ( fxSwordParticles != None )
  {
    fxSwordParticles.Destroy();
  }
  if ( TheLumosLight != None )
  {
    TheLumosLight.Destroy();
  }
  Super.Destroyed();
}

function float ChargingLevel()
{
  if ( bUsingSword )
  {
    if ( fxSwordParticles.bEmit )
    {
      return fSwordFXTime / fSwordFXTimeSpan;
    } else {
      return 0.0;
    }
  } else {
    return fSpellCharge;
  }
}

function StartGlowingWand (Class<baseSpell> GlowSpellClass)
{
  if ( fxChargeParticles != None )
  {
    fxChargeParticles.Destroy();
  }
  fxChargeParticles = Spawn(GetChargeParticleClass(GlowSpellClass));
  fxChargeParticles.bEmit = True;
  bGlowingWand = True;
}

function StopGlowingWand()
{
  bGlowingWand = False;
  if ( fxChargeParticles != None )
  {
    fxChargeParticles.Destroy();
  }
}

function StartChargingSpell (bool bChargeSpell, optional bool in_bHarryUsingSword, optional Class<baseSpell> ChargeSpellClass)
{
  bSpellCharges = bChargeSpell;
  if ( in_bHarryUsingSword )
  {
    fxSwordParticles.EnableEmission(True);
  } else {
    if ( fxChargeParticles != None )
    {
      fxChargeParticles.Destroy();
    }
    if ( ChargeSpellClass != None )
    {
      fxChargeParticles = Spawn(GetChargeParticleClass(ChargeSpellClass));
    } else {
      fxChargeParticles = Spawn(Default.fxChargeParticleFXClass);
      fxChargeParticles.SizeWidth.Base = 8.0;
      fxChargeParticles.SizeLength.Base = 8.0;
    }
    fxChargeParticles.EnableEmission(True);
  }
  fSpellChargeTime = 0.0;
  fSpellCharge = 0.0;
  fSwordFXTime = 0.0;
}

function StopChargingSpell()
{
  bSpellCharges = False;
  fSpellChargeTime = 0.0;
  fSpellCharge = 0.0;
  if ( bGlowingWand )
  {
    ScaleParticles(fxChargeParticles,1.0);
  } else {
    fxChargeParticles.Shutdown();
  }
  fxSwordParticles.EnableEmission(False);
}

function Class<ParticleFX> GetChargeParticleClass (Class<baseSpell> spellClass)
{
  switch (spellClass)
  {
    case Class'spellFlipendo':
    return Class'Flip_fly';
    case Class'spellLumos':
    return Class'Lumos_fly';
    case Class'spellAlohomora':
    return Class'Aloh_Fly';
    case Class'spellSkurge':
    return Class'Skurge_fly';
    case Class'spellRictusempra':
    return Class'Rictusempra_fly';
    case Class'spellDiffindo':
    return Class'Diffindo_Fly';
    case Class'spellSpongify':
    return Class'Spongify_Fly';
    case Class'spellDuelRictusempra':
    return Class'duelRictusempra_fly';
    case Class'spellDuelMimblewimble':
    return Class'duelMimblewimble_fly';
    case Class'spellDuelExpelliarmus':
    return Class'duelExpelliarmus_fly';
    default: break;
  }
  // goto JL0099;
  return Class'Flip_fly';
}

function Class<baseSpell> GetClassFromSpellName (string SpellName)
{
  switch (SpellName)
  {
    case "Flipendo":
    return Class'spellFlipendo';
    case "Lumos":
    return Class'spellLumos';
    case "Alohomora":
    return Class'spellAlohomora';
    case "Skurge":
    return Class'spellSkurge';
    case "Rictusempra":
    return Class'spellRictusempra';
    case "Diffindo":
    return Class'spellDiffindo';
    case "Spongify":
    return Class'spellSpongify';
    case "DuelRictusempra":
    return Class'spellDuelRictusempra';
    case "DuelMimblewimble":
    return Class'spellDuelMimblewimble';
    case "DuelExpelliarmus":
    return Class'spellDuelExpelliarmus';
    default:
  }
  return None;
}

function Class<baseSpell> GetClassFromSpellType (ESpellType ESpellType)
{
  switch (ESpellType)
  {
  /*
    case 13:
    return Class'spellFlipendo';
    case 4:
    return Class'spellLumos';
    case 1:
    return Class'spellAlohomora';
    case 20:
    return Class'spellSkurge';
    case 22:
    return Class'spellRictusempra';
    case 19:
    return Class'spellDiffindo';
    case 21:
    return Class'spellSpongify';
    case 25:
    return Class'spellDuelRictusempra';
    case 26:
    return Class'spellDuelMimblewimble';
    case 27:
    return Class'spellDuelExpelliarmus';
    default:
  */
  
    case SPELL_Flipendo:		return class'spellFlipendo';
	case SPELL_Lumos:			return class'spelllumos';
	case SPELL_Alohomora:		return class'spellAlohomora';
	case SPELL_Skurge:			return class'spellSkurge';
	case SPELL_Rictusempra:		return class'spellRictusempra';
	case SPELL_Diffindo:		return class'spellDiffindo';
	case SPELL_Spongify:		return class'spellSpongify';

	case SPELL_DuelRictusempra:	return class'spellDuelRictusempra';
	case SPELL_DuelMimblewimble:return class'spellDuelMimblewimble';
	case SPELL_DuelExpelliarmus:return class'spellDuelExpelliarmus';
  }
  return None;
}

function SetCurrentSpell (Class<baseSpell> spellClass, optional bool bForceSelection)
{
  if ( Owner.IsA('harry') )
  {
    if ( harry(Owner).IsInSpellBook(spellClass.Default.SpellType) || bForceSelection )
    {
      CurrentSpell = spellClass;
    } else {
      if ( bUseDebugMode )
      {
        PlayerHarry.ClientMessage("HARRY CAN NOT USE THIS SPELL YET!!!! -> " $ string(spellClass));
      }
    }
  } else {
    CurrentSpell = spellClass;
  }
}

function ChooseSpell (ESpellType ESpellType, optional bool bForceSelection)
{
  SetCurrentSpell(GetClassFromSpellType(ESpellType),bForceSelection);
}

function float GetChargeParticleFXScale (float fCharge)
{
  if ( fCharge > 1.0 )
  {
    return fSpellChargeEndScale + fCharge;
  } else {
    return fSpellChargeStartScale + (fSpellChargeEndScale - fSpellChargeStartScale) * fCharge;
  }
}

function SetInstantFire (bool in_bInstantFire)
{
  bInstantFire = in_bInstantFire;
}

function ToggleUseSword()
{
  bUsingSword =  !bUsingSword;
  fxChargeParticles.EnableEmission(False);
  fxSwordParticles.EnableEmission(False);
  if ( bUsingSword )
  {
    Mesh = SkeletalMesh'skGryf_SwordMesh';
  } else {
    Mesh = SkeletalMesh'WandMesh';
  }
  ThirdPersonMesh = Mesh;
}

function Vector GetWandEndPoint()
{
  return Pawn(Owner).WeaponLoc - (Vec(0.0,0.0,20.0) >> Pawn(Owner).WeaponRot);
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

event Tick (float fTimeDelta)
{
  local Vector WandEndPoint;
  //local float Scale;
  local float fScale;

  Super.Tick(fTimeDelta);
  if ( (Pawn(Owner) != None) && (Pawn(Owner).Weapon == self) )
  {
    if ( bUsingSword )
    {
      if ( fxSwordParticles.bEmit )
      {
        fSwordFXTime += fTimeDelta;
      }
      fSwordFXTime = FMin(fSwordFXTime,fSwordFXTimeSpan);
      if ( (fSwordFXTime >= 1.89999998) && (fSwordFXTime - fTimeDelta < 1.89999998) )
      {
        PlaySound(Sound'sword_loop',SLOT_Interact);
      }
      fScale = fSwordFXTime / fSwordFXTimeSpan;
      WandEndPoint = Pawn(Owner).WeaponLoc - (Vec(0.0,0.0,fSwordLength * fScale) >> Pawn(Owner).WeaponRot);
      fxSwordParticles.SetLocation(WandEndPoint);
      ScaleParticles(fxSwordParticles,fSwordFXStartScale + (fSwordFXEndScale - fSwordFXStartScale) * fScale);
    } else //{
      if ( fxChargeParticles.bEmit || TheLumosLight.bLumosOn )
      {
        if ( bSpellCharges && (fSpellCharge < 1.0) )
        {
          fSpellChargeTime = FMin(fSpellChargeTime + fTimeDelta,fSpellChargeTimeSpan);
          fSpellCharge = FMin(1.0,fSpellChargeTime / fSpellChargeTimeSpan);
          ScaleParticles(fxChargeParticles,GetChargeParticleFXScale(fSpellCharge));
        }
        WandEndPoint = GetWandEndPoint();
        if ( fxChargeParticles != None )
        {
          fxChargeParticles.SetLocation(WandEndPoint);
        }
      }
    //}
  }
  if ( TheLumosLight.bLumosOn )
  {
    TheLumosLight.UpdateLocation(WandEndPoint);
  }
}

function ShowCastedSpellList (optional int iNumSpells)
{
  local int I;

  if ( (iNumSpells == 0) || (iNumSpells > 8) )
  {
    iNumSpells = 8;
  }
  PlayerHarry.ClientMessage("***Number of Casted Spells: " $ string(NumCastedSpells));

  for ( I= 0; I < iNumSpells; ++I )
  {
    PlayerHarry.ClientMessage(" spell[" $ string(I) $ "] = " $ string(CastedSpellList[I]));
  }
}

function AddToCastedSpellList (baseSpell spell)
{
  if ( spell == None )
  {
    return;
  }
  CastedSpellList[NumCastedSpells] = spell;
  LastCastedSpell = spell;
  NumCastedSpells++;
  if ( NumCastedSpells > 8 - 1 )
  {
    NumCastedSpells = 8 - 1;
    PlayerHarry.ClientMessage("!!!MAX NUMBER OF CASTED SPELLS REACHED for " $ string(self.Owner) $ " !!!!!!");
  }
}

function SubtractFromCastedSpellList (baseSpell spell)
{
  local int I;
  //local int Index;
  local int iIndex;
  local bool bFound;

  for ( I=0; I < NumCastedSpells; ++I )
  {
    if ( CastedSpellList[I] == spell )
    {
      bFound = True;
      iIndex = I;
      CastedSpellList[I] = None;
      NumCastedSpells--;
	  break;
    }
  }
  if ( bFound )
  {
    for ( I=iIndex; I < 8 - 1; ++I )
    {
      CastedSpellList[I] = CastedSpellList[I + 1];
    }
  } else {
    PlayerHarry.ClientMessage("baseWand: Could not find spell: " $ string(spell) $ " to subtract from list!!!");
  }
}

function FlashChargeParticles (Class<ParticleFX> classFX)
{
  fxChargeParticles.Destroy();
  fxChargeParticles = Spawn(classFX);
}

function CastSpell (optional Actor aTarget, optional Vector aTargetOffset, optional Class<baseSpell> spellClass)
{
  local bool bUseWeaponForProjRot;

  if ( aTarget == self )
  {
    bUseWeaponForProjRot = True;
    aTarget = None;
  }
  if ( spellClass != None )
  {
    CurrentSpell = spellClass;
  } else //{
    if ( bAutoSelectSpell && (aTarget != None) )
    {
      ChooseSpell(aTarget.eVulnerableToSpell);
    }
  //}
  if ( bUseDebugMode )
  {
    PlayerHarry.ClientMessage("Casting spell " $ string(CurrentSpell) $ " at " $ string(aTarget));
  }
  if ( CurrentSpell == None )
  {
    return;
  }
  if (  !bUsingSword || bUsingSword && SwordChargedUpEnough() )
  {
    AddToCastedSpellList(baseSpell(ProjectileFire2(CurrentSpell,AltProjectileSpeed,False,bUseWeaponForProjRot,aTarget)));
    LastCastedSpell.bUseDebugMode = bUseDebugMode;
    LastCastedSpell.InitSpell(Owner,aTarget,aTargetOffset,fSpellCharge,self);
    if ( spellSwordFire(LastCastedSpell) != None )
    {
      spellSwordFire(LastCastedSpell).DamagePercent(fSwordFXTime / fSwordFXTimeSpan);
    }
    LastCastedSpell.PlayIncantationSound(Owner);
  }
  StopChargingSpell();
  if ( aTarget.IsA('HPawn') && (VSize(Location - aTarget.Location) < fAutoHitDistance) )
  {
    LastCastedSpell.ProcessTouch(aTarget,aTarget.Location);
    PlayerHarry.cm("Spell AutoHit Target " $ string(aTarget) $ " because TargetDist " $ string(VSize(Location - aTarget.Location)) $ " < " $ string(fAutoHitDistance));
  } else {
    if ( aTarget.IsA('harry') )
    {
      if ( PlayerHarry.Difficulty == DifficultyMedium )
      {
        LastCastedSpell.Speed *= 1.79999995;
      } else //{
        if ( PlayerHarry.Difficulty == DifficultyHard )
        {
          LastCastedSpell.Speed *= 2.5;
        }
      }
    //}
  }
}

function bool SwordChargedUpEnough()
{
  return fSwordFXTime >= fSwordFXTimeSpan / 2;
}

function AltFire (float Value)
{
  if ( PlayerHarry != None )
  {
    PlayerHarry.ClientInstantFlash(-0.41,vect(0.00,0.00,800.00));
    PlayerHarry.ShakeView(ShakeTime,ShakeMag,ShakeVert);
  }
  ProjectileFire2(AltProjectileClass,AltProjectileSpeed,bAltWarnTarget,False,None);
  PlayAnim('All',0.81,0.05);
  if ( Owner.bHidden )
  {
    CheckVisibility();
  }
}

function Projectile ProjectileFire2 (Class<Projectile> ProjClass, float ProjSpeed, bool bWarn, optional bool bUseWeaponForProjRot, optional Actor aTarget)
{
  local Vector vStart;
  local Vector vEnd;
  local float fDistance;
  local Rotator R;
  local Projectile proj;

  Owner.MakeNoise(Pawn(Owner).SoundDampening);
  if ( bUsingSword )
  {
    vStart = Pawn(Owner).WeaponLoc - (Vec(0.0,0.0,fSwordLength * fSwordFXTime / fSwordFXTimeSpan) >> Pawn(Owner).WeaponRot);
    vEnd = harry(Owner).SpellCursor.Location;
    if ( bUseWeaponForProjRot )
    {
      R = Pawn(Owner).WeaponRot;
    } else {
      if ( vEnd == vect(0.00,0.00,0.00) )
      {
        R = harry(Owner).Cam.Rotation;
      } else {
        R = rotator(vEnd - vStart);
      }
    }
    proj = Spawn(ProjClass,Owner,,vStart,R);
  } else {
    vStart = Pawn(Owner).WeaponLoc + (Vec(0.0,0.0,20.0) >> Pawn(Owner).WeaponRot);
    if ( bUseWeaponForProjRot )
    {
      R = Pawn(Owner).WeaponRot;
    } else {
      if ( Owner.IsA('harry') )
      {
        R = harry(Owner).Cam.Rotation;
      } else {
        R = Pawn(Owner).Rotation;
      }
    }
    proj = Spawn(ProjClass,Owner,,vStart,R);
    if ( aTarget.IsA('BossRailMove') )
    {
      baseSpell(proj).SeekSpeed *= 0.25;
    }
    if ( proj == None )
    {
      if ( Pawn(Owner).IsA('PlayerPawn') )
      {
        vStart = PlayerPawn(Owner).Location + Vec(0.0,0.0,PlayerPawn(Owner).EyeHeight);
      } else //{
        if ( Pawn(Owner).IsA('Pawn') )
        {
          vStart = Pawn(Owner).Location;
        }
      //}
      proj = Spawn(ProjClass,Owner,,vStart,R);
    }
  }
  return proj;
}

function bool IsLumosOn()
{
  return PlayerHarry.bLumosOn;
}

function LumosTurnOn()
{
  TheLumosLight.TurnOn();
}

function BecomeItem()
{
  Super.BecomeItem();
  bHidden = False;
}

function Texture GetSpellIcon()
{
  if ( CurrentSpell != None )
  {
    return CurrentSpell.Default.SpellIcon;
  } else {
    return None;
  }
}

function Inventory SpawnCopy (Pawn Other)
{
  local Inventory Copy;
  local Inventory I;

  Copy = Super.SpawnCopy(Other);
  return Copy;
}

function float RateSelf (out int bUseAltMode)
{
  return 99.0;
}

function BecomePickup()
{
  Super.BecomePickup();
}

function Finish()
{
  if ( (Pawn(Owner).bFire != 0) && (FRand() < 0.62) )
  {
    Timer();
  }
  Super.Finish();
}

function PlayFiring()
{
  PlayAnim('All',0.5,0.05);
}

function PlayIdleAnim()
{
}

defaultproperties
{
    bAutoSelectSpell=True

    fAutoHitDistance=128.00

    fxChargeParticleFXClass=Class'HPParticle.Skurge_fly'

    fSpellChargeTimeSpan=1.00

    fSpellChargeStartScale=1.00

    fSpellChargeEndScale=3.00

    fSwordFXTimeSpan=2.00

    fSwordLength=55.00

    fSwordFXStartScale=0.10

    fSwordFXEndScale=6.00

    PickupAmmoCount=200

    bSplashDamage=True

    FireOffset=(X=0.00,Y=-6.00,Z=-7.00)

    AltProjectileClass=Class'baseSpell'

    AimError=0.00

    AltRefireRate=0.70

    DeathMessage="%k inflicted mortal damage upon %o with the %w."

    AutoSwitchPriority=4

    InventoryGroup=4

    PickupMessage="You got the ASMD"

    ItemName="Wand"

    PlayerViewOffset=(X=3.50,Y=-1.80,Z=-2.00)

    ThirdPersonMesh=SkeletalMesh'HPModels.WandMesh'

    Mesh=SkeletalMesh'HPModels.WandMesh'

    bNoSmooth=False

    CollisionRadius=28.00

    CollisionHeight=8.00

    Mass=50.00

}
