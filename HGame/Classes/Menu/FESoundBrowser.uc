//================================================================================
// FESoundBrowser.
//================================================================================

class FESoundBrowser extends baseFEPage;

var bool bAlreadyLoaded;
var FELangGrid langGrid;
var string MasterList[3000];
var string status[3000];
var string MasterText[3000];
var int MasterCount;

function Created()
{
  local int I;
  local Texture tempTexture;
  local float X;
  local float Y;

  Super.Created();
  langGrid = FELangGrid(CreateWindow(Class'FELangGrid',10.0,20.0,620.0,398.0));
  langGrid.browser = self;
}

function Paint (Canvas Canvas, float X, float Y)
{
  local float W;
  local float H;

  Super.Paint(Canvas,X,Y);
  TextSize(Canvas,"Language Browser",W,H);
  Root.SetPosScaled(Canvas,320.0 - (W / 2),0.0);
  Canvas.DrawText("Language Browser");
  HPHud(Root.Console.Viewport.Actor.myHUD).managerCutScene.RenderHudItemManager(Canvas,False,True,False);
}

function LoadDialogKeys()
{
  local string Id;
  local string Key;

  MasterCount = 0;
  // if ( True )
  while(True)
  {
    Id = "key_" $ string(MasterCount);
    Key = Localize("all",Id,"HPKeys");
    if ( InStr(Key,"<") > -1 )
    {
      return;
    }
    MasterList[MasterCount] = Key;
    MasterText[MasterCount] = Localize("all",MasterList[MasterCount],"HPdialog");
    if ( InStr(MasterText[MasterCount],"<") > -1 )
    {
      MasterText[MasterCount] = Localize("all",MasterList[MasterCount],"BumpDialog");
    }
    if ( InStr(MasterText[MasterCount],"<") > -1 )
    {
      MasterText[MasterCount] = "";
    }
    MasterCount++;
    // goto JL0007;
  }
}

function PreSwitchPage()
{
  local string Text;
  local Sound Sound;
  local int I;

  if ( bAlreadyLoaded )
  {
    return;
  }
  bAlreadyLoaded = True;
  LoadDialogKeys();

  for(I = 0; I < MasterCount; I++)
  {
    Sound = Sound(DynamicLoadObject("ALLDialog." $ MasterList[I],Class'Sound'));
    if ( MasterText[I] == "" )
    {
      status[I] = "NOTXT";
    } else {
      if ( Sound == None )
      {
        status[I] = "NOSND";
      } else {
        status[I] = "OK";
      }
    }
  }
}

function Notify (UWindowDialogControl C, byte E)
{
  local int I;

  if (E == DE_Click)
  {
	//KW left this empty? -AdamJD
  }
}

