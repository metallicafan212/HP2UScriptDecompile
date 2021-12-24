//================================================================================
// SpellLessonInterpolationPoint.
//================================================================================

class SpellLessonInterpolationPoint extends InterpolationPoint;

const nIDX_MISS= 2;
const nIDX_HIT= 1;
const nIDX_IDLE= 0;
enum EDirectionArrow {
  Arrow_Up,
  Arrow_Down,
  Arrow_Left,
  Arrow_Right,
  Arrow_None
};
var() EDirectionArrow DirectionArrow[3];
var bool bDeactivated;
var Sound soundHitArrowUp;
var Sound soundHitArrowDown;
var Sound soundHitArrowLeft;
var Sound soundHitArrowRight;
var Sound soundMissed;
var Texture UpTextures[3];
var Texture DownTextures[3];
var Texture LeftTextures[3];
var Texture RightTextures[3];


function PostBeginPlay()
{
  UpTextures[nIDX_IDLE] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_up_idle",Class'Texture'));
  UpTextures[nIDX_HIT] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_up_hit",Class'Texture'));
  UpTextures[nIDX_MISS] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_up_miss",Class'Texture'));
  DownTextures[nIDX_IDLE] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_dn_idle",Class'Texture'));
  DownTextures[nIDX_HIT] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_dn_hit",Class'Texture'));
  DownTextures[nIDX_MISS] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_dn_miss",Class'Texture'));
  LeftTextures[nIDX_IDLE] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_lt_idle",Class'Texture'));
  LeftTextures[nIDX_HIT] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_lt_hit",Class'Texture'));
  LeftTextures[nIDX_MISS] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_lt_miss",Class'Texture'));
  RightTextures[nIDX_IDLE] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_rt_idle",Class'Texture'));
  RightTextures[nIDX_HIT] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_rt_hit",Class'Texture'));
  RightTextures[nIDX_MISS] = Texture(DynamicLoadObject("SpellShapes.Shapes.spar_rt_miss",Class'Texture'));
  // SetArrowTexture(0,0);
  SetArrowTexture(nIDX_IDLE, 0);
}

function OnPlayerHit (int nLevel)
{
  bDeactivated = True;
  // SetArrowTexture(1,nLevel);
  SetArrowTexture(nIDX_Hit, nLevel);
  FancySpawn(Class'SpellLessonHit');
  switch (DirectionArrow[nLevel])
  {
    // case 0:
	case Arrow_Up:
    PlaySound(soundHitArrowUp,,,,10000.0,,True);
    break;
    // case 1:
	case Arrow_Down:
    PlaySound(soundHitArrowDown,,,,10000.0,,True);
    break;
    // case 2:
	case Arrow_Left:
    PlaySound(soundHitArrowLeft,,,,10000.0,,True);
    break;
    // case 3:
	case Arrow_Right:
    PlaySound(soundHitArrowRight,,,,10000.0,,True);
    break;
    default:
    break;
  }
}

function OnPlayerMissed (int nLevel)
{
  bDeactivated = True;
  // SetArrowTexture(2,nLevel);
  SetArrowTexture(nIDX_MISS, nLevel);
  FancySpawn(Class'SpellLessonMiss');
  PlaySound(soundMissed,SLOT_None);
}

function Reset (int nLevel)
{
  local bool bDisplay;

  // SetArrowTexture(0,nLevel);
  SetArrowTexture(nIDX_IDLE, nLevel);
  bDeactivated = False;
  if ( IsInLevel(nLevel) )
  {
    bHidden = False;
  } else {
    bHidden = True;
    bDeactivated = True;
  }
}

function bool IsInLevel (int nLevel)
{
  local bool bRet;

  if ( VerifyLevel(nLevel) )
  {
    // return bool(DirectionArrow[nLevel]) != bool(4);
	return (DirectionArrow[nLevel] != Arrow_None);
  } else {
    return False;
  }
}

function bool VerifyLevel (int nLevel)
{
  if ( (nLevel >= 0) && (nLevel < ArrayCount(DirectionArrow)) )
  {
    return True;
  } else {
    Log("ERROR:  Invalid nLevel passed to IsInLevel " $ string(nLevel));
    return False;
  }
}

function bool IsActive (int nLevel)
{
  if ( VerifyLevel(nLevel) )
  {
    // return (bool(DirectionArrow[nLevel]) != bool(4)) &&  !bDeactivated;
	return (DirectionArrow[nLevel] != Arrow_None &&  !bDeactivated);
  } else {
    return False;
  }
}

function bool IsDirectionArrowUp (int nLevel)
{
  if ( VerifyLevel(nLevel) )
  {
    // return bool(DirectionArrow[nLevel]) == bool(0);
	return (DirectionArrow[nLevel] == Arrow_Up);
  } else {
    return False;
  }
}

function bool IsDirectionArrowDown (int nLevel)
{
  if ( VerifyLevel(nLevel) )
  {
    // return bool(DirectionArrow[nLevel]) == bool(1);
	return (DirectionArrow[nLevel] == Arrow_Down);
  } else {
    return False;
  }
}

function bool IsDirectionArrowLeft (int nLevel)
{
  if ( VerifyLevel(nLevel) )
  {
    // return bool(DirectionArrow[nLevel]) == bool(2);
	return (DirectionArrow[nLevel] == Arrow_Left);
  } else {
    return False;
  }
}

function bool IsDirectionArrowRight (int nLevel)
{
  if ( VerifyLevel(nLevel) )
  {
    // return bool(DirectionArrow[nLevel]) == bool(3);
	return (DirectionArrow[nLevel] == Arrow_Right);
  } else {
    return False;
  }
}

function SetArrowTexture (int nIdx, int nLevel)
{
  if (  !VerifyLevel(nLevel) )
  {
    return;
  }
  if ( (nIdx < 0) || (nIdx >= ArrayCount(UpTextures)) )
  {
    Log("ERROR: Invalid SpellLessonInterpolationPoint texture index " $ string(nIdx));
    return;
  }
  switch (DirectionArrow[nLevel])
  {
    // case 0:
	case Arrow_Up:
    MultiSkins[0] = UpTextures[nIdx];
    break;
    // case 1:
	case Arrow_Down:
    MultiSkins[0] = DownTextures[nIdx];
    break;
    // case 2:
	case Arrow_Left:
    MultiSkins[0] = LeftTextures[nIdx];
    break;
    // case 3:
	case Arrow_Right:
    MultiSkins[0] = RightTextures[nIdx];
    break;
    default:
    break;
  }
}

function Texture GetArrowTexture (int nIdx, int nLevel)
{
  if (  !VerifyLevel(nLevel) )
  {
    return None;
  }
  if ( (nIdx < 0) || (nIdx >= ArrayCount(UpTextures)) )
  {
    Log("ERROR: Invalid SpellLessonInterpolationPoint texture index " $ string(nIdx));
    return None;
  }
  switch (DirectionArrow[nLevel])
  {
    // case 0:
	case Arrow_Up:
    return LeftTextures[nIdx];
    // case 1:
	case Arrow_Down:
    return UpTextures[nIdx];
    // case 2:
	case Arrow_Left:
    return LeftTextures[nIdx];
    // case 3:
	case Arrow_Right:
    return RightTextures[nIdx];
    default:
	break;
  }
  // goto JL00CB;
}

defaultproperties
{
    // DirectionArrow(0)=4
	DirectionArrow(0)=Arrow_None

    // DirectionArrow(1)=4
	DirectionArrow(1)=Arrow_None

    // DirectionArrow(2)=4
	DirectionArrow(2)=Arrow_None

    soundHitArrowUp=Sound'HPSounds.Magic_sfx.spell_lesson_HitArrow3'

    soundHitArrowDown=Sound'HPSounds.Magic_sfx.spell_lesson_HitArrow4'

    soundHitArrowLeft=Sound'HPSounds.Magic_sfx.spell_lesson_HitArrow1'

    soundHitArrowRight=Sound'HPSounds.Magic_sfx.spell_lesson_HitArrow2'

    soundMissed=Sound'HPSounds.Magic_sfx.spell_dud'

    bStatic=False

    // DrawType=2
	DrawType=DT_Mesh

    // Style=3
	Style=STY_Translucent

    Mesh=SkeletalMesh'HProps.skSheetTestMesh'

    DrawScale=0.08
}
