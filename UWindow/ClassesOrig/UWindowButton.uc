//=============================================================================
// UWindowButton - A button
//=============================================================================
class UWindowButton extends UWindowDialogControl;

#exec OBJ LOAD FILE=..\sounds\menu_sfx.uax PACKAGE=HPSounds.menu_sfx


var bool		bDisabled;
var bool		bStretched;
var texture		UpTexture, DownTexture, DisabledTexture, OverTexture;
var Region		UpRegion,  DownRegion,  DisabledRegion,  OverRegion;
var bool		bUseRegion;
var float		RegionScale;
var string		ToolTipString;
var float		ImageX, ImageY;
var sound		OverSound, DownSound;
var bool	bShadowText;
var bool	bColorOver;
var Color	OverColor;


function Created()
{
	Super.Created();

	ImageX = 0;
	ImageY = 0;
	TextX = 0;
	TextY = 0;
	RegionScale = 1;
	DownSound = sound'HPSounds.menu_sfx.menu_click';
}

function BeforePaint(Canvas C, float X, float Y)
{
local float W, H;
	C.Font = Root.Fonts[Font];

	TextSize(C, RemoveAmpersand(Text), W, H);

	switch(Align)
	{
	case TA_Left:
		TextX = 0;
		break;
	case TA_Right:
		TextX = WinWidth - W;
		break;
	case TA_Center:
		TextX = (WinWidth - W) / 2;
		break;
	}
	TextY = (WinHeight-H)/2;

}

function Paint(Canvas C, float X, float Y)
{
	C.Font = Root.Fonts[Font];

	if(bDisabled) {
		if(DisabledTexture != None)
		{
			if(bUseRegion)
				DrawStretchedTextureSegment( C, ImageX, ImageY, DisabledRegion.W*RegionScale, DisabledRegion.H*RegionScale, 
											DisabledRegion.X, DisabledRegion.Y, 
											DisabledRegion.W, DisabledRegion.H, DisabledTexture );
			else if(bStretched)
				DrawStretchedTexture( C, ImageX, ImageY, WinWidth, WinHeight, DisabledTexture );
			else
				DrawClippedTexture( C, ImageX, ImageY, DisabledTexture);
		}
	} else {
		if(bMouseDown)
		{
			if(DownTexture != None)
			{
				if(bUseRegion)
					DrawStretchedTextureSegment( C, ImageX, ImageY, DownRegion.W*RegionScale, DownRegion.H*RegionScale, 
												DownRegion.X, DownRegion.Y, 
												DownRegion.W, DownRegion.H, DownTexture );
				else if(bStretched)
					DrawStretchedTexture( C, ImageX, ImageY, WinWidth, WinHeight, DownTexture );
				else
					DrawClippedTexture( C, ImageX, ImageY, DownTexture);
			}
		} else {
			if(MouseIsOver()) {
				if(OverTexture != None)
				{
					if(bUseRegion)
						DrawStretchedTextureSegment( C, ImageX, ImageY, OverRegion.W*RegionScale, OverRegion.H*RegionScale, 
													OverRegion.X, OverRegion.Y, 
													OverRegion.W, OverRegion.H, OverTexture );
					else if(bStretched)
						DrawStretchedTexture( C, ImageX, ImageY, WinWidth, WinHeight, OverTexture );
					else
						DrawClippedTexture( C, ImageX, ImageY, OverTexture);
				}
			} else {
				if(UpTexture != None)
				{
					if(bUseRegion)
						DrawStretchedTextureSegment( C, ImageX, ImageY, UpRegion.W*RegionScale, UpRegion.H*RegionScale, 
													UpRegion.X, UpRegion.Y, 
													UpRegion.W, UpRegion.H, UpTexture );
					else if(bStretched)
						DrawStretchedTexture( C, ImageX, ImageY, WinWidth, WinHeight, UpTexture );
					else
						DrawClippedTexture( C, ImageX, ImageY, UpTexture);
				}
			}
		}
	}

	if(Text != "")
	{
		if(bShadowText)
			{
			C.DrawColor.R = 0;
			C.DrawColor.G = 0;
			C.DrawColor.B = 0;
			ClipText(C, TextX+1, TextY+1, Text, True);
			}

		if(MouseIsOver() && bColorOver)
			C.DrawColor=OverColor;
		else
			C.DrawColor = TextColor;

		ClipText(C, TextX, TextY, Text, True);
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 255;
	}
}

function MouseLeave()
{
	Super.MouseLeave();
	if(ToolTipString != "") ToolTip("");
}

simulated function MouseEnter()
{
	Super.MouseEnter();
	if(ToolTipString != "") ToolTip(ToolTipString);
	if (!bDisabled && (OverSound != None))
		GetPlayerOwner().PlaySound(OverSound, SLOT_Interface);
}

simulated function Click(float X, float Y) 
{
	Notify(DE_Click);
	if (!bDisabled && (DownSound != None))
		GetPlayerOwner().PlaySound(DownSound, SLOT_None);
}

function DoubleClick(float X, float Y) 
{
	Notify(DE_DoubleClick);
}

function RClick(float X, float Y) 
{
	Notify(DE_RClick);
}

function MClick(float X, float Y) 
{
	Notify(DE_MClick);
}

function KeyDown(int Key, float X, float Y)
{
	local PlayerPawn P;

	P = Root.GetPlayerOwner();

	switch (Key)
	{
	case P.EInputKey.IK_Space:
//cmp removed 10-12		LMouseDown(X, Y);
//cmp removed 10-12		LMouseUp(X, Y);
		break;
	default:
		Super.KeyDown(Key, X, Y);
		break;
	}
}

defaultproperties
{
	bIgnoreLDoubleClick=True
	bIgnoreMDoubleClick=True
	bIgnoreRDoubleClick=True
}