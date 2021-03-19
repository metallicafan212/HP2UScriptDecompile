//================================================================================
// Cauldron_Mixed.
//================================================================================

class Cauldron_Mixed extends CauldronFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=75.00,Rand=35.00)

    SourceWidth=(Base=30.00,Rand=0.00)

    SourceHeight=(Base=30.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=35.00,Rand=25.00)

    Lifetime=(Base=3.00,Rand=2.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=6.00,Rand=6.00)

    SizeLength=(Base=6.00,Rand=6.00)

    SizeEndScale=(Base=0.00,Rand=5.00)

    SpinRate=(Base=-4.00,Rand=8.00)

    Chaos=5.00

    Attraction=(X=5.00,Y=5.00,Z=0.00)

    Damping=0.75

    ParticlesMax=100

    Textures=FireTexture'HPParticle.hp_fx.Particles.SpinG'

    Rotation=(Pitch=16323,Yaw=0,Roll=0)
}
