//================================================================================
// Levitate_react.
//================================================================================

class Levitate_react extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=50.00,Rand=0.00)

    SourceWidth=(Base=48.00,Rand=0.00)

    SourceHeight=(Base=48.00,Rand=0.00)

    Decay=(Base=0.00,Rand=1.00)

    AngularSpreadWidth=(Base=0.00,Rand=8.00)

    AngularSpreadHeight=(Base=0.00,Rand=8.00)

    bSteadyState=True

    Speed=(Base=15.00,Rand=25.00)

    Lifetime=(Base=3.00,Rand=2.00)

    ColorStart=(Base=(R=191,G=191,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=138,G=141,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=30.00,Rand=10.00)

    SizeLength=(Base=30.00,Rand=10.00)

    SizeEndScale=(Base=2.00,Rand=0.00)

    SpinRate=(Base=1.00,Rand=5.00)

    DripTime=(Base=1.50,Rand=1.50)

    Textures(0)=FireTexture'HPParticle.hp_fx.Particles.F_spark'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)
}
