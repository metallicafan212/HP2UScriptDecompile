//================================================================================
// FawkesToAshes.
//================================================================================

class FawkesToAshes extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=400.00,Rand=0.00)

    SourceWidth=(Base=30.00,Rand=15.00)

    SourceHeight=(Base=10.00,Rand=10.00)

    SourceDepth=(Base=10.00,Rand=10.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    Speed=(Base=100.00,Rand=100.00)

    Lifetime=(Base=2.00,Rand=0.50)

    ColorStart=(Base=(R=255,G=128,B=0,A=0),Rand=(R=128,G=128,B=128,A=0))

    ColorEnd=(Base=(R=0,G=64,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaEnd=(Base=1.00,Rand=0.00)

    SizeWidth=(Base=4.00,Rand=4.00)

    SizeLength=(Base=4.00,Rand=4.00)

    SizeEndScale=(Base=0.10,Rand=0.00)

    SpinRate=(Base=-6.00,Rand=12.00)

    DripTime=(Base=0.10,Rand=0.00)

    Chaos=20.00

    Elasticity=0.10

    Attraction=(X=3.00,Y=3.00,Z=0.00)

    Damping=5.00

    GravityModifier=0.70

    ParticlesMax=200

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Smoke5'

    bDynamicLight=True

    Rotation=(Pitch=16368,Yaw=0,Roll=0)

    bSelected=True
}
