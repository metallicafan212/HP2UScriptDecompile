//================================================================================
// BasilEyeGlow.
//================================================================================

class BasilEyeGlow extends ParticleFX;

var float GlowTime;
var float GlowTimeSpan;

function Trigger (Actor Other, Pawn EventInstigator)
{
  Glow(1.0);
}

function Glow (float Time)
{
  if ( Time > 0 )
  {
    GlowTimeSpan = Time;
    GlowTime = 0.0;
    GotoState('stateGlow');
  } 
  else 
  {
    EnableEmission(False);
    GotoState('stateIdle');
    return;
  }
}

auto state stateIdle
{
}

state stateGlow
{
  function BeginState ()
  {
    EnableEmission(True);
  }
  
  function Tick (float dtime)
  {
    //local float Scale;
	local float fScale;
  
    GlowTime += dtime;
    if ( GlowTime >= GlowTimeSpan )
    {
      GlowTime = GlowTimeSpan;
    }
    fScale = 1.0 + GlowTime / GlowTimeSpan * 50;
    ParticlesPerSec.Base = Default.ParticlesPerSec.Base * fScale / 10;
    SourceHeight.Base = Default.SourceHeight.Base * fScale / 4;
    SourceWidth.Base = Default.SourceWidth.Base * fScale / 4;
    SourceDepth.Base = Default.SourceDepth.Base * fScale / 4;
    SizeWidth.Base = Default.SizeWidth.Base * fScale;
    SizeLength.Base = Default.SizeLength.Base * fScale;
  }
  
}

defaultproperties
{
    ParticlesPerSec=(Base=25.00,Rand=0.00)

    SourceWidth=(Base=1.00,Rand=0.00)

    SourceHeight=(Base=1.00,Rand=0.00)

    SourceDepth=(Base=1.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=2.00)

    Lifetime=(Base=1.00,Rand=0.50)

    ColorStart=(Base=(R=254,G=254,B=254,A=0),Rand=(R=254,G=254,B=254,A=0))

    ColorEnd=(Base=(R=200,G=200,B=200,A=0),Rand=(R=200,G=200,B=200,A=0))

    SizeWidth=(Base=3.00,Rand=2.00)

    SizeLength=(Base=3.00,Rand=2.00)

    bSystemRelative=True

    Textures=Texture'HPParticle.hp_fx.Particles.flare4'

    bEmit=False
}
