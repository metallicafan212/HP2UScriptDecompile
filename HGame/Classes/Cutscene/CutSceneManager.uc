//================================================================================
// CutSceneManager.
//================================================================================
// Omega: Black bars use DeltaTime now

class CutSceneManager extends HudItemManager;

const SLIDE_DIVISOR= 15;
var Texture textureBorder;
var float fCurrBorderHeight;

// Omega: max border height
var float fMaxBorderHeight;

var float fBorderMoveTime;

var bool bResetBorderHeightToMax;
var string strText;
var string strCutCommentText;
var bool bBothBordersActive;
var bool bPopupBorderActive;
var Color colorCutTextBlue;
var bool bShowFF;
var Texture textureFFIcons[3];
var int curFFIcon;

function StartCutScene ()
{
	if (  !IsInState('SlideIn') &&  !IsInState('Hold') )
	{
		GotoState('SlideIn');
	}
}

function EndCutScene ()
{
	//cm(Self$ ".EndCutScene() called");
	strCutCommentText = "";
	if (  !IsInState('SlideOut') &&  !IsInState('Idle') )
	{
		GotoState('SlideOut');
	}
}

function SetText (string strSetText, float fSetTextDuration)
{
	SetTimer(0.0,False);
	strText = strSetText;
	if ( fSetTextDuration > 0 )
	{
		SetTimer(fSetTextDuration,False);
	}
	StartCutScene();
}

function ClearText ()
{
	strText = "";
	strCutCommentText = "";
	if (  !Level.PlayerHarryActor.bIsCaptured )
	{
		EndCutScene();
	}
}

function SetCutCommentText (string strText)
{
  	strCutCommentText = strText;
}

event Timer ()
{
	strText = "";
	if (  !Level.PlayerHarryActor.bIsCaptured )
	{
		EndCutScene();
	}
}

function DrawBorder (Canvas Canvas)
{
	if ( Level.PlayerHarryActor.bIsCaptured )
	{
		Canvas.SetPos(0.0,0.0);
		// Metallicafan212:	Fuck it, prevent AA issues
		Canvas.DrawTile(textureBorder, Canvas.SizeX + 1, fCurrBorderHeight, 0.0, 0.0, textureBorder.USize, textureBorder.VSize);
	}
	Canvas.SetPos(0.0, Canvas.SizeY - fCurrBorderHeight);
	// Metallicafan212:	Same here
	Canvas.DrawTile(textureBorder, Canvas.SizeX + 1, fCurrBorderHeight + 1, 0.0, 0.0, textureBorder.USize, textureBorder.VSize);
}

function SetCurrBorderHeight (Canvas Canvas)
{
}

function float GetMaxBorderHeight (Canvas Canvas)
{
  	return GetMaxBorderHeightFromCanvasHeight(Canvas.SizeY);
}

function float GetMaxBorderHeightFromCanvasHeight (int nCanvasSizeY)
{
  	return nCanvasSizeY / 8.0;
}

function DrawText (Canvas Canvas)
{
	HPHud(Level.PlayerHarryActor.myHUD).DrawCutStyleText(Canvas,strText,0,Canvas.SizeY - fCurrBorderHeight + 1,GetMaxBorderHeight(Canvas),colorCutTextBlue);
	if ( strCutCommentText != "" )
	{
		HPHud(Level.PlayerHarryActor.myHUD).DrawCutStyleText(Canvas,strCutCommentText,0,5,GetMaxBorderHeight(Canvas),colorCutTextBlue);
	}
	if ( bShowFF )
	{
		if ( textureFFIcons[0] == None )
		{
			textureFFIcons[0] = Texture(DynamicLoadObject("HP2_Menu.Icons.FF1",Class'Texture'));
			textureFFIcons[1] = Texture(DynamicLoadObject("HP2_Menu.Icons.FF2",Class'Texture'));
			textureFFIcons[2] = Texture(DynamicLoadObject("HP2_Menu.Icons.FF3",Class'Texture'));
		}
		//from UEExplorer because UTPT didn't decompile it -AdamJD
		Canvas.SetPos(Canvas.SizeX / 2 - (textureFFIcons[curFFIcon % 3].USize) / 2, Canvas.SizeY / 2 - (textureFFIcons[curFFIcon % 3].VSize) / 2);
		Canvas.DrawIcon(textureFFIcons[curFFIcon / 10 % 3], 1.0);
		++curFFIcon;
	}
}

auto state Idle
{
}

state SlideIn
{
	function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		fMaxBorderHeight = GetMaxBorderHeight(Canvas);
		//SetCurrBorderHeight(Canvas);
		
		DrawBorder(Canvas);
		DrawText(Canvas);
		if ( fCurrBorderHeight >= GetMaxBorderHeight(Canvas) )
		{
			GotoState('Hold');
		}
	}
	
	/*function SetCurrBorderHeight (Canvas Canvas)
	{
		//local float fMaxBorderHeight;
	
		fMaxBorderHeight = GetMaxBorderHeight(Canvas);
		if ( fCurrBorderHeight < fMaxBorderHeight )
		{
			fCurrBorderHeight += fMaxBorderHeight / 15;
		}
		if ( fCurrBorderHeight > fMaxBorderHeight )
		{
			fCurrBorderHeight = fMaxBorderHeight;
		}
	}*/

	// Omega: Untie this shit from framerate
	event Tick(float DeltaTime)
	{
		//fMaxBorderHeight = GetMaxBorderHeight(Canvas);
		if ( fCurrBorderHeight < fMaxBorderHeight )
		{
			fCurrBorderHeight += (fMaxBorderHeight) * (DeltaTime / fBorderMoveTime);
		}
		if ( fCurrBorderHeight > fMaxBorderHeight )
		{
			fCurrBorderHeight = fMaxBorderHeight;
		}
	}
	
	function BeginState ()
	{
		if ( Level.PlayerHarryActor.bIsCaptured )
		{
			bBothBordersActive = True;
		} 
		else 
		{
			bPopupBorderActive = True;
		}
		fCurrBorderHeight = 0.0;
	}
}

state Hold
{
	function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		DrawBorder(Canvas);
		DrawText(Canvas);
	}
}

state SlideOut
{
	function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		fMaxBorderHeight = GetMaxBorderHeight(Canvas);
		if ( bResetBorderHeightToMax == True )
		{
			fCurrBorderHeight = GetMaxBorderHeight(Canvas);
			bResetBorderHeightToMax = False;
		}
		//SetCurrBorderHeight(Canvas);
		DrawBorder(Canvas);
		if ( fCurrBorderHeight <= 0 )
		{
			bBothBordersActive = False;
			bPopupBorderActive = False;
			GotoState('Idle');
		}
	}
	
	/*function SetCurrBorderHeight (Canvas Canvas)
	{
		if ( fCurrBorderHeight > 0 )
		{
			fCurrBorderHeight -= GetMaxBorderHeight(Canvas) / 15;
		}
		if ( fCurrBorderHeight < 0 )
		{
			fCurrBorderHeight = 0.0;
		}
	}*/

	event Tick(float DeltaTime)
	{
		if ( fCurrBorderHeight > 0 )
		{
			fCurrBorderHeight -= (fMaxBorderHeight) * (DeltaTime / fBorderMoveTime);
		}
		if ( fCurrBorderHeight < 0 )
		{
			fCurrBorderHeight = 0.0;
		}
	}
	
	function BeginState ()
	{
		bResetBorderHeightToMax = True;
	}
}

defaultproperties
{
    textureBorder=Texture'HGame.Icons.leftPanel'

    colorCutTextBlue=(R=127,G=127,B=255,A=0)

	// Omega: Now this is kind of subjective since it was previously framerate based, but this feels the best combination
	// of smooth and quick
	fBorderMoveTime=0.25

	// Omega: Just in case it's initialized to 0 and it's attempted to be used. Seems to work fine either way
	// but I didn't want to put in the work to verify if it *might* be 0 at any time it's attempted to be used
	fMaxBorderHeight=134.875
}
