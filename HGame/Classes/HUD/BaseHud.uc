//================================================================================
// baseHUD.
//================================================================================

class baseHUD extends HUD;
  //Config(User);

struct IconMessage
{
  var bool valid;
  var Texture Icon;
  var string Message;
  var float duration;
};

enum _HUDGameType 
{
	HUDG_QUIDDITCH,
	HUDG_FLYINGKEYS
};

var bool bCutSceneMode;
var bool bCutPopupMode;
var bool bDrawDialogText;
var _HUDGameType HUDGameType;
var IconMessage curIconMessage;
var basePopup curPopup;
var string DebugString;
var int DebugValA;
var int DebugValX;
var int DebugValY;
var int DebugValZ;
var string DebugString2;
var int DebugValA2;
var int DebugValX2;
var int DebugValY2;
var int DebugValZ2;
var bool bScoreCountup;
var float fScoreCountTime;
var float fMaxScoreCountTime;
var bool bPlayQHUDGame;

event Tick (float fDeltaTime)
{
	Super.Tick(fDeltaTime);
	if ( curIconMessage.valid )
	{
		curIconMessage.duration -= fDeltaTime;
		if ( curIconMessage.duration < 0 )
		{
		curIconMessage.valid = False;
		}
	}
}

function SetScoreCountTime (float t)
{
	fScoreCountTime = t;
	fMaxScoreCountTime = t;
}

function PlayHUDGame (bool bEnable)
{
	bPlayQHUDGame = bEnable;
}

function SetHUDGameType (_HUDGameType GameType)
{
	HUDGameType = GameType;
}

function DrawDebug (Canvas Canvas)
{
	Canvas.SetPos(8.0, Canvas.SizeY - 240);
	Canvas.DrawText("Text " $ DebugString, False);
	Canvas.SetPos(8.0, Canvas.SizeY - 224);
	Canvas.DrawText("ValA " $ string(DebugValA),False);
	Canvas.SetPos(8.0, Canvas.SizeY - 208);
	Canvas.DrawText("ValX " $ string(DebugValX),False);
	Canvas.SetPos(8.0, Canvas.SizeY - 192);
	Canvas.DrawText("ValY " $ string(DebugValY),False);
	Canvas.SetPos(8.0, Canvas.SizeY - 176);
	Canvas.DrawText("ValZ " $ string(DebugValZ),False);
	Canvas.SetPos(8.0, Canvas.SizeY - 144);
	Canvas.DrawText("Text " $ DebugString2,False);
	Canvas.SetPos(8.0, Canvas.SizeY - 128);
	Canvas.DrawText("ValA " $ string(DebugValA2),False);
	Canvas.SetPos(8.0, Canvas.SizeY - 112);
	Canvas.DrawText("ValX " $ string(DebugValX2),False);
	Canvas.SetPos(8.0, Canvas.SizeY - 96);
	Canvas.DrawText("ValY " $ string(DebugValY2),False);
	Canvas.SetPos(8.0, Canvas.SizeY - 80);
	Canvas.DrawText("ValZ " $ string(DebugValZ2),False);
}

function ShowPopup (Class<basePopup> popup)
{
	curPopup = Spawn(popup);
}

function DestroyPopup ()
{
	if ( curPopup != None )
	{
		curPopup.Destroy();
		curPopup = None;
	}
}

function DrawPopup (Canvas Canvas)
{
	if ( curPopup == None )
	{
		return;
	}
	curPopup.Draw(Canvas);
	if ( curPopup.bDeleteMe )
	{
		curPopup = None;
	}
}

function ReceiveIconMessage (Texture Icon, string Message, float duration)
{
	curIconMessage.Icon 	= Icon;
	curIconMessage.Message 	= Message;
	curIconMessage.duration = duration;
	curIconMessage.valid 	= True;
}

simulated function HUDSetup (Canvas Canvas)
{
	Canvas.Reset();
	Canvas.SpaceX 		= 0.0;
	Canvas.bNoSmooth 	= True;
	Canvas.DrawColor.R 	= 255;
	Canvas.DrawColor.G 	= 255;
	Canvas.DrawColor.B 	= 255;
	Canvas.Font		 	= baseConsole(PlayerPawn(Owner).Player.Console).LocalMedFont;
}

exec function ToggleDialog ()
{
	bDrawDialogText =  !bDrawDialogText;
}

defaultproperties
{
    bDrawDialogText=True

}