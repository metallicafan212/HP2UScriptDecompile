//================================================================================
// Aloh_Book.
//================================================================================

class Aloh_Book extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=30.00)

    SourceWidth=(Base=15.00,Rand=15.00)

    SourceHeight=(Base=15.00,Rand=15.00)

    SourceDepth=(Base=8.00,Rand=15.00)

    AngularSpreadWidth=(Base=5.00,Rand=10.00)

    AngularSpreadHeight=(Base=5.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=5.00,Rand=30.00),

    Lifetime=(Base=1.00,Rand=3.00),

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=253,G=45,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=8.00)

    SizeLength=(Base=2.00,Rand=8.00)

    SizeEndScale=(Base=-1.00,Rand=10.00)

    SpinRate=(Base=-2.00,Rand=4.00)

    SizeDelay=1.00

    Chaos=10.00

    ChaosDelay=2.00

    Attraction=(X=0.00,Y=0.00,Z=2.00)

    GravityModifier=0.00

    Textures=Texture'HPParticle.hp_fx.Particles.Key1'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
