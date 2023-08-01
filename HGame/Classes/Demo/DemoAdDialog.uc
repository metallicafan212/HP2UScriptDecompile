//================================================================================
// DemoAdDialog.
//================================================================================

class DemoAdDialog extends UWindowDialogClientWindow;

struct Background
{
  var Texture p1;
  var Texture p2;
  var Texture p3;
  var Texture p4;
  var Texture p5;
  var Texture p6;
  var float durration;
};
var Background DemoAd1Background;
var Background curBackground;
var bool bClosing;
var bool bClosedFromTick;
var bool bShift;
var int FrameCount;
var float TimeOutTime;
var float TimeOut;
var float AcceptKeyInputTime;
var float TimeTillAcceptInput;


function Setup (float setTimeOut)
{
  TimeOut = setTimeOut;
  TimeOutTime = 0.0;
  FrameCount = 0;
  curBackground = DemoAd1Background;
  curBackground.p1 = Texture(DynamicLoadObject("HPDemoAd.FEDemoAdBack1Texture1",Class'Texture'));
  curBackground.p2 = Texture(DynamicLoadObject("HPDemoAd.FEDemoAdBack1Texture2",Class'Texture'));
  curBackground.p3 = Texture(DynamicLoadObject("HPDemoAd.FEDemoAdBack1Texture3",Class'Texture'));
  curBackground.p4 = Texture(DynamicLoadObject("HPDemoAd.FEDemoAdBack1Texture4",Class'Texture'));
  curBackground.p5 = Texture(DynamicLoadObject("HPDemoAd.FEDemoAdBack1Texture5",Class'Texture'));
  curBackground.p6 = Texture(DynamicLoadObject("HPDemoAd.FEDemoAdBack1Texture6",Class'Texture'));
}

function ScaleAndDraw (Canvas Canvas, float X, float Y, Texture Tex)
{
  local float FX;
  local float fy;

/*
  FX = Canvas.SizeX / 640.0;
  fy = Canvas.SizeY / 480.0;
  FX = 1.0;
  fy = 1.0;
*/

  if ( Tex == None )
  {
	return;
  }

  //AdamJD:	Updated to work in widescreen
  FX = 1.0;
  FY = (4.0 / 3.0) / (Root.RealWidth / Root.RealHeight);
  
  DrawStretchedTexture(Canvas,X * FX,Y * fy, Tex.USize* FX, Tex.VSize * fy,Tex);
}

function Paint (Canvas Canvas, float X, float Y)
{
  ScaleAndDraw(Canvas,0.0,0.0,curBackground.p1);
  ScaleAndDraw(Canvas,256.0,0.0,curBackground.p2);
  ScaleAndDraw(Canvas,512.0,0.0,curBackground.p3);
  ScaleAndDraw(Canvas,0.0,256.0,curBackground.p4);
  ScaleAndDraw(Canvas,256.0,256.0,curBackground.p5);
  ScaleAndDraw(Canvas,512.0,256.0,curBackground.p6);
}

function AfterPaint (Canvas C, float X, float Y)
{
  Super.AfterPaint(C,X,Y);
  if ( TimeOut != 0 )
  {
    FrameCount++;
    if ( FrameCount >= 5 )
    {
      AcceptKeyInputTime = GetEntryLevel().TimeSeconds + TimeTillAcceptInput;
      TimeOutTime = GetEntryLevel().TimeSeconds + TimeOut;
      TimeOut = 0.0;
    }
  }
  if ( TimeOutTime != 0.0 && GetEntryLevel().TimeSeconds > TimeOutTime )
  {
    TimeOutTime = 0.0;
    bClosedFromTick = True;
    Close();
  }
}

function EscClose ()
{
}

function bool KeyEvent (byte Key, byte Action, float Delta)
{
  if ( (GetEntryLevel().TimeSeconds > AcceptKeyInputTime) || bShift )
  {
    if ( Action == 3 && (Key == 32 || Key == 27) )
    {
      Close();
    }
  } else {
    if ( Action == 1 && Key == 16 )
    {
      bShift = True;
    } else //{
      if ( Action == 4 && Key == 16 )
      {
        bShift = False;
      }
    //}
  }
  return False;
}

function Close (optional bool bByParent)
{
  if (  !bClosing )
  {
    bClosing = True;
    Super.Close(bByParent);
    OwnerWindow.WindowDone(self);
  }
}

defaultproperties
{
    TimeTillAcceptInput=10.00
}
