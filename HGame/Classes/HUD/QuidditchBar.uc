//================================================================================
// QuidditchBar.
//================================================================================

//all this is added and edited from UEExplorer because UTPT couldn't decompile this class for some reason -AdamJD

class QuidditchBar extends HudItemManager;

const strBAR_EMPTY = "HP2_Menu.Hud.HP2_QuidBarEmpty";
const strBAR_FULL = "HP2_Menu.Hud.HP2_QuidBarFull";
const strBAR_GOLD = "HP2_Menu.Hud.HP2QuidditchBarGold";
const strBAR_WHITE = "HP2_Menu.Hud.HP2QuidditchBarWhite";
const fBAR_W = 117.0;
const fBAR_H = 20.0;
const fBAR_START_X = 4.0;
const fBAR_START_Y = 52.0;
const fSCREEN_OVER_FROM_RIGHT_X = 132.0;
const fSCREEN_UP_FROM_BOTTOM_Y = 80.0;
var Texture textureBarEmpty;
var Texture textureBarFull;
var Texture textureBarGold;
var Texture textureBarWhite;
var bool bRegisteredWithHud;
var int nPercentFull;
var float fFadeRedTotalSecs;
var float fFadeRedCurrSecs;
var bool bFlashing;
var float fFlashTotalSeconds;
var float fFlashCurrSeconds;

event PostBeginPlay()
{
    Super.PostBeginPlay();
    textureBarEmpty = Texture(DynamicLoadObject("HP2_Menu.Hud.HP2_QuidBarEmpty", class'Texture'));
    textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Hud.HP2_QuidBarFull", class'Texture'));
    textureBarGold = Texture(DynamicLoadObject("HP2_Menu.Hud.HP2QuidditchBarGold", class'Texture'));
    textureBarWhite = Texture(DynamicLoadObject("HP2_Menu.Hud.HP2QuidditchBarWhite", class'Texture'));
}

function Show(bool bShow)
{
    if(bShow)
    {
        GotoState('DisplayQBar');
    }
    else
    {
        GotoState('Idle');
    }
}

function SetFlashing(bool flashing)
{
    bFlashing = flashing;
}

function SetProgress(int nPercentFullIn, optional bool bShowWhite, optional float fFadeRedOutSeconds)
{
    Clamp(nPercentFullIn, 0, 100);
    nPercentFull = nPercentFullIn;
    if(bShowWhite) 
    {
        fFadeRedTotalSecs = fFadeRedOutSeconds;
        fFadeRedCurrSecs = 0.0;
    }
}

event Destroyed()
{
    HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterQuidditchBar(None);
    Super.Destroyed();
}

function Color GetBarDrawColor()
{
    local Color colorRet;
    local float ratio;

    if(fFadeRedTotalSecs == 0)
    {
        colorRet.R = 210;
        colorRet.G = 145;
        colorRet.B = 0;
    }
    else
    {
        ratio = fFadeRedCurrSecs / fFadeRedTotalSecs;
        colorRet.R = 255 - (45 * ratio);
        colorRet.G = 255 - (110 * ratio);
        colorRet.B = 255 - (255 * ratio);
    }
    return colorRet;
}

auto state Idle
{    
}

state DisplayQBar
{
    event Tick(float fDelta)
    {
        if(!bRegisteredWithHud)
        {
            if(Level.PlayerHarryActor.myHUD != None)
            {
                HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterQuidditchBar(self);
                bRegisteredWithHud = true;
            }
        }
		if(fFlashCurrSeconds > 0)
        {
            fFlashCurrSeconds -= fDelta;
        }
        else
        {
            fFlashCurrSeconds = fFlashTotalSeconds;
        }
        if(fFadeRedTotalSecs > 0)
        {
            if(fFadeRedCurrSecs >= fFadeRedTotalSecs)
            {
                fFadeRedCurrSecs = 0.0;
                fFadeRedTotalSecs = 0.0;
            }
            else
            {
                fFadeRedCurrSecs += fDelta;
                fFadeRedCurrSecs = FClamp(fFadeRedCurrSecs, 0.0, fFadeRedTotalSecs);
            }
        }
    }
	
    function RenderHudItemManager(Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
    {
        local float fScaleFactor, fIconX, fIconY, fFullRatio, fSegmentWidth;

        local Color colorSave;
        local bool empty;

        colorSave = Canvas.DrawColor;
        fScaleFactor = GetScaleFactor(Canvas);
        fIconX = Canvas.SizeX - (fScaleFactor * 132.0);
        fIconY = Canvas.SizeY - (fScaleFactor * 80.0);
        Canvas.SetPos(fIconX, fIconY);
		
		empty = !bFlashing || (fFlashCurrSeconds > fFlashTotalSeconds / 2);
        if(empty)
        {
            Canvas.DrawIcon(textureBarEmpty, fScaleFactor);
        }
        else
        {
            Canvas.DrawIcon(textureBarFull, fScaleFactor);
        }
        fFullRatio = float(nPercentFull) / 100.0;
        fFullRatio = FClamp(fFullRatio, 0.0, 1.0);
        Canvas.DrawColor = GetBarDrawColor();
        fSegmentWidth = fFullRatio * 117.0;
        Canvas.SetPos(fIconX + (4.0 * fScaleFactor), fIconY + (52.0 * fScaleFactor));
        if(empty)
        {
            Canvas.DrawTile(textureBarWhite, fSegmentWidth * fScaleFactor, textureBarWhite.VSize * fScaleFactor, 0.0, 0.0, fSegmentWidth, textureBarWhite.VSize);
        }
        Canvas.DrawColor = colorSave;
    }

    event EndState()
    {
        bRegisteredWithHud = false;
        HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterQuidditchBar(None);
    }
}

//managed to get these out of UTPT -AdamJD
defaultproperties
{
    fFlashTotalSeconds=0.20
	
	bHidden=True
	
	// DrawType=1
	DrawType=DT_Sprite
}