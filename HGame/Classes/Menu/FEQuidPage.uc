//================================================================================
// FEQuidPage.
//================================================================================

class FEQuidPage extends baseFEPage;

var HPMessageBox ConfirmReplay;
var harry PlayerHarry;
var UWindowButton startGameButtons[6];
var UWindowButton opponentCrests[6];
var UWindowButton myCrests[6];
var UWindowLabelControl opponentScores[6];
var UWindowLabelControl myScores[6];
var UWindowLabelControl myPoints[6];
var Texture lockedTexture;
var UWindowLabelControl matchLabel[6];
var UWindowButton NimbusButton;
var UWindowButton QArmorButton;

/*
function PreSwitchPage ()
{
  local int I;
  local int nGameState;
  local StatusManager managerStatus;
  local StatusItem si;
  local Texture crestIcons[4];
  local Texture crestIconsGrey[4];
  local bool bCameFromMenu;
  local int playedCount;

  PlayerHarry = harry(HPConsole(Root.Console).Viewport.Actor);
  nGameState = PlayerHarry.ConvertGameStateToNumber();
  HPConsole(Root.Console).Viewport.Actor.ClientMessage("Launching Quidditch menu curGameState:" $ string(nGameState));
  if ( (FEBook(book).prevPage == None) || PlayerHarry.bWithOlly )
  {
    bCameFromMenu = False;
  } else {
    bCameFromMenu = True;
  }
  if ( PlayerHarry.bWithOlly )
  {
    // I = 0;
    // if ( I < 6 )
	for(I = 0; I < 6; I++)
    {
      PlayerHarry.quidGameResults[I].bLocked = False;
      // I++;
      // goto JL00FD;
    }
  } else {
    if ( nGameState >= 40 )
    {
      PlayerHarry.quidGameResults[0].bLocked = False;
    }
    if ( nGameState >= 50 )
    {
      PlayerHarry.quidGameResults[1].bLocked = False;
    }
    if ( nGameState >= 80 )
    {
      PlayerHarry.quidGameResults[2].bLocked = False;
    }
    if ( nGameState >= 100 )
    {
      PlayerHarry.quidGameResults[3].bLocked = False;
    }
    if ( nGameState >= 130 )
    {
      PlayerHarry.quidGameResults[4].bLocked = False;
    }
    if ( nGameState >= 145 )
    {
      playedCount = 0;
      PlayerHarry.quidGameResults[5].bLocked = True;
      // I = 0;
      // if ( I < 5 )
	  for(I = 0; I < 5; I++)
      {
        if ( PlayerHarry.quidGameResults[I].bWon )
        {
          playedCount++;
        }
        // I++;
        // goto JL021C;
      }
      if ( playedCount >= 5 )
      {
        PlayerHarry.quidGameResults[5].bLocked = False;
      }
      if ( (PlayerHarry.quidGameResults[5].myScore > 0) || (PlayerHarry.quidGameResults[5].OpponentScore > 0) )
      {
        PlayerHarry.quidGameResults[5].bLocked = False;
      }
    }
  }
  crestIcons[0] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2GriffindorCrestSm",Class'Texture'));
  crestIcons[1] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2HufflepuffCrestSm",Class'Texture'));
  crestIcons[2] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2RavenclawCrestSm",Class'Texture'));
  crestIcons[3] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2SlytherinCrestSm",Class'Texture'));
  crestIconsGrey[0] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2GriffindorBlank",Class'Texture'));
  crestIconsGrey[1] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2HufflepuffBlank",Class'Texture'));
  crestIconsGrey[2] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2RavenclawBlank",Class'Texture'));
  crestIconsGrey[3] = Texture(DynamicLoadObject("HP2_Menu.icon.HP2SlytherinBlank",Class'Texture'));
  // I = 0;
  // if ( I < 6 )
  for(I = 0; I < 6; I++)
  {
    if ( PlayerHarry.quidGameResults[I].bLocked )
    {
      if ( bCameFromMenu )
      {
        startGameButtons[I].ToolTipString = "";
      } else {
        startGameButtons[I].ToolTipString = GetLocalFEString("Quidditch_0045");
      }
	  startGameButtons[I].UpTexture = Texture'QuidMatchBoxTexture';
	  startGameButtons[I].DownTexture = Texture'QuidMatchBoxTexture';
	  startGameButtons[I].OverTexture = Texture'QuidMatchBoxTexture';
      myCrests[I].UpTexture = crestIconsGrey[0];
      myCrests[I].DownTexture = crestIconsGrey[0];
      myCrests[I].OverTexture = crestIconsGrey[0];
      opponentCrests[I].UpTexture = crestIconsGrey[1 + (I % 3)];
	  opponentCrests[I].DownTexture = crestIconsGrey[1 + (I % 3)];
	  opponentCrests[I].OverTexture = crestIconsGrey[1 + (I % 3)];
      myScores[I].SetText("");
	  opponentScores[I].SetText("");
      myPoints[I].SetText("");
    } 
	else 
	{
      if ( bCameFromMenu )
      {
        startGameButtons[I].ToolTipString = "";
      } 
	  else 
	  {
        startGameButtons[I].ToolTipString = GetLocalFEString("Quidditch_0020") $ " " $I + 1;
      }
	  startGameButtons[I].UpTexture = Texture'QuidMatchBoxTexture';
	  startGameButtons[I].DownTexture = Texture'QuidMatchBoxTexture';
	  startGameButtons[I].OverTexture = Texture'QuidMatchBoxTexture';
      myCrests[I].UpTexture = crestIcons[0];
      myCrests[I].DownTexture = crestIcons[0];
      myCrests[I].OverTexture = crestIcons[0];
      opponentCrests[I].UpTexture = crestIcons[1 + (I % 3)];
	  opponentCrests[I].DownTexture = crestIcons[1 + (I % 3)];
	  opponentCrests[I].OverTexture = crestIcons[1 + (I % 3)];
	  myScores[I].SetText("" $PlayerHarry.quidGameResults[I].myScore);
      opponentScores[I].SetText("" $PlayerHarry.quidGameResults[I].OpponentScore);
      myPoints[I].SetText(GetLocalFEString("Quidditch_0046") $ " " $PlayerHarry.quidGameResults[I].HousePoints);
   }
    // I++;
    // goto JL04AD;
  }
  managerStatus = harry(Root.Console.Viewport.Actor).managerStatus;
  si = managerStatus.GetStatusItem(Class'StatusGroupQGear',Class'StatusItemNimbus');
  if ( si.GetCount() >= 1 )
  {
    NimbusButton.ShowWindow();
  } else {
    NimbusButton.HideWindow();
  }
  si = managerStatus.GetStatusItem(Class'StatusGroupQGear',Class'StatusItemQArmor');
  if ( si.GetCount() >= 1 )
  {
    QArmorButton.ShowWindow();
  } else {
    QArmorButton.HideWindow();
  }
  Super.PreSwitchPage();
}
*/

//rewritten this function because the original is broken -AdamJD
function PreSwitchPage()
{
  local int i;
  local int nGameState;
  local StatusManager managerStatus;
  local StatusItem si;
  local Texture crestIcons[4];
  local Texture crestIconsGrey[4];
  local bool bCameFromMenu;
  local int playedCount;

  playerHarry= Harry(HPConsole(root.console).Viewport.Actor);
  nGameState= playerHarry.ConvertGameStateToNumber();

  HPConsole(root.console).Viewport.Actor.ClientMessage("Launching Quidditch menu curGameState:"$nGameState);

  if ( (FEBook(book).prevPage == None) || PlayerHarry.bWithOlly )
  {
    bCameFromMenu= False;
  } 
  else 
  {
    bCameFromMenu= True;
  }
  
  if ( PlayerHarry.bWithOlly )
  {
	for(I = 0; I < ArrayCount(playerHarry.quidGameResults); I++)
    {
      PlayerHarry.quidGameResults[I].bLocked= False;
    }
  } 
  
  else 
  {
    if ( nGameState >= 40 )
    {
      PlayerHarry.quidGameResults[0].bLocked= False;
    }
    if ( nGameState >= 50 )
    {
      PlayerHarry.quidGameResults[1].bLocked= False;
    }
    if ( nGameState >= 80 )
    {
      PlayerHarry.quidGameResults[2].bLocked= False;
    }
    if ( nGameState >= 100 )
    {
      PlayerHarry.quidGameResults[3].bLocked= False;
    }
    if ( nGameState >= 130 )
    {
      PlayerHarry.quidGameResults[4].bLocked= False;
    }
    if ( nGameState >= 145 )
    {
      playedCount = 0;
      PlayerHarry.quidGameResults[5].bLocked= True;
	  for(I = 0; I < 5; I++)
      {
        if ( PlayerHarry.quidGameResults[I].bWon )
        {
          playedCount++;
        }
      }
      if ( playedCount >= 5 )
      {
        PlayerHarry.quidGameResults[5].bLocked= False;
      }
      if ( (PlayerHarry.quidGameResults[5].myScore > 0) || (PlayerHarry.quidGameResults[5].OpponentScore > 0) )
      {
        PlayerHarry.quidGameResults[5].bLocked= False;
      }
    }
  }
  
  crestIcons[0]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2GriffindorCrestSm",Class'Texture'));
  crestIcons[1]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2HufflepuffCrestSm",Class'Texture'));
  crestIcons[2]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2RavenclawCrestSm",Class'Texture'));
  crestIcons[3]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2SlytherinCrestSm",Class'Texture'));
  
  crestIconsGrey[0]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2GriffindorBlank",Class'Texture'));
  crestIconsGrey[1]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2HufflepuffBlank",Class'Texture'));
  crestIconsGrey[2]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2RavenclawBlank",Class'Texture'));
  crestIconsGrey[3]= Texture(DynamicLoadObject("HP2_Menu.icon.HP2SlytherinBlank",Class'Texture'));

  for(i = 0; i < ArrayCount(playerHarry.quidGameResults); i++)
  {
	if ( playerHarry.quidGameResults[i].bLocked )
	{
		if ( bCameFromMenu )
		{
		    startGameButtons[I].ToolTipString = "";
		} 
		else 
		{
		    startGameButtons[I].ToolTipString = GetLocalFEString("Quidditch_0045");
		}
		startGameButtons[i].UpTexture=texture 'QuidMatchBoxTexture'; 
		startGameButtons[i].DownTexture=texture 'QuidMatchBoxTexture'; 
		startGameButtons[i].OverTexture=texture 'QuidMatchBoxTexture';  
		myCrests[I].UpTexture = crestIconsGrey[0];
		myCrests[I].DownTexture = crestIconsGrey[0];
		myCrests[I].OverTexture = crestIconsGrey[0];
		opponentCrests[I].UpTexture = crestIconsGrey[1 + (I % 3)];
		opponentCrests[I].DownTexture = crestIconsGrey[1 + (I % 3)];
		opponentCrests[I].OverTexture = crestIconsGrey[1 + (I % 3)];
		myScores[i].setText("");
		opponentScores[i].setText("");
		myPoints[i].setText("");
	}
	
	else
	{
		if ( bCameFromMenu )
		{
			startGameButtons[I].ToolTipString = "";
		} 
		else 
		{
			startGameButtons[I].ToolTipString = GetLocalFEString("Quidditch_0020") $ " " $I + 1;
		}
		startGameButtons[i].UpTexture=texture 'QuidMatchBoxTexture'; 
		startGameButtons[i].DownTexture=texture 'QuidMatchBoxTexture'; 
		startGameButtons[i].OverTexture=texture 'QuidMatchBoxTexture'; 

		myCrests[I].UpTexture = crestIcons[0];
		myCrests[I].DownTexture = crestIcons[0];
		myCrests[I].OverTexture = crestIcons[0];
		opponentCrests[I].UpTexture = crestIcons[1 + (I % 3)];
		opponentCrests[I].DownTexture = crestIcons[1 + (I % 3)];
		opponentCrests[I].OverTexture = crestIcons[1 + (I % 3)];
				
		myScores[i].setText(""$playerHarry.quidGameResults[i].myScore);
		opponentScores[i].setText(""$playerHarry.quidGameResults[i].opponentScore);
		myPoints[i].setText("Points " $playerHarry.quidGameResults[i].housePoints);
	}
  }
	
  managerStatus = harry(Root.Console.Viewport.Actor).managerStatus;
  
  si = managerStatus.GetStatusItem(Class'StatusGroupQGear',Class'StatusItemNimbus');
  if ( si.GetCount() >= 1 )
  {
    NimbusButton.ShowWindow();
  } 
  else 
  {
    NimbusButton.HideWindow();
  }
  
  si = managerStatus.GetStatusItem(Class'StatusGroupQGear',Class'StatusItemQArmor');
  if ( si.GetCount() >= 1 )
  {
    QArmorButton.ShowWindow();
  } 
  else 
  {
    QArmorButton.HideWindow();
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

/*
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

  gameBoxWidth = 128;
  gameBoxHeight = 128;
  gameSpaceX = 64 + gameBoxWidth;
  gameSpaceY = 32 + gameBoxHeight;
  StartX = (WinWidth / 2) - ((3 * gameBoxWidth + (2 * 64)) / 2);
  StartY = 100; 
  PlayerHarry = harry(HPConsole(Root.Console).Viewport.Actor);
  crestIcons[0] = Texture'GryfCrestTexture';
  crestIcons[1] = Texture'HuffCrestTexture';
  crestIcons[2] = Texture'RaveCrestTexture';
  crestIcons[3] = Texture'SlytCrestTexture';
  lockedTexture = Texture'QuidMatchLockTexture';
  CreateBackPageButton();
  CreateTitleButton(GetLocalFEString("Quidditch_0007"));
  // I = 0;
  // if ( I < 6 )
  for(I = 0; I < 6; I++)
  {
    if ( I > 2 )
    {
      Row = 1;
      Col = I - 3;
    } else {
      Row = 0;
      Col = I;
    }
    matchLabel[I] = UWindowLabelControl(CreateControl(Class'UWindowLabelControl',StartX + (Col * gameSpaceX),StartY + (Row * gameSpaceY) - 20,gameBoxWidth,30.0));
    matchLabel[I].SetFont(4);
    matchLabel[I].TextColor.R = 215;
    matchLabel[I].TextColor.G = 100;
    matchLabel[I].TextColor.B = 215;
    matchLabel[I].Align = 2; 
    matchLabel[I].bShadowText = True;
    myCrests[I] = UWindowButton(CreateControl(Class'UWindowButton',StartX + Col * gameSpaceX,StartY + Row * gameSpaceY + 5,64.0,64.0));
    myCrests[I].Align = 2;
    myCrests[I].UpTexture = crestIcons[0];
    myCrests[I].DownTexture = crestIcons[0];
    myCrests[I].OverTexture = crestIcons[0];
    opponentCrests[I] = UWindowButton(CreateControl(Class'UWindowButton',StartX + Col * gameSpaceX + 64,StartY + Row * gameSpaceY + 5,64.0,64.0));
    opponentCrests[I].Align = 2;
    opponentCrests[I].UpTexture = crestIcons[1 + (I % 3)];
	opponentCrests[I].DownTexture = crestIcons[1 + (I % 3)];
	opponentCrests[I].OverTexture = crestIcons[1 + (I % 3)];
    startGameButtons[I].SetFont(4);
    startGameButtons[I].Align = 2;
    startGameButtons[I].bShadowText = True;
    startGameButtons[I].ToolTipString = GetLocalFEString("Quidditch_0020") $ " " $ string(I);
    startGameButtons[I].UpTexture = Texture'QuidMatchBoxTexture';
    startGameButtons[I].DownTexture = Texture'QuidMatchBoxTexture';
    startGameButtons[I].OverTexture = Texture'QuidMatchBoxTexture';
	myScores[I] = UWindowLabelControl(CreateControl(Class'UWindowLabelControl',StartX + (Col * gameSpaceX),StartY + (Row * gameSpaceY) + 5 + 64,64.0,20.0));
    myScores[I].SetFont(4);
    myScores[I].TextColor.R = 255;
    myScores[I].TextColor.G = 255;
    myScores[I].TextColor.B = 255;
    myScores[I].Align = 2;
    myScores[I].bShadowText = True;
    myScores[I].SetText("");
    opponentScores[I] = UWindowLabelControl(CreateControl(Class'UWindowLabelControl',StartX + (Col * gameSpaceX) + 64,StartY + (Row * gameSpaceY) + 5 + 64,64.0,20.0));
    opponentScores[I].SetFont(4);
    opponentScores[I].TextColor.R = 255;
    opponentScores[I].TextColor.G = 255;
    opponentScores[I].TextColor.B = 255;
    opponentScores[I].Align = 2;
    opponentScores[I].bShadowText = True;
    opponentScores[I].SetText("");
    myPoints[I] = UWindowLabelControl(CreateControl(Class'UWindowLabelControl',StartX + (Col * gameSpaceX) + 0,StartY + (Row * gameSpaceY) + 100,128.0,20.0));
    myPoints[I].SetFont(4);
    myPoints[I].TextColor.R = 255;
    myPoints[I].TextColor.G = 255;
    myPoints[I].TextColor.B = 255;
    myPoints[I].Align = 2;
    myPoints[I].bShadowText = True;
    myPoints[I].SetText("");
    // I++;
    // goto JL00F8;
  }
  matchLabel[0].SetText(GetLocalFEString("Quidditch_0009"));
  matchLabel[1].SetText(GetLocalFEString("Quidditch_0010"));
  matchLabel[2].SetText(GetLocalFEString("Quidditch_0011"));
  matchLabel[3].SetText(GetLocalFEString("Quidditch_0012"));
  matchLabel[4].SetText(GetLocalFEString("Quidditch_0013"));
  matchLabel[5].SetText(GetLocalFEString("Quidditch_0014"));
  QArmorButton = UWindowButton(CreateControl(Class'UWindowButton',5.0,5.0,64.0,64.0));
  QArmorButton.ToolTipString = GetLocalFEString("Main_Menu_0012");
  QArmorButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Icons.HP2QuidditchArmor",Class'Texture'));
  QArmorButton.OverTexture = QArmorButton.UpTexture;
  QArmorButton.DownTexture = QArmorButton.OverTexture;
  QArmorButton.DownSound = None;
  NimbusButton = UWindowButton(CreateControl(Class'UWindowButton',570.0,5.0,64.0,64.0));
  NimbusButton.ToolTipString = GetLocalFEString("Main_Menu_0013");
  NimbusButton.UpTexture = Texture(DynamicLoadObject("HP2_Menu.Hud.HP2Nimbus2001",Class'Texture'));
  NimbusButton.OverTexture = NimbusButton.UpTexture;
  NimbusButton.DownTexture = NimbusButton.OverTexture;
  NimbusButton.DownSound = None;
  Super.Created();
}
*/

//rewritten this function because the original is broken -AdamJD
function Created()
{
	local int startX;
	local int startY;
	local int gameBoxWidth;
	local int gameBoxHeight;
	local int gameSpaceX;
	local int gameSpaceY;
	local int i;
	local int row;
	local int col;
	local texture crestIcons[4];

	gameBoxWidth = 128;
	gameBoxHeight = 128;

	gameSpaceX= 64 + gameBoxWidth;
	gameSpaceY= 32 + gameBoxHeight;

	startX = (WinWidth / 2) - ((3 * gameBoxWidth + (2 * 64)) / 2);
	startY = 100;
	
	playerHarry=Harry(HPConsole(root.console).Viewport.Actor);

    CreateBackPageButton();
	CreateTitleButton(GetLocalFEString("Quidditch_0007"));

	for(i = 0; i < ArrayCount(playerHarry.quidGameResults); i++)
	{
		if(i > 2)
		{
			row = 1;
			col = i - 3;
		}
		else
		{
			row = 0;
			col = i;
		}

		matchLabel[i]= UWindowLabelControl(CreateControl(class'UWindowLabelControl',startX + (col * gameSpaceX),startY + (row * gameSpaceY) - 20,gameBoxWidth,30));
		matchLabel[i].setFont(4);
		matchLabel[i].TextColor.r= 215;
		matchLabel[i].TextColor.g= 100;
		matchLabel[i].TextColor.b= 215;
		matchLabel[i].Align= TA_Center;
		matchLabel[i].bShadowText= true;

		myCrests[i] = UWindowButton(CreateControl(class'UWindowButton',startX + (col * gameSpaceX),startY + (row * gameSpaceY) + 5,64,64));
		myCrests[i].Align= TA_Center;
		myCrests[i].UpTexture= crestIcons[0]; 
		myCrests[i].DownTexture= crestIcons[0]; 
		myCrests[i].OverTexture= crestIcons[0]; 

		opponentCrests[i]= UWindowButton(CreateControl(class'UWindowButton',startX + (col * gameSpaceX) + 64,startY + (row * gameSpaceY) + 5,64,64));
		opponentCrests[i].Align=TA_Center;
		opponentCrests[i].UpTexture= crestIcons[1+(i%3)]; 
		opponentCrests[i].DownTexture= crestIcons[1+(i%3)]; 
		opponentCrests[i].OverTexture= crestIcons[1+(i%3)]; 

		startGameButtons[i]= UWindowButton(CreateControl(class'UWindowButton',startX + (col * gameSpaceX),startY + (row * gameSpaceY),gameBoxWidth,gameBoxHeight));
		startGameButtons[i].setFont(4);
		startGameButtons[i].Align= TA_Center;
		startGameButtons[i].bShadowText= true;
		startGameButtons[i].ToolTipString= GetLocalFEString("Quidditch_0020") $ " " $ I;  
		startGameButtons[i].UpTexture= Texture 'QuidMatchBoxTexture'; 
		startGameButtons[i].DownTexture= Texture 'QuidMatchBoxTexture'; 
		startGameButtons[i].OverTexture= Texture 'QuidMatchBoxTexture'; 

		myScores[i]=UWindowLabelControl(CreateControl(class'UWindowLabelControl',startX + (col * gameSpaceX),startY + (row * gameSpaceY) + 5 + 64,64,20));
		myScores[i].setFont(4);
		myScores[i].TextColor.r= 255;
		myScores[i].TextColor.g= 255;
		myScores[i].TextColor.b= 255;
		myScores[i].Align= TA_Center;
		myScores[i].bShadowText= true;
		myScores[i].setText("");

		opponentScores[i]= UWindowLabelControl(CreateControl(class'UWindowLabelControl',startX + (col * gameSpaceX) + 64, startY + (row * gameSpaceY) + 5 + 64,64,20));
		opponentScores[i].setFont(4);
		opponentScores[i].TextColor.r= 255;
		opponentScores[i].TextColor.g= 255;
		opponentScores[i].TextColor.b= 255;
		opponentScores[i].Align= TA_Center;
		opponentScores[i].bShadowText= true;
		opponentScores[i].setText("");

		myPoints[i]= UWindowLabelControl(CreateControl(class'UWindowLabelControl',startX + (col * gameSpaceX) + 32,startY + (row * gameSpaceY) + 100,64,20));
		myPoints[i].setFont(4);
		myPoints[i].TextColor.r= 255;
		myPoints[i].TextColor.g= 255;
		myPoints[i].TextColor.b= 255;
		myPoints[i].Align= TA_Center;
		myPoints[i].bShadowText= true;
		myPoints[i].setText("");
	}
	
    matchLabel[0].SetText(GetLocalFEString("Quidditch_0009"));
    matchLabel[1].SetText(GetLocalFEString("Quidditch_0010"));
    matchLabel[2].SetText(GetLocalFEString("Quidditch_0011"));
    matchLabel[3].SetText(GetLocalFEString("Quidditch_0012"));
    matchLabel[4].SetText(GetLocalFEString("Quidditch_0013"));
    matchLabel[5].SetText(GetLocalFEString("Quidditch_0014"));
    QArmorButton= UWindowButton(CreateControl(Class'UWindowButton',5.0,5.0,64.0,64.0));
    QArmorButton.ToolTipString= GetLocalFEString("Main_Menu_0012");
    QArmorButton.UpTexture= Texture(DynamicLoadObject("HP2_Menu.Icons.HP2QuidditchArmor",Class'Texture'));
    QArmorButton.OverTexture= QArmorButton.UpTexture;
    QArmorButton.DownTexture= QArmorButton.OverTexture;
    QArmorButton.DownSound= None;
    NimbusButton= UWindowButton(CreateControl(Class'UWindowButton',570.0,5.0,64.0,64.0));
    NimbusButton.ToolTipString= GetLocalFEString("Main_Menu_0013");
    NimbusButton.UpTexture= Texture(DynamicLoadObject("HP2_Menu.Hud.HP2Nimbus2001",Class'Texture'));
    NimbusButton.OverTexture= NimbusButton.UpTexture;
    NimbusButton.DownTexture= NimbusButton.OverTexture;
    NimbusButton.DownSound= None;
	
    Super.Created(); 
}	

function LaunchQuidditch ()
{
  FEBook(book).CloseBook();
  harry(Root.Console.Viewport.Actor).LoadLevel("Quidditch.unr");
}

function WindowDone (UWindowWindow W)
{
  if ( W == ConfirmReplay )
  {
    if ( ConfirmReplay.Result == ConfirmReplay.button1.Text )
    {
      HPConsole(Root.Console).Viewport.Actor.ClientMessage("Launching Quidditch match " $ string(PlayerHarry.curQuidMatchNum));
      LaunchQuidditch();
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
    // if ( I < 6 )
	for(I = 0; I < 6; I++)
    {
      if ( startGameButtons[I] == C )
      {
        PlayerHarry.curQuidMatchNum = I;
        if ( PlayerHarry.quidGameResults[I].bLocked )
        {
          return;
        }
        if ( (FEBook(book).prevPage == FEBook(book).InGamePage) &&  !PlayerHarry.bWithOlly )
        {
          return;
        }
        if ( PlayerHarry.quidGameResults[I].bWon )
        {
          ConfirmReplay = doHPMessageBox(GetLocalFEString("Quidditch_0017"),GetLocalFEString("Shared_Menu_0003"),GetLocalFEString("Shared_Menu_0004"));
        } else {
          HPConsole(Root.Console).Viewport.Actor.ClientMessage("Launching Quidditch match " $ string(PlayerHarry.curQuidMatchNum));
          LaunchQuidditch();
        }
      }
      // I++;
      // goto JL0037;
    }
  }
  Super.Notify(C,E);
}

