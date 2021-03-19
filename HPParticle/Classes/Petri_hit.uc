//================================================================================
// Petri_hit.
//================================================================================

class Petri_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=100.00,Rand=0.00)

    SourceWidth=(Base=75.00,Rand=0.00)

    SourceHeight=(Base=75.00,Rand=0.00)

    SourceDepth=(Base=50.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=1.00,Rand=0.00)

    Lifetime=(Base=1.75,Rand=0.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    AlphaEnd=(Base=0.50,Rand=0.00)

    SizeWidth=(Base=20.00,Rand=0.00)

    SizeLength=(Base=25.00,Rand=0.00)

    SizeEndScale=(Base=0.25,Rand=0.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=5.00,Y=5.00,Z=0.00)

    Damping=3.50

    Gravity=(X=0.00,Y=0.00,Z=100.00)

    ParticlesMax=500

    Textures=Texture'HPParticle.hp_fx.Particles.Sparkle_5'

    EmitDelay=1.00

    LastUpdateLocation=(X=-384.06,Y=0.98,Z=15.72)

    LastEmitLocation=(X=-384.06,Y=0.98,Z=15.72)

    LastUpdateRotation=(Pitch=16256,Yaw=-16336,Roll=0)

    Age=371.51

    bDynamicLight=True

    Tag=ParticleFX

    Location=(X=-384.06,Y=0.98,Z=15.72)

    Rotation=(Pitch=16256,Yaw=-16336,Roll=0)

    OldLocation=(X=-352.65,Y=233.87,Z=15.72)
}
