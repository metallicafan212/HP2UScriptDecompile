//================================================================================
// StatusGroup.
//================================================================================

class StatusGroup extends Actor
	Abstract;

enum EMenuProps 
{
	Menu_Always,
	Menu_IfEverHadAny,
	Menu_IfCurrentlyHaveAny,
	Menu_Never
};

enum EEffectType 
{
	ET_Fade,
	ET_Fly,
	ET_Permanent,
	ET_Menu
};

var StatusGroup sgNext;
var StatusItem siList;
var StatusManager smParent;
var float fCurrEffectInTime;
var float fCurrEffectOutTime;
var EEffectType CurrEffectType;
var bool bDisplayJustFirstItem;
var bool bDisplayHorizontally;
var int nSpaceBetweenIcons;
var float fTotalEffectInTime;
var float fTotalHoldTime;
var float fTotalEffectOutTime;
var EEffectType GameEffectType;
var bool bDisplayOnMenu;
var EMenuProps MenuProps;
var bool bNormallyRenderInCutScene;
var bool bCurrRenderInCutScene;

const FLY_TO_HUD_CAM_DIST= 150;
const BASE_RESOLUTION_X= 640.0;

function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode,Canvas.SizeX,Canvas.SizeY,nIconWidth,nIconHeight,nOutX,nOutY);
}

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	Log("Error:  Derived StatusGroup objects should override GetGroupFinalXY_2");
	nOutX = 0;
	nOutY = 0;
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	Log("Error:  Derived StatusGroup objects should override GetGroupFlyOriginXY");
	nOutX = 0;
	nOutY = 0;
}

function SetEffectTypeToPermanent ()
{
	CurrEffectType = ET_Permanent;
	SetTimer(0.0,False);
	GotoState('Hold');
}

function SetEffectTypeToNormal ()
{
	CurrEffectType = GameEffectType;
	GotoState('Idle');
}

function SetCutSceneRenderModeToNormal ()
{
	bCurrRenderInCutScene = bNormallyRenderInCutScene;
}

function SetCutSceneRenderMode (bool bRenderInCutScenes)
{
	bCurrRenderInCutScene = bRenderInCutScenes;
}

function StatusItem GetStatusItem (Class<StatusItem> classItem)
{
	local StatusItem siLoop;

	if ( siList == None )
	{
		siList = Spawn(classItem);
		siList.sgParent = self;
		return siList;
	}
	
	// Metallicafan212:	This is obiously a loop
	for(siLoop = siList; siLoop != None; siLoop = siLoop.siNext)
	{
		if ( siLoop.Class == classItem )
		{
			return siLoop;
		}
		if ( siLoop.siNext == None )
		{
			siLoop.siNext = Spawn(classItem);
			siLoop.siNext.sgParent = self;
			return siLoop.siNext;
		}
	}
	
	/*
	//siLoop = siList;
	if ( siLoop != None )
	{
		if ( siLoop.Class == classItem )
		{
			return siLoop;
		}
		if ( siLoop.siNext == None )
		{
			siLoop.siNext = Spawn(classItem);
			siLoop.siNext.sgParent = self;
			return siLoop.siNext;
		}
		siLoop = siLoop.siNext;
		goto JL003A;
	}
	*/
	Log("Error: StatusGroup::GetStatusItem- should not get to here");
	return None;
}

function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
{
	local StatusItem siLoop;
	local int nCurrX;
	local int nCurrY;
	local bool bFirstIconInList;
	local Color colorSave;
	local float fScaleFactor;
	local bool bIncrementPosition;

	nCurrX = 0;
	nCurrY = 0;
	bFirstIconInList = True;
	fScaleFactor = GetScaleFactor(Canvas.SizeX);
	if ( bMenuMode )
	{
		return;
	}
	if (  !bMenuMode &&  !bCurrRenderInCutScene && bFullCutMode )
	{
		return;
	}
	HandleMenuModeSwitching(bMenuMode);
	colorSave = Canvas.DrawColor;
	Canvas.DrawColor = GetDrawColor();
	
	// Metallicafan212:	Again, this is a loop
	for(siLoop = siList; siLoop != none; siLoop = siLoop.siNext)
	{
		if ( bMenuMode ||  !bMenuMode && (siLoop.bMenuModeOnly == False) )
		{
			if ( bFirstIconInList == True )
			{
				GetGroupCurrXY(bMenuMode, Canvas,siLoop.GetHudIconUSize(), siLoop.GetHudIconVSize(), nCurrX, nCurrY);
				bFirstIconInList = False;
			}
			if ( (siLoop.nCount > 0) || (siLoop.nCount == 0) && (siLoop.bDisplayWhenCountZero == True) )
			{
				siLoop.DrawItem(Canvas, nCurrX, nCurrY, fScaleFactor);
				bIncrementPosition = True;
			} 
			else 
			{
				bIncrementPosition = siLoop.bIncrementPosWhenCountZero;
			}
			if ( bIncrementPosition )
			{
				if ( bDisplayHorizontally )
				{
					nCurrX += fScaleFactor * (siLoop.GetHudIconUSize() + nSpaceBetweenIcons);
				}
				else
				{
					nCurrY += fScaleFactor * (siLoop.GetHudIconVSize() + nSpaceBetweenIcons);
				}
			}
			
			// Metallicafan212:	From the proto
			if (bDisplayJustFirstItem)
            {
				//the log bit got removed between proto and retail(probably because it spams the log) -AdamJD
                //log("displayjustfirst");
			    break;
            }
			
		}
	}
	
	/*
	siLoop = siList;
	if ( siLoop != None )
	{
		if ( bMenuMode ||  !bMenuMode && (siLoop.bMenuModeOnly == False) )
		{
			if ( bFirstIconInList == True )
			{
				GetGroupCurrXY(bMenuMode,Canvas,siLoop.GetHudIconUSize(),siLoop.GetHudIconVSize(),nCurrX,nCurrY);
				bFirstIconInList = False;
			}
			if ( (siLoop.nCount > 0) || (siLoop.nCount == 0) && (siLoop.bDisplayWhenCountZero == True) )
			{
				siLoop.DrawItem(Canvas,nCurrX,nCurrY,fScaleFactor);
				bIncrementPosition = True;
			} 
			else 
			{
				bIncrementPosition = siLoop.bIncrementPosWhenCountZero;
			}
			if ( bIncrementPosition )
			{
				if ( bDisplayHorizontally )
				{
					nCurrX += fScaleFactor * byte((siLoop.GetHudIconUSize() + nSpaceBetweenIcons)) = );
					nCurrY += fScaleFactor * byte((siLoop.GetHudIconVSize() + nSpaceBetweenIcons)) = );
					// There are 2 jump destination(s) inside the last statement!
					{
						goto JL022E;
					}
				}
			}
		}
		siLoop = siLoop.siNext;
		goto JL00A0;
	}
	*/
	Canvas.DrawColor = colorSave;
}

function HandleMenuModeSwitching (bool bMenuMode)
{
	if ( bMenuMode )
	{
		CurrEffectType = ET_Menu;
		if (!IsInState('Hold'))
		{
			GotoState('Hold');
		}
	} 
	else 
	{
		if ( CurrEffectType == ET_Menu )
		{
			CurrEffectType = GameEffectType;
			if (  !IsInState('Idle') && (CurrEffectType != 2) )
			{
				GotoState('Idle');
			}
		}
	}
}

function GetItemPosition (Class<StatusItem> classItem, bool bMenuMode, out int nOutX, out int nOutY, optional int nCanvasSizeX, optional int nCanvasSizeY)
{
	local StatusItem si;
	local StatusItem siLoop;
	local bool bFirstInList;
	local float fScaleFactor;

	nOutX = 0;
	nOutY = 0;
	if ( nCanvasSizeX == 0 )
	{
		nCanvasSizeX = smParent.nCanvasSizeX;
	}
	if ( nCanvasSizeY == 0 )
	{
		nCanvasSizeY = smParent.nCanvasSizeY;
	}
	bFirstInList = True;
	fScaleFactor = GetScaleFactor(nCanvasSizeX);
	si = GetStatusItem(classItem);
	if ( si == None )
	{
		Log("Error:  Could not get StatusItem " $ string(classItem));
	}
	
	// Metallicafan212:	Loop loops loops
	for(siLoop = siList; siLoop != none; siLoop = siLoop.siNext)
	{
		if ( bFirstInList == True )
		{
			GetGroupCurrXY_2(bMenuMode,nCanvasSizeX,nCanvasSizeY,siLoop.GetHudIconUSize(),siLoop.GetHudIconVSize(),nOutX,nOutY);
			bFirstInList = False;
		}
		if ( siLoop.Class == si.Class )
		{
			//goto JL01B5;
			break;
		}
		if ( bDisplayHorizontally )
		{
			nOutX += fScaleFactor * (siLoop.GetHudIconUSize() + nSpaceBetweenIcons);
		}
		else
		{
			nOutY += fScaleFactor * (siLoop.GetHudIconVSize() + nSpaceBetweenIcons);
		}
		
		// Metallicafan212:	From the proto
		if (bDisplayJustFirstItem)
		    break;
	}
	
	/*
	siLoop = siList;
	if ( siLoop != None )
	{
		if ( bFirstInList == True )
		{
			GetGroupCurrXY_2(bMenuMode,nCanvasSizeX,nCanvasSizeY,siLoop.GetHudIconUSize(),siLoop.GetHudIconVSize(),nOutX,nOutY);
			bFirstInList = False;
		}
		if ( siLoop.Class == si.Class )
		{
			goto JL01B5;
		}
		if ( bDisplayHorizontally )
		{
			nOutX += fScaleFactor * byte((siLoop.GetHudIconUSize() + nSpaceBetweenIcons)) = );
			nOutY += fScaleFactor * byte((siLoop.GetHudIconVSize() + nSpaceBetweenIcons)) = );
			// There are 1 jump destination(s) inside the last statement!
			{
			goto JL01B5;
			}
		}
		siLoop = siLoop.siNext;
		goto JL00B9;
	}
	*/
}

function Vector GetItemLocation (Class<StatusItem> classItem, bool bMenuMode, optional bool bUpperLeft)
{
	local int nHudX;
	local int nHudY;
	local int nCanvasHalfX;
	local int nCanvasHalfY;
	local float fXVal;
	local float fYVal;
	local Vector vectReturn;
	local float fCameraPitch;
	local StatusItem si;

	GetItemPosition(classItem,bMenuMode,nHudX,nHudY);
	if (  !bUpperLeft )
	{
		si = GetStatusItem(classItem);
		nHudX += si.GetHudIconUSize() / 4.0;
		nHudY += si.GetHudIconVSize() / 4.0;
	}
	nCanvasHalfX = smParent.nCanvasSizeX / 2.0;
	nCanvasHalfY = smParent.nCanvasSizeY / 2.0;
	if ( nHudX >= nCanvasHalfX )
	{
		// fXVal = float(nHudX - nCanvasHalfX) / float(nCanvasHalfX);
		fXVal = (nHudX - nCanvasHalfX) / float(nCanvasHalfX); //removed wrong float casts -AdamJD
	} 
	else 
	{
		// fXVal =  -1.0 - float(nHudX) / float(nCanvasHalfX);
		fXVal =  -(1.0 - (nHudX / float(nCanvasHalfX))); //removed wrong float casts -AdamJD
	}
	if ( nHudY <= nCanvasHalfY )
	{
		// fYVal = 1.0 - float(nHudY) / float(nCanvasHalfY);
		fYVal = 1.0 - (nHudY / float(nCanvasHalfY)); //removed wrong float casts -AdamJD
	} 
	else 
	{
		// fYVal =  -1 - float((nHudY - nCanvasHalfY)) / float(nCanvasHalfY);
		fYVal =  -(1 - ((nHudY - nCanvasHalfY) / float(nCanvasHalfY))); //removed wrong float casts -AdamJD
	}
	fCameraPitch = Normalize(smParent.PlayerHarry.Cam.Rotation).Pitch;
	if ( fCameraPitch > 32768 )
	{
		// fYVal = fYVal - 1.0 - fCameraPitch / 65536;
		fYVal = fYVal - (1.0 - (fCameraPitch / 65536)); //added BODMAS -AdamJD
	} 
	else 
	{
		// fYVal = fYVal + fCameraPitch / 65536;
		fYVal = fYVal + (fCameraPitch / 65536); //added BODMAS -AdamJD
	}
	vectReturn.X = fXVal;
	vectReturn.Y = fYVal;
	vectReturn.Z = 150.0;
	vectReturn = smParent.PlayerHarry.CameraToWorld(vectReturn);
	return vectReturn;
}

function Color GetDrawColor ()
{
	local Color colorReturn;
	local int nFadeValue;

	nFadeValue 		= GetFadeValue();
	colorReturn.R 	= nFadeValue;
	colorReturn.G 	= nFadeValue;
	colorReturn.B 	= nFadeValue;
	return colorReturn;
}

function GetGroupCurrXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nX, out int nY)
{
	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nX, nY);
}

function GetGroupCurrXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, nCanvasSizeX, nCanvasSizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}

function int GetFadeValue ()
{
	return 255;
}

function bool IncrementCount (Class<StatusItem> classItem, int nNum)
{
	local StatusItem siUpdate;

	siUpdate = GetStatusItem(classItem);
	if ( siUpdate != None )
	{
		siUpdate.IncrementCount(nNum);
		OnCountIncremented();
		return True;
	}
	return False;
}

function bool IncrementCountPotential (Class<StatusItem> classItem, int nNum)
{
	local StatusItem siUpdate;

	siUpdate = GetStatusItem(classItem);
	if ( siUpdate != None )
	{
		siUpdate.IncrementCountPotential(nNum);
		OnCountIncremented();
		return True;
	}
	return False;
}

function OnCountIncremented ()
{
}

function float GetTimeRatio (float fCurrTime, float fTotalTime)
{
	if ( fTotalTime < fCurrTime )
	{
		return 1.0;
	} 
	else 
	{
		return (fTotalTime - fCurrTime) / fTotalTime;
	}
}

function int CalcFadeValue (bool bIn, float fCurrTime, float fTotalTime)
{
	local float fFadeRatio;
	local int nFadeValue;

	fFadeRatio = GetTimeRatio(fCurrTime,fTotalTime);
	if (bIn)
	{
		nFadeValue = 127 + (128 * fFadeRatio);
		if ( Clamp(nFadeValue, 127, 255) != nFadeValue )
		{
			Log("Error:  Error in fade value calculation");
			nFadeValue = Clamp(nFadeValue, 127, 255);
		}
	} 
	else 
	{
		nFadeValue = 255 - (128 * fFadeRatio);
		if ( Clamp(nFadeValue, 127, 255) != nFadeValue )
		{
			Log("Error:  Fade value should never be under 127");
			nFadeValue = Clamp(nFadeValue, 127, 255);
		}
	}
	return nFadeValue;
}

function CalcFlyXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, bool bFlyIn, float fCurrTime, float fTotalTime, out int nX, out int nY)
{
	local float fFlyRatio;
	local int nFinalX;
	local int nFinalY;
	local int nOriginFlyX;
	local int nOriginFlyY;
	local int nOffsetX;
	local int nOffsetY;
	local bool bFlyOriginFromTop;
	local bool bFlyOriginFromLeft;

	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nFinalX, nFinalY);
	GetGroupFlyOriginXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nOriginFlyX, nOriginFlyY);
	fFlyRatio 				= GetTimeRatio(fCurrTime, fTotalTime);
	bFlyOriginFromTop 		= nFinalY > nOriginFlyY;
	bFlyOriginFromLeft 		= nFinalX > nOriginFlyX;
	if ( bFlyOriginFromTop )
	{
		nOffsetY = (nFinalY - nOriginFlyY) * fFlyRatio;
		if ( bFlyIn )
		{
			nY = nOriginFlyY + nOffsetY;
		} 
		else 
		{
			nY = nFinalY - nOffsetY;
		}
	} 
	else 
	{
		nOffsetY = (nOriginFlyY - nFinalY) * fFlyRatio;
		if ( bFlyIn )
		{
			nY = nOriginFlyY - nOffsetY;
		} 
		else 
		{
			nY = nFinalY + nOffsetY;
		}
	}
	if ( bFlyOriginFromLeft )
	{
		nOffsetX = (nFinalX - nOriginFlyX) * fFlyRatio;
		if ( bFlyIn )
		{
			nX = nOriginFlyX + nOffsetX;
		} 
		else 
		{
			nX = nFinalX - nOffsetX;
		}
	} 
	else 
	{
		nOffsetX = (nOriginFlyX - nFinalX) * fFlyRatio;
		if ( bFlyIn )
		{
			nX = nOriginFlyX - nOffsetX;
		} 
		else 
		{
			nX = nFinalX + nOffsetX;
		}
  }
}

function float GetScaleFactor (int nCanvasSizeX)
{
	local float fScale;

	fScale = nCanvasSizeX / 640.0;
	return fScale;
}

event PreBeginPlay ()
{
	CurrEffectType = GameEffectType;
}

auto state Idle
{
	function OnCountIncremented ()
	{
		if ( (CurrEffectType == 2) || (CurrEffectType == 3) )
		{
			GotoState('Hold');
		} 
		else 
		{
			GotoState('EffectIn');
		}
	}
  
	function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		if ( bDisplayOnMenu )
		{
			HandleMenuModeSwitching(bMenuMode);
		}
	}
  
	function BeginState ()
	{
		if ( (CurrEffectType == 2) || (CurrEffectType == 3) )
		{
			GotoState('Hold');
		}
	}
  
}

state EffectIn
{
	event Tick (float fDeltaTime)
	{
		if ( fCurrEffectInTime > 0.0 )
		{
			fCurrEffectInTime -= fDeltaTime;
			if ( fCurrEffectInTime < 0.0 )
			{
				fCurrEffectInTime = 0.0;
			}
		} 
		else 
		{
			GotoState('Hold');
		}
	}
  
	function int GetFadeValue ()
	{
		local float fFadeRatio;
		local int nFadeValue;
		local int nFadeStart;
  
		if ( CurrEffectType == 0 )
		{
			return CalcFadeValue(True, fCurrEffectInTime, fTotalEffectInTime);
		} 
		else 
		{
			return 255;
		}
  }
  
	function GetGroupCurrXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nX, out int nY)
	{
		if ( CurrEffectType == 1 )
		{
			CalcFlyXY(bMenuMode, Canvas, nIconWidth, nIconHeight, True, fCurrEffectInTime, fTotalEffectInTime, nX, nY);
		} 
		else 
		{
			GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nX, nY);
		}
	}
  
	function BeginState ()
	{
		fCurrEffectInTime = fTotalEffectInTime;
	}
  
}

state Hold
{
	event Timer ()
	{
		SetTimer(0.0,False);
		GotoState('EffectOut');
	}
  
	function OnCountIncremented ()
	{
		if ( (bool(CurrEffectType) != bool(2)) || (bool(CurrEffectType) == bool(3)) )
		{
			SetTimer(0.0,False);
			SetTimer(fTotalHoldTime,False);
		}
	}
  
	function BeginState ()
	{
		if ( (CurrEffectType != 2) || (CurrEffectType == 3) )
		{
			SetTimer(fTotalHoldTime,False);
		}
	}
  
}

state EffectOut
{
	event Tick (float fDeltaTime)
	{
		if ( fCurrEffectOutTime > 0.0 )
		{
			fCurrEffectOutTime -= fDeltaTime;
			if ( fCurrEffectOutTime < 0.0 )
			{
				fCurrEffectOutTime = 0.0;
			}
		} 
		else 
		{
			GotoState('Idle');
		}
	}
  
	function OnCountIncremented ()
	{
		if ( (CurrEffectType != 2) || (CurrEffectType == 3) )
		{
			GotoState('Hold');
		}
	}
  
	function int GetFadeValue ()
	{
		local float fFadeRatio;
		local int nFadeValue;
		local int nFadeStart;
  
		if ( CurrEffectType == 0 )
		{
			return CalcFadeValue(False, fCurrEffectOutTime, fTotalEffectOutTime);
		} 
		else 
		{
			return 255;
		}
	}
  
	function GetGroupCurrXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nX, out int nY)
	{
		if ( CurrEffectType == 1 )
		{
			CalcFlyXY(bMenuMode, Canvas, nIconWidth, nIconHeight, False, fCurrEffectOutTime, fTotalEffectOutTime, nX, nY);
		} 
		else 
		{
			GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nX, nY);
		}
	}		
  
	function BeginState ()
	{
		fCurrEffectOutTime = fTotalEffectOutTime;
	}
  
}

defaultproperties
{
    bDisplayHorizontally=True

    nSpaceBetweenIcons=4

    bHidden=True

    // DrawType=0
	DrawType=DT_None 
}
