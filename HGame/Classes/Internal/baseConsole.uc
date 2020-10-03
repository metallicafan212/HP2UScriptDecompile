//================================================================================
// baseConsole.
//================================================================================

class baseConsole extends WindowConsole;

struct BackgroundBitmap
{
  var Texture p1;
  var Texture p2;
  var Texture p3;
  var Texture p4;
  var Texture p5;
  var Texture p6;
  var float durration;
};

var BackgroundBitmap LoadingBackground;
var bool bLeftKeyDown;
var bool bRightKeyDown;
var bool bForwardKeyDown;
var bool bBackKeyDown;
var bool bUpKeyDown;
var bool bDownKeyDown;
var bool bRotateLeftKeyDown;
var bool bRotateRightKeyDown;
var bool bRotateUpKeyDown;
var bool bRotateDownKeyDown;
var bool bSpaceReleased;
var bool bSpacePressed;
var globalconfig bool bDebugMode;
var globalconfig bool bUseSystemFonts;
var bool bUseAsianFont;
var bool bUseThaiFont;
var string LanguageCode;
var Font LocalHugeFont;
var Font LocalBigFont;
var Font LocalMedFont;
var Font LocalSmallFont;
var Font LocalIconMessageFont;
var Font LocalTinyFont;
var Font IntMedFont;


function ExitFromGame ()
{
}

function SaveSelectedSlot ()
{
}

function LoadSelectedSlot ()
{
}

function ChangeLevel (string lev, bool flag)
{
}

function ScaleAndDraw (Canvas C, float X, float Y, Texture Tex)
{
  local float FX;
  local float fy;

  if ( Tex == None )
  {
    return;
  }
  FX = C.SizeX / 640.0;
  fy = C.SizeY / 480.0;
  FX = C.SizeX / 640.0;
  fy = C.SizeY / 480.0;
  FX = 1.0;
  fy = 1.0;
  Root.DrawStretchedTexture(C, X * FX, Y * fy, Tex.USize * FX, Tex.VSize * fy, Tex);
}

function PrintActionMessageInUpperLeft (Canvas C, string BigMessage)
{
  local float XL;
  local float YL;

  C.bCenter = False;
  C.StrLen(BigMessage,XL,YL);
  C.SetPos(FrameX / 4 - XL / 2, FrameY / 4.5 - YL / 2);
  C.DrawText(BigMessage,False);
}

function PrintActionMessageInLowerLeft (Canvas C, string BigMessage)
{
  local float XL;
  local float YL;

  C.bCenter = False;
  C.StrLen(BigMessage,XL,YL);
  C.SetPos(FrameX / 10,FrameY - FrameY / 4 - YL / 2);
  C.DrawText(BigMessage,False);
}

function DrawLevelAction (Canvas C)
{
	local string BigMessage;
	local float fTextWidth;
	local float fTextHeight;

	if ( (Viewport.Actor.Level.Pauser != "") && Viewport.Actor.Level.LevelAction == LEVACT_None)
	{
		C.Font = C.MedFont;
		BigMessage = PausedMessage;
		PrintActionMessage(C,BigMessage);
		return;
	}
	if ( Viewport.Actor.Level.LevelAction == LEVACT_None )
	{
		BigMessage = "";
		return;
	} 
	else if(Viewport.Actor.Level.LevelAction == LEVACT_Loading || Viewport.Actor.bShowLoadingScreen)
	{
		BigMessage = Localize("all","Options_0058","HPMenu");
		Viewport.Actor.bShowLoadingScreen = True;
		C.Style = 1;
		C.TextSize(BigMessage,fTextWidth,fTextHeight);
		if ( fTextWidth > C.SizeX - 32 )
		{
			C.Font = LocalMedFont;
		} 
		else 
		{
			C.Font = LocalBigFont;
		}
		ScaleAndDraw(C,0.0,0.0,LoadingBackground.p1);
		ScaleAndDraw(C,256.0,0.0,LoadingBackground.p2);
		ScaleAndDraw(C,512.0,0.0,LoadingBackground.p3);
		ScaleAndDraw(C,0.0,256.0,LoadingBackground.p4);
		ScaleAndDraw(C,256.0,256.0,LoadingBackground.p5);
		ScaleAndDraw(C,512.0,256.0,LoadingBackground.p6);
		PrintActionMessageInUpperLeft(C,BigMessage);
		return;
	} 
	else 
	{
		if ( Viewport.Actor.Level.LevelAction == LEVACT_Saving )
		{
			BigMessage = Localize("all","Options_0057","HPMenu");
		} 
		else if ( Viewport.Actor.Level.LevelAction == LEVACT_Connecting )
		{
			BigMessage = ConnectingMessage;
		} 
		else if ( Viewport.Actor.Level.LevelAction == LEVACT_Precaching )
		{
			BigMessage = PrecachingMessage;
		}
	}
	if ( BigMessage != "" )
	{
		C.Style = 1;
		C.TextSize(BigMessage,fTextWidth,fTextHeight);
		if ( fTextWidth > C.SizeX - 32 )
		{
			C.Font = LocalMedFont;
		} 
		else 
		{
			C.Font = LocalBigFont;
		}
		PrintActionMessage(C,BigMessage);
	}
}

defaultproperties
{
    LoadingBackground=(p1=Texture'Icons.FELoadingBackground1',p2=Texture'Icons.FELoadingBackground2',p3=Texture'Icons.FELoadingBackground3',p4=Texture'Icons.FELoadingBackground4',p5=Texture'Icons.FELoadingBackground5',p6=Texture'Icons.FELoadingBackground6',durration=999999.00),

    bUseSystemFonts=True

}