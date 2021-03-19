//================================================================================
// DeathTorch.
//================================================================================

class DeathTorch extends ParticleFX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    SourceWidth=(Base=2.00,Rand=0.00)

    SourceHeight=(Base=2.00,Rand=0.00)

    SourceDepth=(Base=2.00,Rand=0.00)

    bSteadyState=True

    Speed=(Base=10.00,Rand=10.00)

    Lifetime=(Base=3.00,Rand=3.00)

    ColorStart=(Base=(R=33,G=28,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=121,G=205,B=255,A=0),Rand=(R=0,G=0,B=0,A=0))

    SizeWidth=(Base=8.00,Rand=5.00)

    SizeLength=(Base=8.00,Rand=5.00)

    SpinRate=(Base=-5.00,Rand=10.00)

    ColorDelay=1.00

    Chaos=0.50

    Textures=Texture'HPParticle.hp_fx.Spells.LesBlueFire_01'

    AmbientSound=Sound'HPSounds.Ch2Skurge.blue_death_torch'

    SoundRadius=12

    SoundVolume=220

    SoundPitch=70
}
