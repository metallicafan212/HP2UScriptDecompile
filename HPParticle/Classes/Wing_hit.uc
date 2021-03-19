//================================================================================
// Wing_hit.
//================================================================================

class Wing_hit extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=300.00,Rand=0.00)

    SourceWidth=(Base=0.00,Rand=0.00)

    SourceHeight=(Base=0.00,Rand=0.00)

    AngularSpreadWidth=(Base=180.00,Rand=0.00)

    AngularSpreadHeight=(Base=180.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=200.00,Rand=0.00)

    Lifetime=(Base=1.00,Rand=2.00)

    ColorStart=(Base=(R=255,G=255,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=4.00,Rand=6.00)

    SizeLength=(Base=4.00,Rand=6.00)

    SizeEndScale=(Base=5.00,Rand=0.00)

    SpinRate=(Base=-3.00,Rand=6.00)

    Chaos=1.00

    Attraction=(X=-1.00,Y=-1.00,Z=0.00)

    Damping=3.00

    GravityModifier=-0.10

    ParticlesMax=60

    Textures=Texture'HPParticle.hp_fx.Particles.White_Feather'

    Rotation=(Pitch=0,Yaw=0,Roll=0)
}
