//================================================================================
// GoldSparkle01.
//================================================================================

class GoldSparkle01 extends TemplateSparkle01;

//texture package import -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx

defaultproperties
{
    ColorStart=(Base=(R=128,G=128,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    ColorEnd=(Base=(R=128,G=128,B=0,A=0),Rand=(R=0,G=0,B=0,A=0))

    Textures(0)=FireTexture'HPParticle.hp_fx.Spells.GoldSparkle01'
}
