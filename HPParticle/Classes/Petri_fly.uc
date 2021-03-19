//================================================================================
// Petri_fly.
//================================================================================

class Petri_fly extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ParticlesPerSec=(Base=25.00,Rand=0.00)

    SourceWidth=(Base=5.00,Rand=0.00)

    SourceHeight=(Base=5.00,Rand=0.00)

    Period=(Base=5.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=100.00,Rand=0.00)

    Lifetime=(Base=4.00,Rand=0.00)

    ColorStart=(Base=(R=128,G=128,B=128,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=0,G=0,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=15.00,Rand=4.00)

    SizeLength=(Base=15.00,Rand=4.00)

    SizeEndScale=(Base=5.00,Rand=0.00)

    SpinRate=(Base=9.00,Rand=0.00)

    DripTime=(Base=0.25,Rand=0.00)

    Damping=1.00

    Textures=FireTexture'HPParticle.hp_fx.Spells.WIN_P'

    LastUpdateLocation=(X=-383.86,Y=-190.73,Z=65.73)

    LastEmitLocation=(X=-383.86,Y=-190.73,Z=65.73)

    LastUpdateRotation=(Pitch=16144,Yaw=-16336,Roll=0)

    EmissionResidue=0.25

    Age=19861.44

    bDynamicLight=True

    Tag=ParticleFX

    Location=(X=-383.86,Y=-190.73,Z=65.73)

    Rotation=(Pitch=16144,Yaw=-16336,Roll=0)

    OldLocation=(X=1.13,Y=115.53,Z=68.57)
}
