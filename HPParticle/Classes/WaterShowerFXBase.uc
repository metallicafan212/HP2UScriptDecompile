//================================================================================
// WaterShowerFXBase.
//================================================================================

class WaterShowerFXBase extends ParticleFadeFX;

defaultproperties
{
    ParticlesPerSec=(Base=30.00,Rand=10.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=50.00,Rand=5.00)

    AngularSpreadHeight=(Base=50.00,Rand=5.00)

    bSteadyState=True

    Speed=(Base=50.00,Rand=30.00)

    Lifetime=(Base=1.65,Rand=0.00)

    ColorStart=(Base=(R=1,G=205,B=143,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=23,G=255,B=35,A=0),Rand=(R=159,G=0,B=4,A=0))

    SizeWidth=(Base=8.00,Rand=4.00)

    SizeLength=(Base=2.00,Rand=3.00)

    SizeEndScale=(Base=0.40,Rand=3.00)

    AlphaDelay=1.00

    Attraction=(X=1.00,Y=1.00,Z=0.00)

    Damping=0.30

    GravityModifier=0.25

    Textures=Texture'HPParticle.hp_fx.Particles.Dot_1'

    RenderPrimitive=PPRIM_Liquid

    Rotation=(Pitch=16384,Yaw=0,Roll=0)

    CollisionRadius=60.00

    CollisionHeight=250.00

    bRotateToDesired=True

    DesiredRotation=(Pitch=0,Yaw=0,Roll=0)
}
