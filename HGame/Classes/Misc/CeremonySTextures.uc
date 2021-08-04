//================================================================================
// CeremonySTextures.
//================================================================================

class CeremonySTextures extends Info;

enum EScoreFont {
  ScoreFont_Tiny,
  ScoreFont_Small,
  ScoreFont_Medium,
  ScoreFont_Big
};
var() EScoreFont ScoreFontSize;
var() Color colorScoreFont;
var() int nScoreMidX;
var() int nScoreMidY;
var() Texture stexGryffindor;
var() Texture stexSlytherin;
var() Texture stexHufflepuff;
var() Texture stexRavenclaw;


function Timer()
{
  local harry PlayerHarry;
  local StatusGroupHousePoints sgHousePts;

  PlayerHarry = harry(Level.PlayerHarryActor);
  if ( PlayerHarry != None )
  {
    SetTimer(0.0,False);
    sgHousePts = StatusGroupHousePoints(PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupHousePoints'));
  }
}

function BeginPlay()
{
  if ( (stexGryffindor == None) || (stexSlytherin == None) || (stexHufflepuff == None) || (stexRavenclaw == None) )
  {
    Log("WARNING: One or more CeremonySTexture house textures are none");
  }
  SetSTexturesNotifyActor(self);
  SetTimer(0.1,True);
}

function PostBeginPlay()
{
}

function Destroyed()
{
  SetSTexturesNotifyActor(None);
}

event RenderTexture (ScriptedTexture Tex)
{
  local StatusGroup sgHousePts;
  local Font fontScore;
  local int nPoints;
  local string strPoints;
  local float fScoreXLen;
  local float fScoreYLen;
  local int nScoreXPos;
  local int nScoreYPos;
  local baseConsole ConsoleForFont;

  ConsoleForFont = baseConsole(harry(Level.PlayerHarryActor).Player.Console);
  if ( ConsoleForFont == None )
  {
    Level.PlayerHarryActor.ClientMessage("WARNING: CeremonySTexture could not get font");
  }
  fontScore = ConsoleForFont.IntMedFont;
  sgHousePts = harry(Level.PlayerHarryActor).managerStatus.GetStatusGroup(Class'StatusGroupHousePoints');
  if ( Tex == stexGryffindor )
  {
    nPoints = sgHousePts.GetStatusItem(Class'StatusItemGryffindorPts').nCount;
  } else //{
    if ( Tex == stexSlytherin )
    {
      nPoints = sgHousePts.GetStatusItem(Class'StatusItemSlytherinPts').nCount;
    } else //{
      if ( Tex == stexHufflepuff )
      {
        nPoints = sgHousePts.GetStatusItem(Class'StatusItemHufflePuffPts').nCount;
      } else //{
        if ( Tex == stexRavenclaw )
        {
          nPoints = sgHousePts.GetStatusItem(Class'StatusItemRavenclawPts').nCount;
        } else {
          Level.PlayerHarryActor.ClientMessage("WARNING: Unexpected scripted texture in CeremonySTextures");
        }
      //}
    //}
  //}
  strPoints = string(nPoints);
  Tex.TextSize(strPoints,fScoreXLen,fScoreYLen,fontScore);
  nScoreXPos = nScoreMidX - (fScoreXLen / 2);
  nScoreYPos = nScoreMidY - (fScoreYLen / 2);
  Tex.DrawColoredText(nScoreXPos,nScoreYPos,strPoints,fontScore,colorScoreFont);
}

function SetSTexturesNotifyActor (Actor aSet)
{
  if ( stexGryffindor != None )
  {
    ScriptedTexture(stexGryffindor).NotifyActor = aSet;
  }
  if ( stexSlytherin != None )
  {
    ScriptedTexture(stexSlytherin).NotifyActor = aSet;
  }
  if ( stexHufflepuff != None )
  {
    ScriptedTexture(stexHufflepuff).NotifyActor = aSet;
  }
  if ( stexRavenclaw != None )
  {
    ScriptedTexture(stexRavenclaw).NotifyActor = aSet;
  }
}

function EnsureTexturesInitialized()
{
  SetSTexturesNotifyActor(self);
}

defaultproperties
{
    // ScoreFontSize=2
	ScoreFontSize=ScoreFont_Medium

    nScoreMidX=65

    nScoreMidY=87

    bHidden=False

    bNoDelete=True

    bAlwaysRelevant=True
}
