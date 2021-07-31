//================================================================================
// FEChallengesPage.
//================================================================================

class FEChallengesPage extends baseFEPage;

const nSPONGIFY_CHALLENGE= 3;
const nDIFFINDO_CHALLENGE= 2;
const nSKURGE_CHALLENGE= 1;
const nRICTUSEMPRA_CHALLENGE= 0;
var UWindowButton NameButtons[4];
var UWindowButton ScoreButtons[4];
var UWindowLabelControl NoneWonLabel;


function Created()
{
  local int I;
  local int nStartY;

  CreateBackPageButton();
  CreateTitleButton(GetLocalFEString("Report_Card_0008"));
  NoneWonLabel = UWindowLabelControl(CreateControl(Class'UWindowLabelControl',WinWidth / 2 - 200,100.0,400.0,30.0));
  NoneWonLabel.SetFont(4);
  NoneWonLabel.TextColor.R = 255;
  NoneWonLabel.TextColor.G = 255;
  NoneWonLabel.TextColor.B = 255;
  // NoneWonLabel.Align = 2;
  NoneWonLabel.Align = TA_Center; //from UWindowBase.uc in the proto -AdamJD 
  NoneWonLabel.bShadowText = True;
  NoneWonLabel.SetText(GetLocalFEString("Main_Menu_0011"));
  nStartY = 100;

  for(I = 0; I < 4; I++)
  {
    NameButtons[I] = UWindowButton(CreateControl(Class'UWindowButton',100.0,nStartY + I * 26,200.0,20.0));
    NameButtons[I].SetFont(4);
    NameButtons[I].TextColor.R = 255;
    NameButtons[I].TextColor.G = 255;
    NameButtons[I].TextColor.B = 255;
    // NameButtons[I].Align = 0;
	NameButtons[I].Align = TA_Left; //from UWindowBase.uc in the proto -AdamJD 
    NameButtons[I].bShadowText = True;
    ScoreButtons[I] = UWindowButton(CreateControl(Class'UWindowButton',440.0,nStartY + I * 26,200.0,20.0));
    ScoreButtons[I].SetFont(4);
    ScoreButtons[I].TextColor.R = 255;
    ScoreButtons[I].TextColor.G = 255;
    ScoreButtons[I].TextColor.B = 255;
    // ScoreButtons[I].Align = 0;
	ScoreButtons[I].Align = TA_Left; //from UWindowBase.uc in the proto -AdamJD 
    ScoreButtons[I].bShadowText = True;
  }
  NameButtons[0].SetText(GetLocalFEString("Maps_0006"));
  NameButtons[1].SetText(GetLocalFEString("Maps_0008"));
  NameButtons[2].SetText(GetLocalFEString("Maps_0011"));
  NameButtons[3].SetText(GetLocalFEString("Maps_0001"));
  Super.Created();
}

function Notify (UWindowDialogControl C, byte E)
{
  local int I;

  if ( E == DE_Click )
  {
    if ( C == BackPageButton )
    {
      FEBook(book).DoEscapeFromPage();
    }
  }
  Super.Notify(C,E);
}

function PreSwitchPage()
{
  local harry PlayerHarry;
  local int nHighScore;
  local int nMaxScore;
  local bool bWonAtLeastOne;

  PlayerHarry = harry(Root.Console.Viewport.Actor);
  PlayerHarry.GetRictusempraChallengeScore(nHighScore,nMaxScore);
  if ( nHighScore > 0 )
  {
    bWonAtLeastOne = True;
  }
  UpdateButtonProps(0,nHighScore,nMaxScore);
  PlayerHarry.GetSkurgeChallengeScore(nHighScore,nMaxScore);
  if ( nHighScore > 0 )
  {
    bWonAtLeastOne = True;
  }
  UpdateButtonProps(1,nHighScore,nMaxScore);
  PlayerHarry.GetDiffindoChallengeScore(nHighScore,nMaxScore);
  if ( nHighScore > 0 )
  {
    bWonAtLeastOne = True;
  }
  UpdateButtonProps(2,nHighScore,nMaxScore);
  PlayerHarry.GetSpongifyChallengeScore(nHighScore,nMaxScore);
  if ( nHighScore > 0 )
  {
    bWonAtLeastOne = True;
  }
  UpdateButtonProps(3,nHighScore,nMaxScore);
  if ( bWonAtLeastOne )
  {
    NoneWonLabel.HideWindow();
  } else {
    NoneWonLabel.ShowWindow();
  }
  Super.PreSwitchPage();
}

function UpdateButtonProps (int nChallengeIdx, int nHighScore, int nMaxScore)
{
  if ( nHighScore > 0 )
  {
    NameButtons[nChallengeIdx].ShowWindow();
    ScoreButtons[nChallengeIdx].ShowWindow();
    ScoreButtons[nChallengeIdx].SetText(string(nHighScore) $ " / " $ string(nMaxScore));
  } else {
    NameButtons[nChallengeIdx].HideWindow();
    ScoreButtons[nChallengeIdx].HideWindow();
  }
}

