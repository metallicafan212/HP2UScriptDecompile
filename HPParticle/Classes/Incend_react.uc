//================================================================================
// Incend_react.
//================================================================================

class Incend_react extends AllSpellCast_FX;

defaultproperties
{
    ParticlesPerSec=(Base=250.00,Rand=50.00)

    SourceWidth=(Base=25.00,Rand=0.00)

    SourceHeight=(Base=25.00,Rand=0.00)

    SourceDepth=(Base=40.00,Rand=0.00)

    AngularSpreadWidth=(Base=30.00,Rand=0.00)

    AngularSpreadHeight=(Base=30.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=10.00)

    Lifetime=(Base=1.75,Rand=0.00)

    ColorStart=(Base=(R=128,G=64,B=64,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=12.00,Rand=0.00)

    SizeLength=(Base=20.00,Rand=0.00)

    SizeEndScale=(Base=5.00,Rand=0.00)

    DripTime=(Base=0.20,Rand=0.00)

    Attraction=(X=0.00,Y=0.00,Z=-5.00)

    Damping=3.50

    Textures=FireTexture'HPParticle.hp_fx.Particles.F_Spark2'

    LastUpdateLocation=(X=-384.65,Y=201.87,Z=15.72)

    LastEmitLocation=(X=-384.65,Y=201.87,Z=15.72)

    LastUpdateRotation=(Pitch=16256,Yaw=-16336,Roll=0)

    EmissionResidue=0.07

    Age=2946.07

    bDynamicLight=True

    Tag=ParticleFX

    Location=(X=-384.65,Y=201.87,Z=15.72)

    Rotation=(Pitch=16256,Yaw=-16336,Roll=0)

    OldLocation=(X=-346.21,Y=443.26,Z=16.44)
}
