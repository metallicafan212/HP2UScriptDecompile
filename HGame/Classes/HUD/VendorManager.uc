//================================================================================
// VendorManager.
//================================================================================

// Metallicafan212:	No reason to not organize it
class VendorManager extends HudItemManager;//Actor;

const strVENDORBAR_LEFT= "HP2_Menu.Icons.HP2VendorBarLeft";
const strVENDORBAR_RIGHT= "HP2_Menu.Icons.HP2VendorBarRight";
const strVENDORBAR_BUTTON_NORMAL= "HP2_Menu.Icons.HP2ConfirmYes";
const strVENDORBAR_BUTTON_OVER= "HP2_Menu.Icons.HP2ConfirmYes_Highlight";
const strVENDORITEM_NIMBUS= "HP2_Menu.Icons.HP2Nimbus2001";
const strVENDORITEM_QARMOR= "HP2_Menu.Icons.HP2QuidditchArmor";
const strVENDORITEM_FMUCUS= "HP2_Menu.Icons.HP2VendorFMucus";
const strVENDORITEM_WBARK= "HP2_Menu.Icons.HP2VendorWBark";
const strVENDORITEM_SILVERCARD= "HP2_Menu.Icons.HP2VendorSilverCard";
const strVENDORITEM_BRONZECARD= "HP2_Menu.Icons.HP2VendorBronzeCard";
const strVENDORITEM_WIZDUEL= "HP2_Menu.Icons.HP2VendorWizDuel";
const strID_YES= "Shared_Menu_0003";
const strID_NO= "Shared_Menu_0004";
const fVENDORBAR_W= 366.0;
const fVENDORBAR_Y= 20.0;
const fVENDORBAR_PRICE_X= 76.0;
const fVENDORBAR_PRICE_Y= 74.0;
const fVENDORBAR_BUTTON_W= 92.0;
const fVENDORBAR_BUTTON_H= 25.0;
const fVENDORBAR_YESBUTTON_X= 246.0;
const fVENDORBAR_YESBUTTON_Y= 20.0;
const fVENDORBAR_NOBUTTON_X= 246.0;
const fVENDORBAR_NOBUTTON_Y= 54.0;
const fVENDORBAR_PURCHASE_ITEM_X= 155.0;
const fVENDORBAR_PURCHASE_ITEM_Y= 14.0;
const fVENDORBAR_BUTTON_TEXT_X= 46.0;
const fVENDORBAR_BUTTON_TEXT_Y= 12.0;
const strQUESTION_ANIM_PARAM= " startanim=talk_question";
const strBOTHHANDS_ANIM_PARAM= " startanim=talk_bothhands";
const strLEFTHAND_ANIM_PARAM= " startanim=talk_lhand";
const strRIGHTHAND_ANIM_PARAM= " startanim=talk_rhand";
const strVENDOR_WAIT_ANIM_PARAM= " loopanim=vendor_idle2";
const strINDEFINITE_TEXT_PARAM= " IndefiniteText";
const strTALK_COMMAND= "TALK ";
const strSAY_COMMAND= "SAY ";
const strFACE_HARRY_COMMAND= "TURNTO harry";
const strCAPTURE_COMMAND= "CAPTURE";
const strRELEASE_COMMAND= "RELEASE";
const strFLYTO_COMMAND= "FLYTO ";
const strTARGET_FLYTO_COMMAND= "TARGET FLYTO ";
const strCUE_VENDOR_TURN_DONE= "_VendorTurnDone";
const strCUE_CAMERA_IN_POSITION= "_CameraInPosition";
const strCUE_ITEM_SOLD= "_ItemSold";
const strCUE_HARRY_INQUIRY= "_HarryInquiry";
const strCUE_IHAVE_X= "_IHaveX";
const strCUE_INSTRUCTIONS= "_Instructions";
const strCUE_TRANSACTION_DONE= "_TransactionDone";
const strCUE_DECLINE_SALE= "_DeclineSale";
const strCUE_NOT_ENOUGH_BEANS= "_NotEnoughBeans";
const strCUE_RAN_OUT_OF_BEANS= "_RanOutOfBeans";
const strCUE_OUT_OF_STOCK= "_OutOfStock";
const strTEMP_VENDOR_CUT_NAME= "TempVendorCutName";

var Texture textureVendorBarLeft;
var Texture textureVendorBarRight;
var Texture textureVendorButtonNormal;
var Texture textureVendorButtonOver;
var Texture textureItemToSell;
var Characters Vendor;

// Metallicafan212:	Prevent a stutter by caching the Weasly twin
var Characters WeasTwin;

var name nameVendorSavedState;
var string strVendorSavedCutName;
var int nLastButtonYes;
var int nLastButtonNo;
var int nItemsBoughtInCurrTransaction;
var int nCurrPrice;
var StatusManager managerStatus;
var Canvas VendorCanvas;
var int I;
var Characters WeasleyTwin;
var int nSubtractBeans;
var float fTicksPerSec;
var float fTickDelta;
var int nMinusBeansPerTick;
var string strYes;
var string strNo;

// Metallicafan212:	So we can quickly update the hover shit...
var float HScale;

function SetVendor (Characters V)
{
	Vendor 		= V;
	// Metallicafan212:	Added to prevent against stutter with Fred and George
	WeasTwin 	= Vendor.GetWeasleyTwin();
}

event PlayerInput (float DeltaTime)
{
}

function DoEngageVendor (name nameSaveState)
{
	local StatusGroup sgJellyBeans;
	local string strItemTexture;

	nameVendorSavedState = nameSaveState;
	if ( Vendor.CutName == "" )
	{
		strVendorSavedCutName = Vendor.CutName;
	}
	Vendor.CutName = strTEMP_VENDOR_CUT_NAME;
	if ( textureVendorBarLeft == None )
	{
		//log("Loading textureVendorBarLeft");
		textureVendorBarLeft 		= Texture(DynamicLoadObject(strVENDORBAR_LEFT,Class'Texture'));
		//log(textureVendorBarLeft.name);
		//log("Loading textureVendorBarRight");
		textureVendorBarRight 		= Texture(DynamicLoadObject(strVENDORBAR_RIGHT,Class'Texture'));
		//log(textureVendorBarRight.name);
		textureVendorButtonNormal 	= Texture(DynamicLoadObject(strVENDORBAR_BUTTON_NORMAL,Class'Texture'));
		textureVendorButtonOver 	= Texture(DynamicLoadObject(strVENDORBAR_BUTTON_OVER,Class'Texture'));
		switch (Vendor.CharacterSells)
		{
			case Vendor.ESells.Sells_Nimbus2001:
				strItemTexture = strVENDORITEM_NIMBUS;
				break;
			case Vendor.ESells.Sells_QArmor:
				strItemTexture = strVENDORITEM_QARMOR;
				break;
			case Vendor.ESells.Sells_WBark:
				strItemTexture = strVENDORITEM_WBARK;
				break;
			case Vendor.ESells.Sells_FMucus:
				strItemTexture = strVENDORITEM_FMUCUS;
				break;
			case Vendor.ESells.Sells_BronzeCards:
				strItemTexture = strVENDORITEM_BRONZECARD;
				break;
			case Vendor.ESells.Sells_SilverCards:
				strItemTexture = strVENDORITEM_SILVERCARD;
				break;
			case Vendor.ESells.Sells_Duel:
				strItemTexture = strVENDORITEM_WIZDUEL;
				break;
			default:
				break;
		}
		textureItemToSell = Texture(DynamicLoadObject(strItemTexture,Class'Texture'));
	}
	strYes = Localize("All",strID_YES,"HPMenu");
	strNo = Localize("All",strID_NO,"HPMenu");
	
	HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterVendorManager(self);
	harry(Level.PlayerHarryActor).StartVendorEngagement(self);
	
	sgJellyBeans = harry(Level.PlayerHarryActor).managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
	sgJellyBeans.SetEffectTypeToPermanent();
	sgJellyBeans.SetCutSceneRenderMode(True);
	
	Level.PlayerHarryActor.CutNotifyActor = self;
	harry(Level.PlayerHarryActor).Cam.CutNotifyActor = self;
	Vendor.CutNotifyActor = self;
	
	Level.PlayerHarryActor.CutCommand(strCAPTURE_COMMAND);
	harry(Level.PlayerHarryActor).Cam.CutCommand(strCAPTURE_COMMAND);
	Vendor.CutCommand(strCAPTURE_COMMAND);
	
	nItemsBoughtInCurrTransaction = 0;
	nCurrPrice = Vendor.GetSellingPrice();
	//log(textureVendorBarRight.name);
	GotoState('EngageVendor');
}

function string GetAnimParam()
{
	switch (Rand(3))
	{
		case 0:
			return strRIGHTHAND_ANIM_PARAM;
		case 1:
			return strLEFTHAND_ANIM_PARAM;
		case 2:
			return strBOTHHANDS_ANIM_PARAM;
		default:
	}
}

function SetConsoleVendorBarFlags (bool bSet)
{
	HPConsole(Level.PlayerHarryActor.Player.Console).bVendorBar = bSet;
	HPConsole(Level.PlayerHarryActor.Player.Console).bUWindowActive = bSet;
	HPConsole(Level.PlayerHarryActor.Player.Console).Viewport.bShowWindowsMouse = bSet;
}

function DoCutTalk (Actor actorTalk, string strDialogID, string strTalkAnimName, string strLoopAnimName, string strIndefiniteParam, string strCue)
{
	local string strDialog;
	local TimedCue tcue;
	local float fSoundLen;

	if ( strDialogID == "" )
	{
		CutCue(strCue);
	} 
	else if (  !Vendor.IsDuelVendor() )
    {
		actorTalk.CutCommand(strTALK_COMMAND $strDialogID $strTalkAnimName $strLoopAnimName $strIndefiniteParam,strCue);
    }
	else 
	{
		strDialog = (Localize("All",strDialogID,"HPMenu"));
		fSoundLen = (Len(strDialog) * 0.01) + 3.0;
		if ( strIndefiniteParam == "" )
		{
			tcue = Spawn(Class'TimedCue');
			tcue.CutNotifyActor = self;
			tcue.SetupTimer(fSoundLen + 0.5,strCue);
			harry(Level.PlayerHarryActor).ClientMessage("Indefinite");
			harry(Level.PlayerHarryActor).myHUD.SetSubtitleText(strDialog,fSoundLen);
		} 
		else 
		{
			harry(Level.PlayerHarryActor).myHUD.SetSubtitleText(strDialog,0.0);
			CutCue(strCue);
		}
    }
}

function DoNarratorInstructions()
{
	if ( Vendor.GetVendorInstructionId() == "" )
	{
		CutCue(strCUE_INSTRUCTIONS);
	} 
	else if ( Vendor.IsDuelVendor() )
    {
		DoCutTalk(Level.PlayerHarryActor,Vendor.GetVendorInstructionId(),"","",strINDEFINITE_TEXT_PARAM,strCUE_INSTRUCTIONS);
    } 
	else 
	{
		CutCommand(strSAY_COMMAND $Vendor.GetVendorInstructionId() $strINDEFINITE_TEXT_PARAM,strCUE_INSTRUCTIONS);
    }
}

function bool WantInstructions()
{
	return (harry(Level.PlayerHarryActor).bSaidVendorInstructions == False || Vendor.IsDuelVendor());
}

auto state Idle
{
}

state EngageVendor
{	
	function CutCue (string cue)
	{
		local string strStayUpText;
		local float fSoundLenDummy;
  
		if ( cue ~= strCUE_VENDOR_TURN_DONE )
		{
			harry(Level.PlayerHarryActor).Cam.CutCommand(strFLYTO_COMMAND $Vendor.CutName $" x=80 y=80");
			harry(Level.PlayerHarryActor).Cam.CutCommand(strTARGET_FLYTO_COMMAND $Vendor.CutName $" x=10 z=10",strCUE_CAMERA_IN_POSITION);
			WeasleyTwin = WeasTwin;//Vendor.GetWeasleyTwin();
			if ( WeasleyTwin != None )
			{
				WeasleyTwin.GotoState('stateIdle');
			}
		} 
		else if ( cue ~= strCUE_CAMERA_IN_POSITION )
		{
			DoCutTalk(Level.PlayerHarryActor,Vendor.GetVendorHarryInquiryId(),strQUESTION_ANIM_PARAM,"","",strCUE_HARRY_INQUIRY);
		} 
		else if ( cue ~= strCUE_HARRY_INQUIRY )
		{
			if ( Vendor.HaveSomethingToSell() )
			{
				if ( WantInstructions() )
				{
					DoCutTalk(Vendor,Vendor.GetSellDialogId(),GetAnimParam(),strVENDOR_WAIT_ANIM_PARAM,"",strCUE_IHAVE_X);
				} 
				else 
				{
					DoCutTalk(Vendor,Vendor.GetSellDialogId(),GetAnimParam(),strVENDOR_WAIT_ANIM_PARAM,strINDEFINITE_TEXT_PARAM,strCUE_IHAVE_X);
				}
			} 
			else 
			{
				DoCutTalk(Vendor,Vendor.GetVendorOutOfStockId(),GetAnimParam(),"","",strCUE_OUT_OF_STOCK);
			}
        } 
		else if ( cue ~= strCUE_OUT_OF_STOCK )
		{
			DoDisengageVendor();
		} 
		else if ( cue ~= strCUE_IHAVE_X )
		{
			if ( WantInstructions() )
			{
				DoNarratorInstructions();
                harry(Level.PlayerHarryActor).bSaidVendorInstructions = True;
			} 
			else 
			{
				GotoState('VendorTransaction');
			}
		} 
		else if ( cue ~= strCUE_INSTRUCTIONS )
		{
			GotoState('VendorTransaction');
		}
	}
  
	begin:
		Level.PlayerHarryActor.Acceleration = vect(0.00,0.00,0.00);
		Level.PlayerHarryActor.Velocity *= vect(0.00,0.00,1.00);
		harry(Level.PlayerHarryActor).TurnTo(Level.PlayerHarryActor.Location + (Vendor.Location - Level.PlayerHarryActor.Location) * vect(1.00,1.00,0.00));
		Vendor.CutCommand(strFACE_HARRY_COMMAND,strCUE_VENDOR_TURN_DONE);
		//WeasleyTwin = Vendor.GetWeasleyTwin();
		WeasleyTwin = WeasTwin;
		if ( WeasleyTwin != None )
		{
			WeasleyTwin.GotoState('stateIdle');
			WeasleyTwin.CutCommand(strFACE_HARRY_COMMAND);
		}
}

state VendorTransaction
{
	function RenderHud (Canvas canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		local StatusGroup sgJellyBeans;
  
		sgJellyBeans = harry(Level.PlayerHarryActor).managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
		sgJellyBeans.RenderHudItemManager(canvas,bMenuMode,bFullCutMode,bHalfCutMode);
		DrawVendorBar(canvas);
	}
  
	function CutCue (string cue)
	{
		if ( cue ~= strCUE_TRANSACTION_DONE || cue ~= strCUE_DECLINE_SALE || cue ~= strCUE_OUT_OF_STOCK )
		{
		DoDisengageVendor();
		}
	}
  
	event PlayerInput (float fDeltaTime)
	{
		if (  !HPConsole(Level.PlayerHarryActor.Player.Console).Viewport.bShowWindowsMouse )
		{
			return;
		}
		if ( (harry(Level.PlayerHarryActor).bVendorReply == 1) && IsMouseOverVendorYes() )
		{
			Level.PlayerHarryActor.PlaySound(Sound'ss_gui_rotatebut_0003');
			SetConsoleVendorBarFlags(False);
			if (  !Vendor.HaveSomethingToSell() )
			{
				DoCutTalk(Vendor,Vendor.GetVendorOutOfStockId(),GetAnimParam(),"","",strCUE_OUT_OF_STOCK);
			} 
			else if (  !HarryHasEnoughBeans(nCurrPrice) )
			{
				GotoState('NotEnoughBeans');
			} 
			else 
			{
				nItemsBoughtInCurrTransaction++;
				GotoState('MakePurchase');
			}
		} 
		else if ( (harry(Level.PlayerHarryActor).bVendorReply == 1) && IsMouseOverVendorNo() )
		{
			Level.PlayerHarryActor.PlaySound(Sound'ss_gui_rotatebut_0002');
			SetConsoleVendorBarFlags(False);
			if ( nItemsBoughtInCurrTransaction > 0 )
			{
				DoCutTalk(Vendor,Vendor.GetVendorTransactionDoneId(),GetAnimParam(),"","",strCUE_TRANSACTION_DONE);
			} 
			else 
			{
				DoCutTalk(Vendor,Vendor.GetVendorDeclineId(),GetAnimParam(),"","",strCUE_DECLINE_SALE);
			}
		}
	}
  
	event BeginState()
	{
		SetConsoleVendorBarFlags(True);
	}
  
	event EndState()
	{
		SetConsoleVendorBarFlags(False);
	}
  
	begin:
		Vendor.LoopAnim('vendor_idle2',RandRange(0.81,1.25),0.2);
}

state MakePurchase
{
	function Tick (float fDeltaTime)
	{
		if ( fTickDelta > 0.0 )
		{
			if ( nSubtractBeans > 0 )
			{
				if ( nSubtractBeans >= nMinusBeansPerTick )
				{
					managerStatus.IncrementCount(Class'StatusGroupJellybeans',Class'StatusItemJellybeans', -nMinusBeansPerTick);
					nSubtractBeans -= nMinusBeansPerTick;
				} 
				else 
				{
					managerStatus.IncrementCount(Class'StatusGroupJellybeans',Class'StatusItemJellybeans', -nSubtractBeans);
					nSubtractBeans = 0;
				}
			}
		}
		else 
		{
			fTickDelta = fDeltaTime;
		}
	}
  
	function RenderHud (Canvas canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		local StatusGroup sgJellyBeans;
  
		sgJellyBeans = harry(Level.PlayerHarryActor).managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
		sgJellyBeans.RenderHudItemManager(canvas,bMenuMode,bFullCutMode,bHalfCutMode);
	}
  
	function CutCue (string cue)
	{
		if ( cue ~= strCUE_ITEM_SOLD )
		{
			if ( Vendor.IsDuelVendor() )
			{
				Vendor.DuelRank = 0;
			}
			if (  !Vendor.HaveSomethingToSell() )
			{
				DoCutTalk(Vendor,Vendor.GetVendorTransactionDoneId(),GetAnimParam(),"","",strCUE_TRANSACTION_DONE);
			}
			else 
			{
				GotoState('VendorTransaction');
			}
		} 
		else if ( cue ~= strCUE_TRANSACTION_DONE )
		{
			DoCutTalk(Vendor,Vendor.GetVendorOutOfStockId(),GetAnimParam(),"","",strCUE_OUT_OF_STOCK);
		} 
		else if ( cue ~= strCUE_OUT_OF_STOCK )
        {
			DoDisengageVendor();
        }
	}
  
	event BeginState()
	{
		managerStatus = harry(Level.PlayerHarryActor).managerStatus;
	}
  
	begin:
		while (fTickDelta <= 0.0 )
		{
			Sleep(0.1);
		}
	
		nSubtractBeans = nCurrPrice;
		fTicksPerSec = 1.0 / fTickDelta;
		nMinusBeansPerTick = nCurrPrice / (1.5 * fTicksPerSec);
	
		if ( nMinusBeansPerTick < 1 )
		{
			nMinusBeansPerTick = 1;
		}
	
		while ( nSubtractBeans > 0 )
		{
			Sleep(0.1);
		}
		if ( Vendor.IsDuelVendor() )
		{
			if ( Vendor.IsDuelVendor() && (Vendor.DuelLevelTrigger != None) )
			{
				harry(Level.PlayerHarryActor).DuelRankOppon = Vendor.DuelRank;
				harry(Level.PlayerHarryActor).DuelRankBeans = Vendor.DuelBeans;
				Vendor.DuelLevelTrigger.ProcessTrigger();
			}
		}
		Vendor.CutCommand("SellVendorItem" $GetAnimParam(),strCUE_ITEM_SOLD);
}

state NotEnoughBeans
{
	function RenderHud (Canvas canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		local StatusGroup sgJellyBeans;
  
		sgJellyBeans = harry(Level.PlayerHarryActor).managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
		sgJellyBeans.RenderHudItemManager(canvas,bMenuMode,bFullCutMode,bHalfCutMode);
	}
  
	function CutCue (string cue)
	{
		if ( cue ~= strCUE_RAN_OUT_OF_BEANS || cue ~= strCUE_NOT_ENOUGH_BEANS )
		{
			DoDisengageVendor();
		}
	}
  
	begin:
		if ( nItemsBoughtInCurrTransaction == 0 )
		{
			DoCutTalk(Vendor,Vendor.GetVendorNotEnoughBeansId(),GetAnimParam(),"","",strCUE_NOT_ENOUGH_BEANS);
		} 
		else 
		{
			DoCutTalk(Vendor,Vendor.GetVendorRanOutOfBeansId(),GetAnimParam(),"","",strCUE_RAN_OUT_OF_BEANS);
		}
}

function DoDisengageVendor()
{
	local StatusGroup sgJellyBeans;
	//local Characters WeasleyTwin;

	harry(Level.PlayerHarryActor).Cam.CutCommand(strRELEASE_COMMAND);
	harry(Level.PlayerHarryActor).Cam.CutNotifyActor = None;
	Level.PlayerHarryActor.CutCommand(strRELEASE_COMMAND);
	Level.PlayerHarryActor.CutNotifyActor = None;
	Vendor.CutCommand(strRELEASE_COMMAND);
	Vendor.CutNotifyActor = None;
	harry(Level.PlayerHarryActor).EndVendorEngagement();
	sgJellyBeans = harry(Level.PlayerHarryActor).managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
	sgJellyBeans.SetEffectTypeToNormal();
	sgJellyBeans.SetCutSceneRenderMode(True);
	Vendor.DesiredRotation = Vendor.rSave;
	Vendor.GotoState('VendorIdle');
	Vendor.CutName = strVendorSavedCutName;
	WeasleyTwin = WeasTwin;//Vendor.GetWeasleyTwin();
	if ( WeasleyTwin != None )
	{
		WeasleyTwin.DesiredRotation = WeasleyTwin.rSave;
		WeasleyTwin.GotoState('VendorIdle');
	}
	GotoState('Idle');
}

function bool HarryHasEnoughBeans (int nPrice)
{
	local StatusItem siBeans;

	siBeans = harry(Level.PlayerHarryActor).managerStatus.GetStatusItem(Class'StatusGroupJellybeans',Class'StatusItemJellybeans');
	return (siBeans.nCount >= nPrice);
}

function RenderHud (Canvas canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
}

function DrawVendorBar (Canvas canvas)
{
	local Texture textureYesButton;
	local Texture textureNoButton;
	local float fBarX;
	local float fBarY;
	local string strCurrPrice;
	local Color colorSave;
	local Font fontSave;
	local float fXTextLen;
	local float fYTextLen;
	local float fScaleFactor;
	local StatusItem siJellybeans;
	local Color colorText;
	local Color colorTextShadow;
	
	local float Offset;
	
	HScale = Class'M212HScale'.Static.CanvasGetHeightScale(Canvas);
	
	// Metallicafan212:	This needs to be offset to be in the center again
	//Offset = (256 - (256 * HScale)) * 2.0;

	VendorCanvas = Canvas;
	fontSave = Canvas.Font;
	fScaleFactor = Canvas.GetHudScaleFactor();
	if ( IsMouseOverVendorYes() )
	{
		textureYesButton = textureVendorButtonOver;
		textureNoButton = textureVendorButtonNormal;
	} 
	else if ( IsMouseOverVendorNo() )
    {
		textureYesButton = textureVendorButtonNormal;
		textureNoButton = textureVendorButtonOver;
    } 
	else 
	{
		textureYesButton = textureVendorButtonNormal;
		textureNoButton = textureVendorButtonNormal;
    }
	
	fBarX = GetVendorBarX(Canvas); //+ Offset;
	fBarY = GetVendorBarY(Canvas) * HScale;
	
	// Metallicafan212:	Left side
	canvas.SetPos(fBarX, fBarY);	
	canvas.DrawIcon(textureVendorBarLeft, fScaleFactor * HScale);
	
	// Metallicafan212: Right side, but we need to shift over
	canvas.SetPos(fBarX + (256 * fScaleFactor * HScale), fBarY);
	canvas.DrawIcon(textureVendorBarRight, fScaleFactor * HScale); 
	
	// Metallicafan212:	What they're selling
	canvas.SetPos(fBarX + (fVENDORBAR_PURCHASE_ITEM_X * fScaleFactor * HScale), fBarY + (fVENDORBAR_PURCHASE_ITEM_Y * fScaleFactor * HScale));
	canvas.DrawIcon(textureItemToSell, fScaleFactor * HScale);
	
	// Metallicafan212:	Yes button
	canvas.SetPos(fBarX + (fVENDORBAR_YESBUTTON_X * fScaleFactor * HScale), fBarY + (fVENDORBAR_YESBUTTON_Y * fScaleFactor * HScale));
	canvas.DrawIcon(textureYesButton, fScaleFactor * HScale); 
	
	// Metallicafan212:	No button
	canvas.SetPos(fBarX + (fVENDORBAR_NOBUTTON_X * fScaleFactor * HScale), fBarY + (fVENDORBAR_NOBUTTON_Y * fScaleFactor * HScale));
	canvas.DrawIcon(textureNoButton, fScaleFactor * HScale);
	
	// Metallicafan212:	Bean count
	siJellybeans 	= harry(Level.PlayerHarryActor).managerStatus.GetStatusItem(Class'StatusGroupStars',Class'StatusItemStars');
	Canvas.Font 	= siJellybeans.GetCountFont(Canvas);
	colorText 		= siJellybeans.GetCountColor();
	colorTextShadow = siJellybeans.GetCountColor(True);
	
	// Metallicafan212:	Yes line
	Canvas.TextSize(strYes, fXTextLen, fYTextLen);
	Canvas.SetPos(fBarX + (fVENDORBAR_YESBUTTON_X * fScaleFactor * HScale) + (fVENDORBAR_BUTTON_TEXT_X * fScaleFactor * HScale) - (fXTextLen / 2), fBarY + (fVENDORBAR_YESBUTTON_Y * fScaleFactor * HScale) + (fVENDORBAR_BUTTON_TEXT_Y * fScaleFactor * HScale) - (fYTextLen / 2));
	Canvas.DrawShadowText(strYes,colorText,colorTextShadow);
	
	// Metallicafan212:	No text
	Canvas.TextSize(strNo,fXTextLen,fYTextLen);
	Canvas.SetPos(fBarX + (fVENDORBAR_NOBUTTON_X * fScaleFactor * HScale) + (fVENDORBAR_BUTTON_TEXT_X * fScaleFactor * HScale) - (fXTextLen / 2), fBarY + (fVENDORBAR_NOBUTTON_Y * fScaleFactor * HScale) + (fVENDORBAR_BUTTON_TEXT_Y * fScaleFactor * HScale) - (fYTextLen / 2));
	Canvas.DrawShadowText(strNo,colorText,colorTextShadow);
	
	// Metallicafan212:	Price text
	strCurrPrice = string(nCurrPrice);
	Canvas.TextSize(strCurrPrice, fXTextLen, fYTextLen);
	Canvas.SetPos(fBarX + (fVENDORBAR_PRICE_X * fScaleFactor * HScale) - fXTextLen / 2, fBarY + (fVENDORBAR_PRICE_Y * fScaleFactor * HScale) - fYTextLen / 2);
	Canvas.DrawShadowText(strCurrPrice, colorText, colorTextShadow);
	
	Canvas.Font = fontSave;
}

function float GetVendorBarX (Canvas canvas)
{
	// Metallicafan212:	Add the offset
	local float offset;
	
	HScale = Class'M212HScale'.Static.CanvasGetHeightScale(Canvas);
	
	// Metallicafan212:	This needs to be offset to be in the center again
	Offset = (256.0 / HScale) - (256.0 * HScale);//(256 - (256 * HScale)) * 2.0;
	
	return ((canvas.SizeX / 2.0) - (canvas.GetHudScaleFactor() * (fVENDORBAR_W / 2.0))) + Offset;
}

function float GetVendorBarY (Canvas canvas)
{
	return (canvas.GetHudScaleFactor() * fVENDORBAR_Y);
}

function bool IsMouseOverVendorYes()
{
	return (IsMouseOverVendorButton(fVENDORBAR_YESBUTTON_X * HScale, fVENDORBAR_YESBUTTON_Y * HScale, fVENDORBAR_BUTTON_W, fVENDORBAR_BUTTON_H));
}

function bool IsMouseOverVendorNo ()
{	
	return (IsMouseOverVendorButton(fVENDORBAR_NOBUTTON_X * HScale, fVENDORBAR_NOBUTTON_Y * HScale, fVENDORBAR_BUTTON_W, fVENDORBAR_BUTTON_H));
}

function bool IsMouseOverVendorButton (int nLeft, int nTop, int nWidth, int nHeight)
{
	local HPConsole hpCon;
	local int nVendorMouseX;
	local int nVendorMouseY;
	local float fScaleFactor;
	//local float Offset;
	
	//Offset = 256 - (256 * HScale);
	
	hpCon 			= HPConsole(Level.PlayerHarryActor.Player.Console);
	fScaleFactor 	= VendorCanvas.GetHudScaleFactor();
	nVendorMouseX 	= hpCon.MouseX * hpCon.Root.GUIScale;
	nVendorMouseY 	= hpCon.MouseY * hpCon.Root.HGUIScale;//hpCon.Root.GUIScale;
	nLeft 	*= fScaleFactor;
	nTop 	*= fScaleFactor;
	nWidth 	*= fScaleFactor * HScale;
	nHeight *= fScaleFactor * HScale;
	nLeft 	+= GetVendorBarX(VendorCanvas);
	nTop 	+= GetVendorBarY(VendorCanvas) * HScale;
	if( (nVendorMouseX >= nLeft) && (nVendorMouseX <= (nLeft + nWidth)) )
	{
		return ((nVendorMouseY >= nTop) && (nVendorMouseY <= (nTop + nHeight)));
	} 
	else
	{
		return False;
	}
}

event Tick (float fDeltaTime)
{
	Super.Tick(fDeltaTime);
	if ( HPConsole(Level.PlayerHarryActor.Player.Console).bVendorBar )
	{
		SetConsoleVendorBarFlags(True);
	}
}

defaultproperties
{
    bHidden=True

	DrawType=DT_None
}
