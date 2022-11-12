//================================================================================
// VoldEffectCircling.
//================================================================================

class VoldEffectCircling extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

var() float fRadius;
var() float fRadiusIncSpeed;
var float YawFromOwner;
var() float YawSpeed;
var Vector vStartLoc;
var() float zIncSpeed;
var float Z;

event PostBeginPlay()
{
  vStartLoc = Location;
  Z = Location.Z + FRand() * 40 - 20;
  YawFromOwner = FRand() * 65536;
  YawSpeed *= 0.8 + FRand() * 0.4;
  if ( Rand(2) == 0 )
  {
    YawSpeed =  -YawSpeed;
  }
}

function Tick (float dtime)
{
  local Rotator R;

  YawFromOwner += YawSpeed * dtime;
  fRadius += fRadiusIncSpeed * dtime;
  zIncSpeed += 20 * dtime;
  Z += zIncSpeed * dtime;
  R.Yaw = YawFromOwner;
  SetLocation(vStartLoc + vector(R) * fRadius + Vec(0.0,0.0,Z));
}

defaultproperties
{
    fRadius=30.00

    fRadiusIncSpeed=20.00

    YawSpeed=90000.00

    zIncSpeed=30.00

    ParticlesPerSec=(Base=10.00,Rand=4.00)

    Speed=(Base=30.00,Rand=0.00)

    Lifetime=(Base=0.50,Rand=0.10)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=0,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeEndScale=(Base=0.00,Rand=18.00)

    Chaos=1.00

    Distribution=DIST_Uniform

    Textures(0)=Texture'HPParticle.hp_fx.Particles.flare5'

    LifeSpan=10.00
}
