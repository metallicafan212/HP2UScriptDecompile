//================================================================================
// Repairo_fly.
//================================================================================

class Repairo_fly extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=200.00,Rand=0.00)

    SourceWidth=(Base=3.00,Rand=0.00)

    SourceHeight=(Base=3.00,Rand=0.00)

    AngularSpreadWidth=(Base=45.00,Rand=10.00)

    AngularSpreadHeight=(Base=45.00,Rand=10.00)

    bSteadyState=True

    Speed=(Base=20.00,Rand=0.00)

    Lifetime=(Base=0.75,Rand=0.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=8.00,Rand=2.00)

    SizeLength=(Base=8.00,Rand=2.00)

    SizeEndScale=(Base=0.25,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=3.00)

    SizeDelay=0.25

    Damping=5.00

    Gravity=(X=0.00,Y=0.00,Z=-100.00)

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_3'

    LastUpdateLocation=(X=-383.86,Y=-178.58,Z=65.73)

    LastEmitLocation=(X=-383.86,Y=-178.58,Z=65.73)

    LastUpdateRotation=(Pitch=16144,Yaw=-16336,Roll=0)

    EmissionResidue=0.81

    Age=13676.87

    Tag=ParticleFX

    Location=(X=-383.86,Y=-178.58,Z=65.73)

    Rotation=(Pitch=16144,Yaw=-16336,Roll=0)

    OldLocation=(X=1.13,Y=115.53,Z=68.57)
}
