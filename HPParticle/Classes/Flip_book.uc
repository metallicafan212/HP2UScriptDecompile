//================================================================================
// Flip_book.
//================================================================================

class Flip_book extends AllSpellCast_FX;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
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

    Textures(0)=Texture'HPParticle.hp_fx.Particles.Sparkle_3'

    LastUpdateLocation=(X=-383.76,Y=387.41,Z=16.40)

    LastEmitLocation=(X=-383.76,Y=387.41,Z=16.40)

    LastUpdateRotation=(Pitch=16208,Yaw=-16336,Roll=0)

    EmissionResidue=0.48

    Age=1072.90

    Tag=ParticleFX

    Location=(X=-383.76,Y=387.41,Z=16.40)

    Rotation=(Pitch=16208,Yaw=-16336,Roll=0)

    OldLocation=(X=-353.77,Y=311.15,Z=16.40)

    bSelected=True
}
