//================================================================================
// Verd_Book.
//================================================================================

class Verd_Book extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=5.00,Rand=20.00)

    SourceWidth=(Base=15.00,Rand=15.00)

    SourceHeight=(Base=15.00,Rand=15.00)

    SourceDepth=(Base=8.00,Rand=15.00)

    AngularSpreadWidth=(Base=5.00,Rand=10.00)

    AngularSpreadHeight=(Base=5.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=30.00)

    Lifetime=(Base=1.00,Rand=3.00)

    ColorStart=(Base=(R=31,G=220,B=31,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=60,G=124,B=29,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=2.00,Rand=0.00)

    SizeLength=(Base=1.00,Rand=10.00)

    SizeEndScale=(Base=-1.00,Rand=10.00)

    SizeDelay=1.00

    Chaos=5.00

    ChaosDelay=0.50

    Attraction=(X=6.00,Y=6.00,Z=2.00)

    Damping=0.25

    Textures=Texture'HPParticle.hp_fx.Particles.Dot_2'

    Rotation=(Pitch=16640,Yaw=0,Roll=0)

    bRotateToDesired=True
}
