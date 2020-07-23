//================================================================================
// baseFEPage.
//================================================================================

class baseFEPage extends UWindowDialogClientWindow;

struct CurrRolloverInfo
{
  var UWindowButton Button;
  var Texture textureRO;
  var bool bROIsWet;
  var Sound soundRO;
};

var baseFEBook book;
var UWindowButton BackPageButton;
var UWindowLabelControl TitleButton;
var Texture textureReturnNorm;
var Texture textureReturnRO;
var CurrRolloverInfo CurrRollover;

function string GetLocalFEString (string strId)
{
	return Localize("All",strId,"HPMenu");
}

function Paint (Canvas Canvas, float X, float Y)
{
}

function PreSwitchPage ()
{
	local bool bBackPage;

	bBackPage = True;
	if ( (FEBook(book).prevPage == None) || (FEBook(book).curPage == FEBook(book).InGamePage) )
	{
		bBackPage = False;
	}
	harry(Root.Console.Viewport.Actor).ClientMessage("Preswitch Page " $ string(FEBook(book).prevPage) $ " " $ string(FEBook(book).curPage));
	SetBackPageToolTip(bBackPage);
	ClearRollover();
}

function PreOpenBook ()
{
}

function CreateBackPageButton (optional int nX, optional int nY)
{
	if ( nX == 0 )
	{
		nX = 582;
	}
	if ( nY == 0 )
	{
		nY = 422;
	}
	if ( textureReturnNorm == None )
	{
		textureReturnNorm = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuBackToGame",Class'Texture'));
		textureReturnRO = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2MenuBackToGameWet",Class'WetTexture'));
	}
	BackPageButton = UWindowButton(CreateControl(Class'UWindowButton', nX, nY,48.0,48.0));
	BackPageButton.UpTexture = textureReturnNorm;
	BackPageButton.DownTexture = textureReturnNorm;
	BackPageButton.OverTexture = textureReturnNorm;
	BackPageButton.ToolTipString = GetLocalFEString("Shared_Menu_0002");
	BackPageButton.DownSound = Sound'GUI_Esc_Click5';
	BackPageButton.Register(self);
}

// Metallicafan212:	Don't think this is used, so I'm not going to fix the jump shit
function CreateTitleButton (string strTitle, optional int nXPos, optional int nYPos)
{
	if ( nXPos == 0 )
	{
		/*
		nXPos = WinWidth / byte(2) = 200 - );
		// There are 1 jump destination(s) inside the last statement!
		{
		nYPos = 40;
		}
		*/
	}
	TitleButton = UWindowLabelControl(CreateControl(Class'UWindowLabelControl', nXPos, nYPos,400.0,30.0));
	TitleButton.SetFont(4);
	TitleButton.TextColor.R = 215;
	TitleButton.TextColor.G = 0;
	TitleButton.TextColor.B = 215;
	TitleButton.Align = TA_Center;
	TitleButton.bShadowText = True;
	TitleButton.SetText(strTitle);
}

function SetBackPageToolTip (bool bBackPage)
{
	if ( BackPageButton != None )
	{
		if ( bBackPage )
		{
			BackPageButton.ToolTipString = GetLocalFEString("Shared_Menu_0002");
		} 
		else 
		{
			BackPageButton.ToolTipString = GetLocalFEString("Main_Menu_0010");
		}
	}
}

function int GetStatusY ()
{
  return WinHeight - 26;
}

function Notify (UWindowDialogControl C, byte E)
{
	if (E == 12 )
	{
		if ( C == BackPageButton )
		{
			SetRollover(BackPageButton,textureReturnRO,Sound'GUI_Esc_Rollover4',True);
		}
	} 
	else 
	{
		if ( E == 9 )
		{
			if ( C == BackPageButton )
			{
				ClearRollover();
			}
		}
	}
	Super.Notify(C,E);
}

function AfterPaint (Canvas Canvas, float X, float Y)
{
	local float fScaleFactor;
	local float fHalfROScale;
	local float fOffsetX;
	local float fOffsetY;
	local int nSaveStyle;

	if ( BackPageButton != None )
	{
		if ( CurrRollover.textureRO != None )
		{
			fScaleFactor 	= Canvas.SizeX / WinWidth;
			nSaveStyle 		= Canvas.Style;
			Canvas.Style 	= 3;
			Canvas.SetPos(CurrRollover.Button.WinLeft * fScaleFactor,CurrRollover.Button.WinTop * fScaleFactor);
			Canvas.DrawIcon(CurrRollover.textureRO,fScaleFactor);
			Canvas.Style = nSaveStyle;
		}
	}
	Super.AfterPaint(Canvas,X,Y);
}

function SetRollover (UWindowButton Button, Texture textureRO, Sound soundRO, bool bROIsWet)
{
	CurrRollover.Button = Button;
	CurrRollover.textureRO = textureRO;
	CurrRollover.bROIsWet = bROIsWet;
	CurrRollover.soundRO = soundRO;
	if ( soundRO != None )
	{
		GetPlayerOwner().PlaySound(CurrRollover.soundRO,SLOT_Interact,,,100000.0,,True,True);
	}
}

function ClearRollover ()
{
	CurrRollover.Button = None;
	CurrRollover.textureRO = None;
	if ( CurrRollover.soundRO != None )
	{
		GetPlayerOwner().StopSound(CurrRollover.soundRO, SLOT_Interact, 0.0);
		CurrRollover.soundRO = None;
	}
}

function HPMessageBox doHPMessageBox (string Msg, string textButton1, optional string textButton2, optional float TimeOut)
{
	local HPMessageBox W;

	W = HPMessageBox(Root.CreateWindow(Class'HPMessageBox',(640.0 - 246) / 2,(480.0 - 102) / 2,246.0,150.0,self));
	W.Setup(Msg,textButton1,textButton2,TimeOut);
	Root.ShowModal(W);
	return W;
}

function WindowEvent (WinMessage Msg, Canvas C, float X, float Y, int Key)
{
	if ( (Msg == 9) ||  !Root.WaitModal() )
	{
		Super.WindowEvent(Msg,C,X,Y,Key);
	}
}

function bool KeyEvent (byte Key, byte Action, float Delta)
{
	return False;
}