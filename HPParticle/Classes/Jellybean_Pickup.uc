//================================================================================
// Jellybean_Pickup.
//================================================================================

class Jellybean_Pickup extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=20.00,Rand=0.00)

    AngularSpreadWidth=(Base=90.00,Rand=0.00)

    AngularSpreadHeight=(Base=90.00,Rand=0.00)

    Speed=(Base=20.00,Rand=15.00)

    Lifetime=(Base=1.50,Rand=0.00)

    ColorStart=(Base=(R=201,G=163,B=222,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeEndScale=(Base=2.00,Rand=0.00)

    SpinRate=(Base=1.00,Rand=20.00)

    SizeDelay=1.00

    Attraction=(X=20.00,Y=20.00,Z=0.00)

    ParticlesMax=50

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_4'
}
