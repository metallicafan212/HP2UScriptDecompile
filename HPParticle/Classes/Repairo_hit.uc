//================================================================================
// Repairo_hit.
//================================================================================

class Repairo_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=80.00,Rand=5.00)

    SourceWidth=(Base=30.00,Rand=0.00)

    SourceHeight=(Base=30.00,Rand=0.00)

    AngularSpreadWidth=(Base=10.00,Rand=2.00)

    AngularSpreadHeight=(Base=10.00,Rand=0.00)

    Lifetime=(Base=3.00,Rand=0.00)

    ColorEnd=(Base=(R=30,G=30,B=30,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=0.00)

    SizeLength=(Base=12.00,Rand=0.00)

    SizeEndScale=(Base=5.00,Rand=0.00)

    SpinRate=(Base=-6.00,Rand=6.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=20.00,Y=20.00,Z=0.00)

    Damping=1.50

    ParticlesMax=80

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_3'

    LastUpdateLocation=(X=-388.11,Y=-1.97,Z=16.40)

    LastEmitLocation=(X=-388.11,Y=-1.97,Z=16.40)

    LastUpdateRotation=(Pitch=16208,Yaw=-16336,Roll=0)

    EmissionResidue=0.00

    Age=1839.10

    Tag=ParticleFX

    Location=(X=-388.11,Y=-1.97,Z=16.40)

    Rotation=(Pitch=16208,Yaw=-16336,Roll=0)

    OldLocation=(X=32.09,Y=293.33,Z=16.94)
}
