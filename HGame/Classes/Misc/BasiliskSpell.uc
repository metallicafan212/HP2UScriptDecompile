//================================================================================
// BasiliskSpell.
//================================================================================

class BasiliskSpell extends HPawn;

//this is an unused basilisk file -AdamJD

const NUM_SPELL_FX= 12;
var bool bActive;
var Vector vMoveDir;
var Vector vStartPos;
var float SpellDamageAmount;
var float SpellInitialDrawScale;
var float SpellEndDrawScale;
var float SpellTravelDistance;
var float SpellStartSpeed;
var float SpellEndSpeed;
var Vector SpellFXOffset[12];
var ParticleFX SpellFX[12];
var int NumSpellFX;
var int Damage;
var float fCollisionSize;

function Init (Vector Dir, float DamageAmount, float InitialDrawScale, float EndDrawScale, float TravelDistance, float StartSpeed, float EndSpeed, int YawOffset)
{
  local Rotator R;

  SpellDamageAmount = DamageAmount;
  SpellInitialDrawScale = InitialDrawScale;
  SpellEndDrawScale = EndDrawScale;
  SpellTravelDistance = TravelDistance;
  SpellStartSpeed = StartSpeed;
  SpellEndSpeed = EndSpeed;
  vStartPos = Location;
  R = rotator(Dir);
  R.Yaw += YawOffset;
  SetRotation(R + rot(-16384,0,0));
  Dir = vector(R);
  vMoveDir = Dir;
  Velocity = vMoveDir * StartSpeed;
  DrawScale = InitialDrawScale;
  LifeSpan = 2.0 * TravelDistance / (StartSpeed + EndSpeed);
  MakeSpellFX(Class'avifors_wand',RandRange(0.75,1.5));
  MakeSpellFX(Class'DeathTorch');
  MakeSpellFX(Class'Aloh_Fly',RandRange(0.151,0.34999999));
  RepositionSpellFXs();
}

function MakeSpellFX (Class<ParticleFX> FX, optional float Scale)
{
  SpellFX[NumSpellFX] = ParticleFX(FancySpawn(FX));
  SpellFX[NumSpellFX].SetRotation(Rotation);
  SpellFXOffset[NumSpellFX] = VRand();
  if ( Scale > 0 )
  {
    SpellFX[NumSpellFX].SourceWidth.Base *= Scale;
    SpellFX[NumSpellFX].SourceWidth.Rand *= Scale;
    SpellFX[NumSpellFX].SourceHeight.Base *= Scale;
    SpellFX[NumSpellFX].SourceHeight.Rand *= Scale;
    SpellFX[NumSpellFX].SourceDepth.Base *= Scale;
    SpellFX[NumSpellFX].SourceDepth.Rand *= Scale;
    SpellFX[NumSpellFX].SizeWidth.Base *= Scale;
    SpellFX[NumSpellFX].SizeWidth.Rand *= Scale;
    SpellFX[NumSpellFX].SizeLength.Base *= Scale;
    SpellFX[NumSpellFX].SizeLength.Rand *= Scale;
  }
  NumSpellFX++;
}

function RepositionSpellFXs()
{
  local int Count;

  // Count = 0;
  // if ( Count < 12 )
  for(Count = 0; Count < 12; Count++)
  {
    if ( SpellFX[Count] == None )
    {
      // goto JL0063;
	  break;
    }
    SpellFX[Count].SetLocation(Location + SpellFXOffset[Count] * fCollisionSize * DrawScale);
    // Count++;
    // goto JL0007;
  }
}

function Tick (float dtime)
{
  local float D;
  local harry H;
  local float d2;

  D = VSize(Location - vStartPos);
  Velocity = vMoveDir * ((SpellEndSpeed - SpellStartSpeed) * D / SpellTravelDistance + SpellStartSpeed);
  DrawScale = (SpellEndDrawScale - SpellInitialDrawScale) * D / SpellTravelDistance + SpellInitialDrawScale;
  if ( bActive )
  {
    H = harry(Level.PlayerHarryActor);
    D = H.CollisionRadius + fCollisionSize * DrawScale;
    if ( VSize(H.Location + Vec(0.0,0.0,H.BaseEyeHeight) - Location) < D )
    {
      harry(Level.PlayerHarryActor).ClientMessage("Collide with basil spell");
      PlayerHarry.TakeDamage(Damage,self,Location,vect(0.00,0.00,0.00),'BasiliskSpell');
    }
  }
  RepositionSpellFXs();
}

function Touch (Actor Other)
{
  if ( Other.IsA('HPawn') || Other.IsA('Projectile') )
  {
    return;
  }
  if ( Other.bBlockActors )
  {
    Destroy();
  }
}

function Bump (Actor Other)
{
  PlayerHarry.ClientMessage("BasilSpell bump:" $ string(Other));
  Touch(Other);
}

event Destroyed()
{
  local int Count;

  Super.Destroyed();
  // Count = 0;
  // if ( Count < 12 )
  for(Count = 0; Count < 12; Count++)
  {
    if ( SpellFX[Count] != None )
    {
      SpellFX[Count].Shutdown();
    }
    // Count++;
    // goto JL000D;
  }
}

defaultproperties
{
    Damage=10

    fCollisionSize=17.00

    // Physics=6
	Physics=PHYS_Projectile

    // Style=3
	Style=STY_Translucent

    Mesh=SkeletalMesh'HProps.skSnakeRayMesh'

    AmbientGlow=200

    bUnlit=True

    MultiSkins(0)=WetTexture'HPParticle.hp_fx.General.SnakeEyesWet'

    CollisionRadius=10.00

    CollisionHeight=10.00

    bBlockActors=False

    bBlockPlayers=False

    bAlignBottom=False

    bRotateToDesired=False
}
