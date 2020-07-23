//================================================================================
// StatusGroupHousePoints.
//================================================================================

class StatusGroupHousePoints extends StatusGroup;

const strCUT_NAME= "Housepoints";

event PostBeginPlay ()
{
	CutName = "Housepoints";
}

function GetGroupFinalXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	GetGroupFinalXY_2(bMenuMode, Canvas.SizeX, Canvas.SizeY, nIconWidth, nIconHeight, nOutX, nOutY);
}

function GetGroupFinalXY_2 (bool bMenuMode, int nCanvasSizeX, int nCanvasSizeY, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(nCanvasSizeX);
	nOutX 			= nCanvasSizeX - fScaleFactor * nIconWidth - fScaleFactor * 4;
	nOutY 			= fScaleFactor * 4;
}

function GetGroupFlyOriginXY (bool bMenuMode, Canvas Canvas, int nIconWidth, int nIconHeight, out int nOutX, out int nOutY)
{
	local int nFinalX;
	local int nFinalY;
	local float fScaleFactor;

	fScaleFactor 	= GetScaleFactor(Canvas.SizeX);
	GetGroupFinalXY(bMenuMode, Canvas, nIconWidth, nIconHeight, nFinalX, nFinalY);
	nOutX 			= nFinalX;
	nOutY 			=  -nIconHeight * fScaleFactor;
}

function TransitionUpdateHousepoints (string strTransitionLetter)
{
	local int nAddRavenclaw;
	local int nAddHufflepuff;
	local int nAddSlytherin;

	if ( strTransitionLetter ~= "A" )
	{
		nAddRavenclaw 	= RandRange(15.0,50.0);
		nAddHufflepuff 	= RandRange(15.0,50.0);
		nAddSlytherin 	= RandRange(40.0,80.0);
	} 
	else if ( strTransitionLetter ~= "B" )
    {
		nAddRavenclaw 	= RandRange(35.0,70.0);
		nAddHufflepuff 	= RandRange(40.0,75.0);
		nAddSlytherin 	= RandRange(60.0,110.0);
	}
	else if ( strTransitionLetter ~= "C" )
	{
        nAddRavenclaw 	= RandRange(50.0,70.0);
		nAddHufflepuff 	= RandRange(50.0,70.0);
		nAddSlytherin 	= RandRange(70.0,130.0);
	} 
	else if ( strTransitionLetter ~= "D" )
	{
		nAddRavenclaw 	= RandRange(100.0,150.0);
		nAddHufflepuff 	= RandRange(80.0,160.0);
		nAddSlytherin 	= RandRange(190.0,230.0);
	}
	else if ( strTransitionLetter ~= "E" )
	{
		nAddRavenclaw 	= RandRange(50.0,130.0);
		nAddHufflepuff 	= RandRange(20.0,40.0);
		nAddSlytherin 	= RandRange(40.0,70.0); 
	}
	else if ( strTransitionLetter ~= "F" )
	{
		nAddRavenclaw 	= RandRange(160.0,220.0);
		nAddHufflepuff 	= RandRange(160.0,220.0);
		nAddSlytherin 	= RandRange(180.0,250.0);
	} 
	else 
	{
		smParent.PlayerHarry.ClientMessage("ERROR: Invalid transition letter " $ strTransitionLetter);
	}
	GetStatusItem(Class'StatusItemRavenclawPts').IncrementCount(nAddRavenclaw);
	GetStatusItem(Class'StatusItemHufflePuffPts').IncrementCount(nAddHufflepuff);
	GetStatusItem(Class'StatusItemSlytherinPts').IncrementCount(nAddSlytherin);
	ResolveTies();
}

function QuidditchUpdateHousepoints (int nMatch)
{
	local int nAddRavenclaw;
	local int nAddHufflepuff;
	local int nAddSlytherin;

	switch (nMatch)
	{
		case 0:
			nAddRavenclaw 	= RandRange(0.0,10.0);
			nAddHufflepuff 	= RandRange(0.0,10.0);
			nAddSlytherin 	= RandRange(5.0,10.0);
			break;
		case 1:
			nAddRavenclaw 	= RandRange(10.0,50.0);
			nAddHufflepuff 	= RandRange(10.0,50.0);
			nAddSlytherin 	= RandRange(25.0,50.0);
			break;
		case 2:
			nAddRavenclaw 	= RandRange(50.0,100.0);
			nAddHufflepuff 	= RandRange(50.0,100.0);
			nAddSlytherin 	= RandRange(75.0,100.0);
			break;
		case 3:
			nAddRavenclaw 	= RandRange(100.0,150.0);
			nAddHufflepuff 	= RandRange(100.0,150.0);
			nAddSlytherin 	= RandRange(125.0,150.0);
			break;
		case 4:
			nAddRavenclaw 	= RandRange(150.0,200.0);
			nAddHufflepuff 	= RandRange(150.0,200.0);
			nAddSlytherin 	= RandRange(175.0,200.0);
			break;
		case 5:
			nAddRavenclaw 	= RandRange(200.0,250.0);
			nAddHufflepuff 	= RandRange(200.0,250.0);
			nAddSlytherin 	= RandRange(225.0,250.0);
			break;
		default:
			smParent.PlayerHarry.ClientMessage("ERROR: Invalid match number " $ string(nMatch));
			break;
	}
	GetStatusItem(Class'StatusItemRavenclawPts').IncrementCount(nAddRavenclaw);
	GetStatusItem(Class'StatusItemHufflePuffPts').IncrementCount(nAddHufflepuff);
	GetStatusItem(Class'StatusItemSlytherinPts').IncrementCount(nAddSlytherin);
	ResolveTies();
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
	local string sActualCommand;
	local string sCutName;
	local Actor A;
	local string strTransitionLetter;

	sActualCommand = ParseDelimitedString(Command," ",1,False);
	if ( sActualCommand ~= "Capture" )
	{
		return True;
	} 
	else if ( sActualCommand ~= "Release" )
	{
		return True;
	} 
	else if ( sActualCommand ~= "UpdateHousepoints" )
	{
		strTransitionLetter = ParseDelimitedString(Command," ",2,False);
		TransitionUpdateHousepoints(strTransitionLetter);
		CutCue(cue);
		return True;
	} 
	else 
	{
		return False;
	}
}

function bool CutQuestion (string question)
{
	CutErrorString = "";
	if ( question ~= "IsGryffindorAhead" )
	{
		return IsHouseAhead(Class'StatusItemGryffindorPts');
	} 
	else if ( question ~= "IsSlytherinAhead" )
	{
		return IsHouseAhead(Class'StatusItemSlytherinPts');
	} 
	else if ( question ~= "IsHufflepuffAhead" )
	{
		return IsHouseAhead(Class'StatusItemHufflePuffPts');
	} 
	else if ( question ~= "IsRavenclawAhead" )
	{
		return IsHouseAhead(Class'StatusItemRavenclawPts');
	} 
	else 
	{
		return Super.CutQuestion(question);
	}
}

function ResolveTies ()
{
	local StatusItem siGryffindorPts;
	local StatusItem siSlytherinPts;
	local StatusItem siRavenclawPts;
	local StatusItem siHufflepuffPts;

	siGryffindorPts		= GetStatusItem(Class'StatusItemGryffindorPts');
	siSlytherinPts 		= GetStatusItem(Class'StatusItemSlytherinPts');
	siHufflepuffPts 	= GetStatusItem(Class'StatusItemHufflePuffPts');
	siRavenclawPts 		= GetStatusItem(Class'StatusItemRavenclawPts');
	if ( (siGryffindorPts.GetCount() == 0) && (siSlytherinPts.GetCount() == 0) && (siHufflepuffPts.GetCount() == 0) && (siRavenclawPts.GetCount() == 0) )
	{
		return;
	}
	AdjustIfTie(siRavenclawPts,siGryffindorPts,siHufflepuffPts,siSlytherinPts);
	AdjustIfTie(siHufflepuffPts,siRavenclawPts,siGryffindorPts,siSlytherinPts);
	AdjustIfTie(siSlytherinPts,siHufflepuffPts,siRavenclawPts,siGryffindorPts);
}

function AdjustIfTie (out StatusItem siAdjust, StatusItem siCompare1, StatusItem siCompare2, StatusItem siCompare3)
{
	// Metallicafan212:	While loop
	while(siAdjust.nCount > 0)
	{
		if ( 
			siAdjust.nCount == siCompare1.nCount 
		|| siAdjust.nCount == siCompare2.nCount 
		|| siAdjust.nCount == siCompare3.nCount )
		{
			--siAdjust.nCount;
		} 
		else 
		{
			return;
		}
	}
	/*
	if ( siAdjust.nCount > 0 )
	{
		if ( (siAdjust.nCount == siCompare1.nCount) || (siAdjust.nCount == siCompare2.nCount) || (siAdjust.nCount == siCompare3.nCount) )
		{
			--siAdjust.nCount;
		} 
		else 
		{
			return;
		}
		goto JL0000;
	}
	*/
	
	// Metallicafan212:	Another loop
	while(true)
	{
		if ( 
			siAdjust.nCount == siCompare1.nCount 
		|| 	siAdjust.nCount == siCompare2.nCount 
		|| 	siAdjust.nCount == siCompare3.nCount )
		{
			++siAdjust.nCount;
		} 
		else 
		{
			return;
		}
	}
	
	/*
	if ( True )
	{
		if ( (siAdjust.nCount == siCompare1.nCount) || (siAdjust.nCount == siCompare2.nCount) || (siAdjust.nCount == siCompare3.nCount) )
		{
			++siAdjust.nCount;
		} 
		else 
		{
			return;
		}
		goto JL0093;
	}
	*/
}

function bool IsHouseAhead (Class<StatusItem> classItem)
{
	local StatusItem siGryffindorPts;
	local StatusItem siSlytherinPts;
	local StatusItem siRavenclawPts;
	local StatusItem siHufflepuffPts;
	local StatusItem siWinning;

	siGryffindorPts 	= GetStatusItem(Class'StatusItemGryffindorPts');
	siRavenclawPts 		= GetStatusItem(Class'StatusItemRavenclawPts');
	siHufflepuffPts 	= GetStatusItem(Class'StatusItemHufflePuffPts');
	siSlytherinPts 		= GetStatusItem(Class'StatusItemSlytherinPts');
	siWinning 			= siGryffindorPts;
	if ( siSlytherinPts.nCount > siWinning.nCount )
	{
		siWinning = siSlytherinPts;
	}
	if ( siHufflepuffPts.nCount > siWinning.nCount )
	{
		siWinning = siHufflepuffPts;
	}
	if ( siRavenclawPts.nCount > siWinning.nCount )
	{
		siWinning = siRavenclawPts;
	}
	return classItem == siWinning.Class;
}

function PutGryffInLead ()
{
	local int nGryffPts;
	local int nSlythPts;
	local int nRavenPts;
	local int nHuffPts;

	nGryffPts 	= GetStatusItem(Class'StatusItemGryffindorPts').GetCount();
	nRavenPts 	= GetStatusItem(Class'StatusItemRavenclawPts').GetCount();
	nHuffPts 	= GetStatusItem(Class'StatusItemHufflePuffPts').GetCount();
	nSlythPts 	= GetStatusItem(Class'StatusItemSlytherinPts').GetCount();
	if ( nHuffPts <= nRavenPts )
	{
		nHuffPts = nRavenPts + RandRange(1.0,10.0);
	}
	if ( nSlythPts <= nHuffPts )
	{
		nSlythPts = nHuffPts + RandRange(1.0,10.0);
	}
	if ( nGryffPts <= nSlythPts )
	{
		nGryffPts = nSlythPts + RandRange(1.0,10.0);
	}
	
	GetStatusItem(Class'StatusItemRavenclawPts').SetCount(nRavenPts);
	GetStatusItem(Class'StatusItemHufflePuffPts').SetCount(nHuffPts);
	GetStatusItem(Class'StatusItemSlytherinPts').SetCount(nSlythPts);
	GetStatusItem(Class'StatusItemGryffindorPts').SetCount(nGryffPts);
}

defaultproperties
{
    bDisplayHorizontally=False

    fTotalEffectInTime=0.50

    fTotalHoldTime=3.00

    fTotalEffectOutTime=0.20

}