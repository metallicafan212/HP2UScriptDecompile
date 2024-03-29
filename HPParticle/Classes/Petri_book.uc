//================================================================================
// Petri_book.
//================================================================================

class Petri_book extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=100.00,Rand=0.00)

    SourceWidth=(Base=50.00,Rand=0.00)

    SourceHeight=(Base=50.00,Rand=0.00)

    SourceDepth=(Base=60.00,Rand=0.00)

    AngularSpreadWidth=(Base=0.00,Rand=0.00)

    AngularSpreadHeight=(Base=0.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=1.00,Rand=0.00)

    Lifetime=(Base=1.75,Rand=0.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=0.00)

    SizeLength=(Base=20.00,Rand=0.00)

    SizeEndScale=(Base=5.00,Rand=0.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=2.00,Y=0.00,Z=0.00)

    Damping=3.50

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_5'

    LastUpdateLocation=(X=-383.46,Y=384.39,Z=15.72)

    LastEmitLocation=(X=-383.46,Y=384.39,Z=15.72)

    LastUpdateRotation=(Pitch=16256,Yaw=-16336,Roll=0)

    EmissionResidue=0.78

    Age=380.67

    bDynamicLight=True

    Tag=ParticleFX

    Location=(X=-383.46,Y=384.39,Z=15.72)

    Rotation=(Pitch=16256,Yaw=-16336,Roll=0)

    OldLocation=(X=-352.06,Y=32.98,Z=15.72)
}
