//================================================================================
// SpellSelector.
//================================================================================

class SpellSelector extends HudItemManager;

const nSPACE_BETWEEN_ICONS= 4;
const nTEXT_OFFSET_Y= 50;
const nTEXT_OFFSET_X= 20;
const nSTART_Y= 175;
const nSTART_X= 2;
const strEXPELLIARMUS_HOTKEY= "3";
const strMIMBLEWIMBLE_HOTKEY= "2";
const strRICTUSEMPRA_HOTKEY= "1";
const strSPELL_EXPELLIARMUS_SEL= "HP2_Menu.Icons.HP2SpellExpelliarmusSelect";
const strSPELL_EXPELLIARMUS= "HP2_Menu.Icons.HP2SpellExpelliarmus";
const strSPELL_MIMBLEWIMBLE_SEL= "HP2_Menu.Icons.HP2SpellMimblewimbleSelect";
const strSPELL_MIMBLEWIMBLE= "HP2_Menu.Icons.HP2SpellMimblewimble";
const strSPELL_RICTUSEMPRA_SEL= "HP2_Menu.Icons.HP2SpellRictusempraSelect";
const strSPELL_RICTUSEMPRA= "HP2_Menu.Icons.HP2SpellRictusempra";

enum ESpellSelection {
  SSelection_Rictusempra,
  SSelection_Mimblewimble,
  SSelection_Expelliarmus
};

var Texture textureSpellRictusempra;
var Texture textureSpellRictusempraSel;
var Texture textureSpellMimblewimble;
var Texture textureSpellMimblewimbleSel;
var Texture textureSpellExpelliarmus;
var Texture textureSpellExpelliarmusSel;
var ESpellSelection CurrSelection;


event PostBeginPlay()
{
  Super.PostBeginPlay();
  textureSpellRictusempra = Texture(DynamicLoadObject(strSPELL_RICTUSEMPRA,Class'Texture'));
  textureSpellRictusempraSel = Texture(DynamicLoadObject(strSPELL_RICTUSEMPRA_SEL,Class'Texture'));
  textureSpellMimblewimble = Texture(DynamicLoadObject(strSPELL_MIMBLEWIMBLE,Class'Texture'));
  textureSpellMimblewimbleSel = Texture(DynamicLoadObject(strSPELL_MIMBLEWIMBLE_SEL,Class'Texture'));
  textureSpellExpelliarmus = Texture(DynamicLoadObject(strSPELL_EXPELLIARMUS,Class'Texture'));
  textureSpellExpelliarmusSel = Texture(DynamicLoadObject(strSPELL_EXPELLIARMUS_SEL,Class'Texture'));
  SetTimer(0.2,True);
}

event Destroyed()
{
  harry(Level.PlayerHarryActor).ClientMessage("spellselector destroyed");
  HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterSpellSelector(None);
  Super.Destroyed();
}

event Timer()
{
  if ( Level.PlayerHarryActor.myHUD != None )
  {
    HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterSpellSelector(self);
    SetTimer(0.0,False);
  }
}

function SetSelection (ESpellSelection SSelection)
{
  CurrSelection = SSelection;
}

function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
  local float fScaleFactor;
  local int nIconX;
  local int nIconY;
  local Texture textureSpellIcon;

  fScaleFactor = GetScaleFactor(Canvas);
  nIconX = nSTART_X * fScaleFactor;
  nIconY = nSTART_Y * fScaleFactor;
  
  if ( CurrSelection == SSelection_Rictusempra )
  {
    textureSpellIcon = textureSpellRictusempraSel;
  } else {
    textureSpellIcon = textureSpellRictusempra;
  }
  DrawSpellIcon(Canvas,fScaleFactor,textureSpellIcon,nIconX,nIconY,strRICTUSEMPRA_HOTKEY);
  nIconY += (textureSpellRictusempra.VSize + nSPACE_BETWEEN_ICONS) * fScaleFactor;
  
  if ( CurrSelection == SSelection_Mimblewimble )
  {
    textureSpellIcon = textureSpellMimblewimbleSel;
  } else {
    textureSpellIcon = textureSpellMimblewimble;
  }
  DrawSpellIcon(Canvas,fScaleFactor,textureSpellIcon,nIconX,nIconY,strMIMBLEWIMBLE_HOTKEY);
  nIconY += (textureSpellMimblewimble.VSize + nSPACE_BETWEEN_ICONS) * fScaleFactor;
  
  if ( CurrSelection == SSelection_Expelliarmus )
  {
    textureSpellIcon = textureSpellExpelliarmusSel;
  } else {
    textureSpellIcon = textureSpellExpelliarmus;
  }
  DrawSpellIcon(Canvas,fScaleFactor,textureSpellIcon,nIconX,nIconY,strEXPELLIARMUS_HOTKEY);
}

function DrawSpellIcon (Canvas Canvas, float fScaleFactor, Texture textureSpellIcon, int nIconX, int nIconY, string strHotKey)
{
  Canvas.SetPos(nIconX,nIconY);
  Canvas.DrawIcon(textureSpellIcon,fScaleFactor);
  DrawHotKeyText(Canvas,nIconX,nIconY,strHotKey);
}

function DrawHotKeyText (Canvas Canvas, int nIconX, int nIconY, string strHotKey)
{
  local float fScaleFactor;
  local Font fontSave;
  local Color colorSave;
  local float fXTextLen;
  local float fYTextLen;
  local int nXOffset;
  local int nYOffset;

  fScaleFactor = GetScaleFactor(Canvas);
  colorSave = Canvas.DrawColor;
  fontSave = Canvas.Font;
  Canvas.DrawColor.R = 206;
  Canvas.DrawColor.G = 200;
  Canvas.DrawColor.B = 190;
  if ( Canvas.SizeX <= 512 )
  {
    Canvas.Font = baseConsole(Level.PlayerHarryActor.Player.Console).LocalTinyFont;
  } else //{
    if ( Canvas.SizeX <= 640 )
    {
      Canvas.Font = baseConsole(Level.PlayerHarryActor.Player.Console).LocalSmallFont;
    } else {
      Canvas.Font = baseConsole(Level.PlayerHarryActor.Player.Console).LocalMedFont;
    }
  //}
  Canvas.TextSize(strHotKey,fXTextLen,fYTextLen);
  nXOffset = (nTEXT_OFFSET_X * fScaleFactor) - fXTextLen / 2; 
  nYOffset = (nTEXT_OFFSET_Y * fScaleFactor) - fXTextLen / 2;
  Canvas.SetPos(nIconX + nXOffset, nIconY + nYOffset);
  Canvas.DrawText(strHotKey, false);
  Canvas.DrawColor = colorSave;
  Canvas.Font = fontSave;
}

defaultproperties
{
    bHidden=True

    // DrawType=1
	DrawType=DT_Sprite
}
