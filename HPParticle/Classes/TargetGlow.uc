//================================================================================
// TargetGlow.
//================================================================================

class TargetGlow extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

var int RComp;
var int GComp;
var int BComp;

function SetTargetLock (float TargetWidth, float TargetHeight, float TargetDepth)
{
  ParticlesPerSec.Base = 10.0;
  SourceWidth.Base = TargetWidth;
  SourceHeight.Base = TargetHeight;
  SourceDepth.Base = TargetDepth;
  AngularSpreadWidth.Base = 2.0;
  AngularSpreadHeight.Base = 2.0;
  Speed.Base = 2.0;
  Lifetime.Base = 2.0;
  SizeWidth.Base = 2.0;
  SizeWidth.Rand = 10.0;
  SizeLength.Base = 2.0;
  SizeLength.Rand = 10.0;
  SizeEndScale.Base = -0.5;
  SpinRate.Base = 0.5;
  SpinRate.Rand = 10.0;
  Attraction.X = 10.0;
  Attraction.Y = 10.0;
  ParticlesAlive = 5;
  bRotateToDesired = True;
  SetColour(RComp,GComp,BComp);
}

function SetTargetUnlock()
{
  ParticlesPerSec.Base = 20.0;
  SourceWidth.Base = 10.0;
  SourceHeight.Base = 10.0;
  SourceDepth.Base = 10.0;
  AngularSpreadWidth.Base = 2.0;
  AngularSpreadHeight.Base = 2.0;
  Speed.Base = 5.0;
  Lifetime.Base = 2.0;
  SizeWidth.Base = 2.0;
  SizeWidth.Rand = 10.0;
  SizeLength.Base = 2.0;
  SizeLength.Rand = 10.0;
  SizeEndScale.Base = -0.5;
  SpinRate.Base = 1.0;
  SpinRate.Rand = 20.0;
  Attraction.X = 10.0;
  Attraction.Y = 10.0;
  ParticlesAlive = 10;
  bRotateToDesired = True;
  SetColour(RComp,GComp,BComp);
}

function SetFloatTarget()
{
  SourceWidth.Base = 50.0;
  SourceHeight.Base = 50.0;
  SourceDepth.Base = 50.0;
}

function SetHitTarget()
{
}

function SetColour (int RedComp, int GreenComp, int BlueComp)
{
  RComp = RedComp;
  GComp = GreenComp;
  BComp = BlueComp;
  ColorStart.Base.R = RedComp;
  ColorStart.Base.G = GreenComp;
  ColorStart.Base.B = BlueComp;
  ColorEnd.Base.R = RedComp;
  ColorEnd.Base.G = GreenComp;
  ColorEnd.Base.B = BlueComp;
}

function SetColorEnd (int RedComp, int GreenComp, int BlueComp)
{
  ColorEnd.Base.R = RedComp;
  ColorEnd.Base.G = GreenComp;
  ColorEnd.Base.B = BlueComp;
}

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=0.00)

    SourceWidth=(Base=100.00,Rand=0.00)

    SourceHeight=(Base=100.00,Rand=0.00)

    SourceDepth=(Base=100.00,Rand=0.00)

    AngularSpreadWidth=(Base=2.00,Rand=0.00)

    AngularSpreadHeight=(Base=2.00,Rand=0.00)

    Speed=(Base=5.00,Rand=0.00)

    Lifetime=(Base=2.00,Rand=0.00)

    ColorStart=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=10.00)

    SizeLength=(Base=2.00,Rand=10.00)

    SizeEndScale=(Base=-0.50,Rand=0.00)

    SpinRate=(Base=1.00,Rand=20.00)

    Attraction=(X=10.00,Y=10.00,Z=0.00)

    ParticlesAlive=10

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_1'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
