//================================================================================
// QuidditchCrowd.
//================================================================================

class QuidditchCrowd extends AmbientSound;

const NUM_AW_SOUNDS= 1;
const NUM_COAX_SOUNDS= 1;
const NUM_BOO_LONG_SOUNDS= 1;
const NUM_BOO_SOUNDS= 5;
const NUM_CHEER_LONG_SOUNDS= 2;
const NUM_CHEER_SOUNDS= 4;
enum CheerType {
  CT_Cheer,
  CT_CheerLong,
  CT_Boo,
  CT_BooLong,
  CT_Coax,
  CT_Aw
};

enum HouseAffiliation {
  HA_Gryffindor,
  HA_Ravenclaw,
  HA_Hufflepuff,
  HA_Slytherin,
  HA_Neutral
};
var(Crowd) HouseAffiliation Affiliation;
var(Sound) byte CheerVolume;
var(Sound) byte CheerPitch;
var(Sound) byte CheerRadius;
var QuidditchCrowd NextCrowd;
var QuidditchCrowd NextSpeakingCrowd;
var Sound CheerSounds[4];
var Sound CheerLongSounds[2];
var Sound BooSounds[5];
var Sound BooLongSounds[2];
var Sound CoaxSounds[2];
var Sound AwSounds[2];


function PreBeginPlay()
{
  Super.PreBeginPlay();
}

function Cheer (CheerType eCheerType)
{
  local Sound CheerSound;
  local float fPitch;
  local float fRadius;

  switch (eCheerType)
  {
    // case 0:
	case CT_Cheer:
    CheerSound = CheerSounds[Rand(4)];
    break;
    // case 1:
	case CT_CheerLong:
    CheerSound = CheerLongSounds[Rand(2)];
    break;
    // case 2:
	case CT_Boo:
    CheerSound = BooSounds[Rand(5)];
    break;
    // case 3:
	case CT_BooLong:
    CheerSound = BooLongSounds[Rand(1)];
    break;
    // case 4:
	case CT_Coax:
    CheerSound = CoaxSounds[Rand(1)];
    break;
    // case 5:
	case CT_Aw:
    CheerSound = AwSounds[Rand(1)];
    break;
    default:
  }
  if ( CheerPitch == 64 )
  {
    fPitch = SoundPitch / 64.0;
  } else {
    fPitch = CheerPitch / 64.0;
  }
  switch (eCheerType)
  {
    // case 0:
	case CT_Cheer:
    // case 2:
	case CT_Boo:
    // case 4:
	case CT_Coax:
		fRadius = CheerRadius * 3.0;
		break;
    // case 1:
	case CT_CheerLong:
    // case 3:
	case CT_BooLong:
		fRadius = CheerRadius * 10.0;
		break;
    // case 5:
	case CT_Aw:
		fRadius = CheerRadius * 7.0;
		break;
	default:
		break;
  }
  PlaySound(CheerSound,SLOT_Misc,CheerVolume / 255.0,,fRadius,fPitch);
  if ( NextCrowd != None )
  {
    NextCrowd.Cheer(eCheerType);
  }
}

defaultproperties
{
    // Affiliation=4
	Affiliation=HA_Neutral

    CheerVolume=160

    CheerPitch=64

    CheerRadius=255

    CheerSounds(0)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Big_cheer_01'

    CheerSounds(1)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Big_cheer_02'

    CheerSounds(2)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Crowd_roar_01'

    CheerSounds(3)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Bigcheer_short_01'

    CheerLongSounds(0)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Bigcheer_long_01'

    CheerLongSounds(1)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Bigcheers_0001'

    BooSounds(0)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Boo_01'

    BooSounds(1)=Sound'HPSounds.Quidditch_sfx.SS_QUID_boo_long_02'

    BooSounds(2)=Sound'HPSounds.Quidditch_sfx.SS_QUID_boo_short_01'

    BooLongSounds(0)=Sound'HPSounds.Quidditch_sfx.SS_QUID_boo_long_01'

    CoaxSounds(0)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Crowd_yeah_lp_01'

    AwSounds(0)=Sound'HPSounds.Quidditch_sfx.SS_QUID_Crowd_Aah_02'

    AmbientSound=Sound'HPSounds.Quidditch_sfx.AMB_crowd_loop1'

    SoundRadius=255

    SoundVolume=128
}
