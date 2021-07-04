//================================================================================
// FEDuelPage.
//================================================================================

class FEDuelPage extends baseFEPage;

//texture import -AdamJD
#exec Texture Import File=Textures\Icons\FEComboIdleTexture.PNG	GROUP=Icons	Name=FEComboIdleTexture COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2

var HPMessageBox ConfirmReplay;
var harry PlayerHarry;
var HGameButton rankingButtons[10];
var HGameButton lockedButtons[10];
var Texture lockedTexture;
var string duelistNames[11];
var string duelistNamesInEnglish[11];

function Created ()
{
  local int StartX;
  local int StartY;
  local int gameBoxWidth;
  local int gameBoxHeight;
  local int gameSpaceX;
  local int gameSpaceY;
  local int I;
  local int Row;
  local int Col;
  local Texture crestIcons[4];

  PlayerHarry = harry(HPConsole(Root.Console).Viewport.Actor);
  CreateBackPageButton();
  CreateTitleButton(GetLocalFEString("InGameMenu_0041"));
  StartY = 100;
  // I = 0;
  // if ( I < 10 )
  for(I = 0; I < 10; I++)
  {
    rankingButtons[I] = HGameButton(CreateControl(Class'HGameButton',WinWidth / 2 - 180 / 2,StartY + I * 28,180.0,26.0));
    rankingButtons[I].SetFont(4);
    rankingButtons[I].TextColor.R = 255;
    rankingButtons[I].TextColor.G = 255;
    rankingButtons[I].TextColor.B = 255;
    // rankingButtons[I].Align = 2;
	rankingButtons[I].Align = TA_Center; //from UWindowBase.uc in the proto -AdamJD 
    rankingButtons[I].bShadowText = True;
    rankingButtons[I].SetText("Duelist " $ string(I));
    rankingButtons[I].UpTexture = Texture'FEComboIdleTexture';
    rankingButtons[I].DownTexture = Texture'FEComboIdleTexture';
    rankingButtons[I].OverTexture = Texture'FEComboIdleTexture';
    // I++;
    // goto JL0062;
  }
  duelistNames[10] = GetLocalDuelName("PC_Her_Trans2Goyle_21",10);
  duelistNames[9] = GetLocalDuelName("PC_Snp_DuelComments_27",9);
  duelistNames[8] = GetLocalDuelName("PC_Snp_DuelComments_26",8);
  duelistNames[7] = GetLocalDuelName("PC_Snp_DuelComments_23",7);
  duelistNames[6] = GetLocalDuelName("PC_Snp_DuelComments_20",6);
  duelistNames[5] = GetLocalDuelName("PC_Snp_DuelComments_16",5);
  duelistNames[4] = GetLocalDuelName("PC_Snp_DuelComments_15",4);
  duelistNames[3] = GetLocalDuelName("PC_Snp_DuelComments_07",3);
  duelistNames[2] = GetLocalDuelName("PC_Snp_DuelComments_11",2);
  duelistNames[1] = GetLocalDuelName("PC_Snp_DuelComments_09",1);
  duelistNames[0] = GetLocalDuelName("PC_Snp_DuelComments_03",0);
  Super.Created();
}

function PreSwitchPage ()
{
  local int I;
  local int Count;
  local int nGameState;
  local string sortedDuelistNames[10];

  PlayerHarry = harry(HPConsole(Root.Console).Viewport.Actor);
  nGameState = PlayerHarry.ConvertGameStateToNumber();
  if ( nGameState >= 80 )
  {
    PlayerHarry.lastUnlockedDuelist = 8;
  }
  if ( nGameState >= 90 )
  {
    PlayerHarry.lastUnlockedDuelist = 7;
  }
  if ( nGameState >= 100 )
  {
    PlayerHarry.lastUnlockedDuelist = 6;
  }
  if ( nGameState >= 110 )
  {
    PlayerHarry.lastUnlockedDuelist = 5;
  }
  if ( nGameState >= 115 )
  {
    PlayerHarry.lastUnlockedDuelist = 4;
  }
  if ( nGameState >= 130 )
  {
    PlayerHarry.lastUnlockedDuelist = 3;
  }
  if ( nGameState >= 140 )
  {
    PlayerHarry.lastUnlockedDuelist = 1;
  }
  if ( nGameState >= 145 )
  {
    PlayerHarry.lastUnlockedDuelist = 0;
  }
  Count = 0;
  // I = 0;
  // if ( I < 10 )
  for(I = 0; I < 10; I++)
  {
    if ( I == PlayerHarry.curWizardDuelRank )
    {
      sortedDuelistNames[I] = "" $ string(I + 1) $ ". " $ duelistNames[10];
    } else {
      sortedDuelistNames[I] = "" $ string(I + 1) $ ". " $ duelistNames[Count];
      Count++;
    }
    // I++;
    // goto JL0139;
  }
  // I = 0;
  // if ( I < 10 )
  for(I = 0; I < 10; I++)
  {
    rankingButtons[I].TextColor.R = 255;
    rankingButtons[I].TextColor.G = 255;
    rankingButtons[I].TextColor.B = 255;
    if ( I == PlayerHarry.curWizardDuelRank )
    {
      rankingButtons[I].TextColor.R = 255;
      rankingButtons[I].TextColor.G = 255;
      rankingButtons[I].TextColor.B = 0;
    }
    rankingButtons[I].SetText(sortedDuelistNames[I]);
    // I++;
    // goto JL01CD;
  }
  Super.PreSwitchPage();
}

function BeforePaint (Canvas C, float X, float Y)
{
  Super.BeforePaint(C,X,Y);
}

function Paint (Canvas Canvas, float X, float Y)
{
  local float fScaleFactor;
  local bool bHaveObjectiveText;
  local float wid;
  local float hei;

  fScaleFactor = Canvas.SizeX / WinWidth;
  Super.Paint(Canvas,X,Y);
}

function LaunchWizardDuel ()
{
  local string levName;

  FEBook(book).CloseBook();
  levName = "Duel0" $ string(PlayerHarry.curWizardDuel + 1) $ ".unr";
  HPConsole(Root.Console).Viewport.Actor.ClientMessage("Launching Wizard Dueling:" $ levName);
  harry(Root.Console.Viewport.Actor).LoadLevel(levName);
}

function WindowDone (UWindowWindow W)
{
  if ( W == ConfirmReplay )
  {
    if ( ConfirmReplay.Result == ConfirmReplay.button1.Text )
    {
      HPConsole(Root.Console).Viewport.Actor.ClientMessage("Launching Quidditch match " $ string(PlayerHarry.curQuidMatchNum));
      LaunchWizardDuel();
    }
    ConfirmReplay = None;
  }
}

function Notify (UWindowDialogControl C, byte E)
{
  local int I;

  if ( E == 2 )
  {
    if ( C == BackPageButton )
    {
      FEBook(book).DoEscapeFromPage();
    }
    // I = 0;
    // if ( I < 10 )
	for(I = 0; I < 10; I++)
    {
      if ( rankingButtons[I] == C )
      {
        if ( (I < PlayerHarry.lastUnlockedDuelist) || (I == PlayerHarry.curWizardDuelRank) )
        {
          return;
        }
        if ( FEBook(book).prevPage == FEBook(book).InGamePage )
        {
          return;
        }
      }
      // I++;
      // goto JL0037;
    }
  }
  Super.Notify(C,E);
}

function string GetLocalDuelName (string strId, int Id)
{
  local int I;
  local string dlgString;

  dlgString = Localize("All",strId,"HPDialog");
  if ( Left(dlgString,1) == "[" )
  {
    I = InStr(dlgString,"]");
    if ( I != -1 )
    {
      dlgString = Mid(dlgString,I + 1);
    }
  }
  if ( Left(dlgString,2) == "<?" )
  {
    dlgString = duelistNamesInEnglish[Id];
  }
  return dlgString;
}

defaultproperties
{
    duelistNamesInEnglish(0)="Peter"

    duelistNamesInEnglish(1)="Emily"

    duelistNamesInEnglish(2)="Rachel"

    duelistNamesInEnglish(3)="Andrew"

    duelistNamesInEnglish(4)="Bridget"

    duelistNamesInEnglish(5)="Stewart"

    duelistNamesInEnglish(6)="Roy"

    duelistNamesInEnglish(7)="Heather"

    duelistNamesInEnglish(8)="Rebecca"

    duelistNamesInEnglish(9)="Edward"

    duelistNamesInEnglish(10)="Harry"

}
