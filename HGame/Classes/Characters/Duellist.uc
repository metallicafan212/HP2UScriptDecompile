//================================================================================
// Duellist.
//================================================================================

class Duellist extends Characters;

const fMinTimeBeforeCommentRepeat= 30.0;
const fMaxGapTimeBetweenComments= 2.4;
const fMinGapTimeBetweenComments= 1.0;
const fNoGapTimeBetweenComments= 0.1;
const MAX_DUEL_COMMENT_VARIANTS= 10;
const MAX_DUEL_COMMENT_HOUSE_NAMES= 6;
const MAX_DUEL_COMMENT_NAMES= 10;

struct CommentInfo
{
  var string DlgName;
  var Sound dlgSound;
  var string DlgText;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

struct VarCommentInfo
{
  var CommentInfo Variant[10];
  var int Variations;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

struct HouseDependentCommentInfo
{
  var VarCommentInfo House;
  var bool bHasBeenSaid;
  var float fTimeLastSaid;
};

enum HouseAffiliation 
{
  HA_Gryffindor,
  HA_Ravenclaw,
  HA_Hufflepuff,
  HA_Slytherin,
  HA_Neutral
};

enum DuelComment 
{
  DC_None,
  DC_DuelIntro,
  DC_DuelLose,
  DC_DuelWin,
  DC_DuelHry,
  DC_DuelOpp,
  DC_NumComments
};

var string DuelCommentNames[10];
var string DuelCommentHouseNames[6];
var HouseDependentCommentInfo Comments[9];
var float fNextTimeACommentCanBeSaid;
var float fGapTime;
var ProfSnape pSnape;
var EAnimType DuellistAnimType;
var cAnimChannel DuellistAnimChannel;
var SpellCursor SpellCursor;
var Vector vTargetDir;
var Vector vNewLoc;
var int nMaxHealth;
var float ftemp;
var float fTimeAfterHit;
var float fLimitInXDirection;
var Vector StartLocation;
var Vector HarryStartLocation;
var() name WonEventName;
var() name LostEventName;
var() float Intellect;
var() bool bGoToDuelMode;
var() HouseAffiliation eHouse;
var bool bReboundingSpells;
var Class<baseSpell> CurrentSpellClass;


function bool HarrySpellAboutToHitMe()
{
	local int I;
	local baseSpell CurrCastedSpell;

	if ( fTimeAfterHit > 0 )
	{
		return False;
	}
	for(I = 0; I < baseWand(PlayerHarry.Weapon).NumCastedSpells; I++)
	{
		CurrCastedSpell = baseWand(PlayerHarry.Weapon).CastedSpellList[I];
		if ( VSize(CurrCastedSpell.Location - Location) < CollisionRadius * (2 + 3 * Intellect) )
		{
			return True;
		}
	}
	return False;
}

function bool HarrySpellGoesInMyDirection()
{
	local int I;
	local float Y;
	local float t;
	local Vector Loc;
	local Vector Vel;
	local baseSpell CurrCastedSpell;

	if ( fTimeAfterHit > 0 )
	{
		return False;
	}
	if ( CurrentSpellClass == Class'spellDuelExpelliarmus' )
	{
		return False;
	}
	
	for(I = 0; I < baseWand(PlayerHarry.Weapon).NumCastedSpells; I++)
	{
		CurrCastedSpell = baseWand(PlayerHarry.Weapon).CastedSpellList[I];
		Loc = CurrCastedSpell.Location;
		Vel = CurrCastedSpell.Velocity;
		if ( Vel.X == 0 )
		{
			continue;
		}
		t = (Location.X - Loc.X) / Vel.X;
		if ( t < 0 )
		{
			continue;
		}
		Y = Loc.Y + Vel.Y * t;
		if ( Abs(Y - Location.Y) < CollisionRadius * (1 + Intellect * 0.5) )
		{
			return True;
		}
	}
	return False;
}

function StartCharging()
{
	if ( PlayerHarry.bDuelIsOver )
	{
		return;
	}
	if ( fTimeAfterHit > 0 )
	{
		return;
	}
	if ( PlayerHarry.fTimeAfterHit > 0 )
	{
		CurrentSpellClass = Class'spellDuelRictusempra';
	} 
	else 
	{
		switch (Rand(2))
		{
			case 0:
				CurrentSpellClass = Class'spellDuelRictusempra';
				break;
			case 1:
				CurrentSpellClass = Class'spellDuelMimblewimble';
				break;
			default:
				CurrentSpellClass = Class'spellDuelRictusempra';
				break;
		}
	}
	baseWand(Weapon).StartChargingSpell(True,False,CurrentSpellClass);
	DuellistAnimChannel.DoCharging();
}

function StartChargingDefence()
{
	CurrentSpellClass = Class'spellDuelExpelliarmus';
	baseWand(Weapon).StartChargingSpell(True,False,CurrentSpellClass);
	DuellistAnimChannel.DoCharging();
}

function StopCharging()
{
	baseWand(Weapon).StopChargingSpell();
}

function TurnOffSpellCursor()
{
	SpellCursor.TurnTargetingOff();
	baseWand(Weapon).StopChargingSpell();
}

function Cast()
{
	baseWand(Weapon).CastSpell(PlayerHarry,,CurrentSpellClass);
	TurnOffSpellCursor();
}

function Defence()
{
	PlaySound(Sound'Dueling_EXP_swoosh');
	baseWand(Weapon).CastSpell(PlayerHarry,,Class'spellDuelExpelliarmus');
	TurnOffSpellCursor();
}

function float TimeLeftUntilSafeToSayAComment (optional bool bNoGap)
{
	local float fTimeLeft;

	fTimeLeft = fNextTimeACommentCanBeSaid - Level.TimeSeconds + fNoGapTimeBetweenComments;
	if ( bNoGap )
	{
		fTimeLeft += fNoGapTimeBetweenComments;
	} 
	else 
	{
		fTimeLeft += fGapTime;
	}
	return fTimeLeft;
}

function bool CommentHasBeenSaidBefore (DuelComment eComment)
{
	return Comments[eComment].bHasBeenSaid;
}

function bool SayComment (DuelComment eComment, optional HouseAffiliation eHouse, optional bool bNoGap)
{
	local bool bSaid;
	local int Variant;
	local int Tied;
	local int OldestVariant;
	local float OldestTime;
	local float duration;
	local Sound dlgSound;

	bSaid = False;
	if ( eComment == DC_None )
	{
		return False;
	}
	if ( (eComment == DC_DuelHry) || (eComment == DC_DuelOpp)) 
	{
		if ( Rand(2) == 0 )
		{
			return False;
		}
	}
	if ( bNoGap )
	{
		if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fNoGapTimeBetweenComments )
		{
			return False;
		}
	} 
	else 
	{
		if ( Level.TimeSeconds < fNextTimeACommentCanBeSaid + fGapTime )
		{
			return False;
		}
	}
	OldestVariant = 0;
	OldestTime = Level.TimeSeconds;
	Tied = 0;
	Variant = 0;
	while( Variant < MAX_DUEL_COMMENT_VARIANTS && (Comments[eComment].House.Variant[Variant].DlgName != "") )
	{
		if ( Comments[eComment].House.Variant[Variant].bHasBeenSaid )
		{
			if ( Comments[eComment].House.Variant[Variant].fTimeLastSaid < OldestTime )
			{
				OldestVariant = Variant;
				OldestTime = Comments[eComment].House.Variant[Variant].fTimeLastSaid;
			}
		} 
		else 
		{
			++Tied;
			if ( FRand() <= 1.0 / Tied )
			{
				OldestVariant = Variant;
				OldestTime = -1.0;
			}
		}
		
		++Variant;
	}
	Comments[eComment].House.Variations = Variant;
	Variant = OldestVariant;
	if (  !Comments[eComment].House.Variant[Variant].bHasBeenSaid || (Level.TimeSeconds > Comments[eComment].House.Variant[Variant].fTimeLastSaid + fMinTimeBeforeCommentRepeat) )
	{
		dlgSound 													= Comments[eComment].House.Variant[Variant].dlgSound;
		Comments[eComment].House.Variant[Variant].fTimeLastSaid 	= Level.TimeSeconds;
		Comments[eComment].House.fTimeLastSaid 						= Level.TimeSeconds;
		Comments[eComment].fTimeLastSaid 							= Level.TimeSeconds;
		Comments[eComment].House.Variant[Variant].bHasBeenSaid 		= True;
		Comments[eComment].House.bHasBeenSaid 						= True;
		Comments[eComment].bHasBeenSaid 							= True;
		fGapTime 													= FRand() * (fMaxGapTimeBetweenComments - fMinGapTimeBetweenComments) + fMinGapTimeBetweenComments;
		if ( dlgSound != None )
		{
			if ( pSnape != None )
			{
				pSnape.PlaySound(dlgSound,SLOT_Talk,2.0,,10000.0,,True);
			} 
			else 
			{
				PlaySound(dlgSound,SLOT_Talk,2.0,,10000.0,,True);
			}
			bSaid = True;
			fNextTimeACommentCanBeSaid = Level.TimeSeconds + GetSoundDuration(dlgSound);
		} 
		else 
		{
			duration = DeliverLocalizedDialog(Comments[eComment].House.Variant[Variant].DlgName,True,0.0);
			bSaid = False;
			fNextTimeACommentCanBeSaid = Level.TimeSeconds + duration;
		}
	} 
	// Metallicafan212:	This was blank in UTPT, so IDK if something is supposed to be here
	else 
	{
		//looks like KW left it empty -AdamJD
	}
	return bSaid;
}

function string EventNumToEventName (int Num)
{
	return DuelCommentNames[Num];
}

function string GetCommentId (int eventNum, int House, int Variant)
{
	local string Key;
	//local string EventName;
	local string sEventName;
	local string Id;

	sEventName = EventNumToEventName(eventNum);
	Key = DuelCommentHouseNames[House] $"_" $sEventName;
	Id = Localize(Key,"line" $ string(Variant),"DuelSet");
	if ( InStr(Id,"<") > -1 )
	{
		return "";
	} 
	else 
	{
		return Id;
	}
}

function fillCommentArray()
{
	local int C;
	local int H;
	local int V;
	local string sndId;
	local DuelComment vvv;

	H = eHouse;
	for(c = 0; c < MAX_DUEL_COMMENT_NAMES; c++)
	{
		for(v = 0; v < MAX_DUEL_COMMENT_VARIANTS; v++)
		{
			sndId = GetCommentId(C,H,V);
			if ( sndId != "" )
			{
				Comments[C].House.Variant[V].DlgName = sndId;
				Comments[C].House.Variant[V].dlgSound = Sound(DynamicLoadObject("AllDialog." $ sndId,Class'Sound'));
			}
		}
	}
}

function PostBeginPlay()
{
	local Weapon weap;
	local string AnimName;
	local int I;
	local name nm;

	Super.PostBeginPlay();
	if ( Intellect < 0 )
	{
		Intellect = 0.0;
	}
	if ( Intellect > 1 )
	{
		Intellect = 1.0;
	}
	
	weap = Spawn(Class'baseWand',self);
	weap.BecomeItem();
	weap.WeaponSet(self);
	weap.GiveAmmo(self);
	DuellistAnimChannel = cAnimChannel(CreateAnimChannel(Class'cAnimChannel',AT_Replace,'bip01 Spine1'));
	DuellistAnimChannel.SetOwner(self);
	SpellCursor = Spawn(Class'SpellCursor');
	
	if ( bGoToDuelMode )
	{
		PlayerHarry.TurnOnDuelingMode(self);
	}
	
	fNextTimeACommentCanBeSaid = 0.0;
	fGapTime = 0.0;
	fillCommentArray();
	
	foreach AllActors(Class'ProfSnape',pSnape)
	{
		break;
	}
	
	bRotateToDesired = Default.bRotateToDesired;
}

function SetHealthBar()
{
  local EnemyHealthManager EHealth;

  EHealth = EnemyHealthManager(FancySpawn(Class'EnemyHealthManager'));
  EHealth.Start(self);
}

function int DeltaHealth (bool HarryHealth, int SpellType, float SpellCharge)
{
	local float fDelta;
	local float Charge;
	local float MaxHealthRict;
	local float MaxHealthMimb;
	local float MaxHealth;
	local int iDelta;
	local float MaxDamageRictusempra;
	local float MaxDamageMimblewimble;

	MaxHealthRict = nMaxHealth;
	MaxHealthMimb = nMaxHealth / 5.0;
	Charge = SpellCharge;
	if ( HarryHealth && (Charge < 1) )
	{
		Charge = 1.0;
	}
	if ( SpellType == 0 )
	{
		MaxHealth = MaxHealthRict;
	} 
	else  if ( SpellType == 1 )
    {
		MaxHealth = MaxHealthMimb;
    } 
	else 
	{
		MaxHealth = MaxHealthMimb;
    }
	if ( HarryHealth )
	{
		fDelta = MaxHealth / 4;
	} 
	else 
	{
		fDelta = (0.25 * Intellect * Intellect - 0.625 * Intellect + 0.5) * MaxHealth;
	}
	
	fDelta *= Charge;
	
	if ( fDelta < 1 )
	{
		fDelta = 1.0;
	}
	
	if ( fDelta > nMaxHealth / 2.0 )
	{
		fDelta = nMaxHealth / 2.0;
	}
	
	if ( SpellCharge == 0 )
	{
		fDelta = 0.0;
	}
	iDelta = fDelta;
	return iDelta;
}

function float GetHealth()
{
	return float(Health) / nMaxHealth;
}

function PlayIdle()
{
	LoopAnim('duel_idle',0.81,[TweenTime]0.25,,DuellistAnimType);
}

function bool HandleSpellDuelExpelliarmus (optional baseSpell spell, optional Vector vHitLocation)
{
	return False;
}

function bool DuellistSex()
{
	if ( Mesh == SkeletalMesh'skhp2_genmale1Mesh' )
	{
		return True;
	}
	if ( Mesh == SkeletalMesh'skhp2_genmale2Mesh' )
	{
		return True;
	}
	if ( Mesh == SkeletalMesh'skDracoMesh' )
	{
		return True;
	}
	return False;
}

function PlaySoundOuch()
{
	if ( DuellistSex() )
	{
		switch (Rand(8))
		{
			case 0:
				PlaySound(Sound'Q_mseeker_ouch01',SLOT_Talk,2.0,,100000.0);
				break;
			case 1:
				PlaySound(Sound'Q_mseeker_ouch02',SLOT_Talk,2.0,,100000.0);
				break;
			case 2:
				PlaySound(Sound'Q_mseeker_ouch03',SLOT_Talk,2.0,,100000.0);
				break;
			case 3:
				PlaySound(Sound'Q_mseeker_ouch04',SLOT_Talk,2.0,,100000.0);
				break;
			case 4:
				PlaySound(Sound'Q_mseeker_ouch05',SLOT_Talk,2.0,,100000.0);
				break;
			case 5:
				PlaySound(Sound'Q_mseeker_ouch06',SLOT_Talk,2.0,,100000.0);
				break;
			case 6:
				PlaySound(Sound'Q_mseeker_ouch07',SLOT_Talk,2.0,,100000.0);
				break;
			case 7:
				PlaySound(Sound'Q_mseeker_ouch08',SLOT_Talk,2.0,,100000.0);
				break;
			default:
		}
	} 
	else 
	{
		switch (Rand(8))
		{
			case 0:
				PlaySound(Sound'Q_fseeker_ouch01',SLOT_Talk,2.0,,100000.0);
				break;
			case 1:
				PlaySound(Sound'Q_fseeker_ouch02',SLOT_Talk,2.0,,100000.0);
				break;
			case 2:
				PlaySound(Sound'Q_fseeker_ouch03',SLOT_Talk,2.0,,100000.0);
				break;
			case 3:
				PlaySound(Sound'Q_fseeker_ouch04',SLOT_Talk,2.0,,100000.0);
				break;
			case 4:
				PlaySound(Sound'Q_fseeker_ouch05',SLOT_Talk,2.0,,100000.0);
				break;
			case 5:
				PlaySound(Sound'Q_fseeker_ouch06',SLOT_Talk,2.0,,100000.0);
				break;
			case 6:
				PlaySound(Sound'Q_fseeker_ouch07',SLOT_Talk,2.0,,100000.0);
				break;
			case 7:
				PlaySound(Sound'Q_fseeker_ouch08',SLOT_Talk,2.0,,100000.0);
				break;
			default:
		}
	}
}

function HarryWonDuel()
{
	if ( PlayerHarry.bDuelIsOver )
	{
		return;
	}
	TurnOffSpellCursor();
	PlayerHarry.bDuelIsOver = True;
	PlayerHarry.UpdateDuelingRanks(True);
	SentEvent(WonEventName);
	GotoState('stateIdle');
	DuellistAnimChannel.GotoState('stateIdle');
}

function bool HandleSpellDuelRictusempra (optional baseSpell spell, optional Vector vHitLocation)
{
	local float SpellCharge;
	local float SpellSpeed;

	if ( bReboundingSpells )
	{
		PlaySound(Sound'Dueling_EXP_smack',SLOT_Misc);
		spell.Reflect(self, FMin(5.0,spell.SpellCharge + (5 - spell.SpellCharge) * 0.1), FMin(1000.0,spell.Speed + (1000 - spell.Speed) * 0.25));
		baseWand(Weapon).FlashChargeParticles(Class'Exep_Shield');
		return False;
	}
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
	PlayIdle();
	Health -= DeltaHealth(False,0,spell.SpellCharge);
	PlaySoundOuch();
	if ( Health > 0 )
	{
		SayComment(DC_DuelHry, eHouse, True);
		DuellistAnimChannel.DoReactRictusempra();
	} 
	else 
	{
		SayComment(DC_DuelWin,eHouse,True);
		HarryWonDuel();
	}
	fTimeAfterHit = 1.0;
	return True;
}

function bool HandleSpellDuelMimblewimble (optional baseSpell spell, optional Vector vHitLocation)
{
	if ( bReboundingSpells )
	{
		PlaySound(Sound'Dueling_EXP_smack',SLOT_Misc);
		spell.Reflect(self, FMin(5.0,spell.SpellCharge + (5 - spell.SpellCharge) * 0.1),FMin(1000.0,spell.Speed + (1000 - spell.Speed) * 0.25));
		baseWand(Weapon).FlashChargeParticles(Class'Exep_Shield');
		return False;
	}
	Acceleration = vect(0.00,0.00,0.00);
	Velocity = vect(0.00,0.00,0.00);
	PlayIdle();
	PlaySound(Sound'Dueling_MIM_hit',SLOT_Misc);
	if ( Rand(2) == 0 )
	{
		Health -= DeltaHealth(False,1,spell.SpellCharge);
		PlaySound(Sound'Dueling_MIM_self_damage',SLOT_Misc);
	} 
	else 
	{
		PlaySound(Sound'Dueling_MIM_self_lucky',SLOT_Misc);
	}
	if ( Health > 0 )
	{
		SayComment(DC_DuelHry,eHouse,True);
		DuellistAnimChannel.DoReactMimbleWimble();
	} 
	else 
	{
		SayComment(DC_DuelWin,eHouse,True);
		HarryWonDuel();
	}
	fTimeAfterHit = 4.0 - (2 * Intellect);
	return True;
}

function bool CouldTauntHarry()
{
	if ( PlayerHarry.fTimeAfterHit < 1 + (4 * Intellect) )
	{
		return False;
	}
	if ( IsInState('stateTaunt') )
	{
		return False;
	}
	if (  !DuellistAnimChannel.IsInState('stateIdle') )
	{
		return False;
	}
	return True;
}

state stateIdle
{
	begin:
		if ( bGoToDuelMode )
		{
			PlayerHarry.TurnOnDuelingMode(self);
			GotoState('stateStartDuel');
		}
		PlayAnim('Idle');
		FinishAnim();
		Sleep(0.01);
		goto ('Begin');
}

state stateShot
{
  
	function BeginState()
	{
		DuellistAnimChannel.bCasting = True;
	}

	// Metallicafan212:	Again with UTPT not decomping
	function Tick(float dtime)
	{
		Global.Tick(dtime);
		//log(DuellistAnimChannel.bCasting);
		if(DuellistAnimChannel.bCasting)
			return;
		
		//log("Done shooting");
		// if shooting is over, go to patrolling
		StartCharging();
		gotostate('statePatrol');
	}
  
	begin:
		Acceleration = vect(0.00,0.00,0.00);
		Velocity = vect(0.00,0.00,0.00);
		if ( AnimSequence != 'duel_idle' )
		{
			Sleep(0.01);
			AnimRate = 0.0;
			LoopAnim('duel_idle');
		}
		DuellistAnimChannel.DoCast();
}

state stateDefence
{
  
	function BeginState()
	{
		DuellistAnimChannel.bCasting = True;
	}
	
	// Metallicafan212:	AAAAAAA
	function Tick(float dtime)
	{
		Global.Tick(dtime);
		if(DuellistAnimChannel.bCasting)
			return;

		StartCharging();
		gotostate('statePatrol');
	}
	
	begin:
		Acceleration = vect(0.00,0.00,0.00);
		Velocity = vect(0.00,0.00,0.00);
		if ( AnimSequence != 'duel_idle' )
		{
			Sleep(0.01);
			AnimRate = 0.0;
			LoopAnim('duel_idle');
		}
		DuellistAnimChannel.DoDefence();
}

state stateStay
{
	begin:
		Acceleration = vect(0.00,0.00,0.00);
		Velocity = vect(0.00,0.00,0.00);
		PlayIdle();
		Sleep(0.05);
		GotoState('statePatrol');
}

state stateGoRight
{
	function HitWall (Vector HitNormal, Actor HitWall)
	{
		vNewLoc.Y = Location.Y;
		vNewLoc.Z = Location.Z;
		vNewLoc.X = Location.X + 10;
		GotoState('stateGoBackward');
	}
	
	begin:
		if ( AnimSequence != 'strafe_right' )
		{
			Sleep(0.01);
			AnimRate = 0.0;
			LoopAnim('strafe_right');
		}
		MoveTo(vNewLoc);
		GotoState('statePatrol');
}

state stateGoLeft
{
	function HitWall (Vector HitNormal, Actor HitWall)
	{
		vNewLoc.Y = Location.Y;
		vNewLoc.Z = Location.Z;
		vNewLoc.X = Location.X + 10;
		GotoState('stateGoBackward');
	}
	
	begin:
		if ( AnimSequence != 'strafe_left' )
		{
			Sleep(0.01);
			AnimRate = 0.0;
			LoopAnim('strafe_left');
		}
		MoveTo(vNewLoc);
		GotoState('statePatrol');
}

state stateGoForward
{
	begin:
		Sleep(0.01);
		AnimRate = 0.0;
		LoopAnim('duel_run');
		MoveTo(vNewLoc);
		Acceleration = vect(0.00,0.00,0.00);
		Velocity = vect(0.00,0.00,0.00);
		GotoState('statePatrol');
}

state stateGoBackward
{
	begin:
		Sleep(0.01);
		AnimRate = 0.0;
		LoopAnim('duel_runback');
		MoveTo(vNewLoc);
		Acceleration = vect(0.00,0.00,0.00);
		Velocity = vect(0.00,0.00,0.00);
		GotoState('statePatrol');
}

state stateFollowHarry_In_Y_Dir
{
	begin:
		vNewLoc = PlayerHarry.Location;
		vNewLoc.X = Location.X;
		vNewLoc.Z = Location.Z;
		if ( vNewLoc.Y > Location.Y )
		{
			GotoState('stateGoLeft');
		} 
		else if ( vNewLoc.Y < Location.Y )
		{
			GotoState('stateGoRight');
		}
		GotoState('statePatrol');
}

state stateFollowHarry_In_X_Dir
{
	begin:
		vNewLoc.Y = Location.Y;
		vNewLoc.Z = Location.Z;
		if ( Location.X >= StartLocation.X )
		{
			vNewLoc.X = Location.X - RandRange(fLimitInXDirection / 2,fLimitInXDirection);
			GotoState('stateGoForward');
		} 
		else
		{
			vNewLoc.X = Location.X + RandRange(fLimitInXDirection / 2,fLimitInXDirection);
			GotoState('stateGoBackward');
		}
		GotoState('statePatrol');
}

state stateRunFromHarry
{
	begin:
		if ( Abs(PlayerHarry.Location.Y - Location.Y) > 25 * (1 + Intellect) )
		{
			GotoState('stateStay');
		}
		vNewLoc = Location;
		if ( PlayerHarry.Location.Y > HarryStartLocation.Y )
		{
			vNewLoc.Y = PlayerHarry.Location.Y - 25 * (1 + Intellect);
		} 
		else 
		{
			vNewLoc.Y = PlayerHarry.Location.Y + 25 * (1 + Intellect);
		}
		if ( vNewLoc.Y > Location.Y )
		{
			GotoState('stateGoLeft');
		} 
		else if ( vNewLoc.Y < Location.Y )
		{
			GotoState('stateGoRight');
		}
		GotoState('statePatrol');
}

state statePatrol
{
	begin:
		if ( fTimeAfterHit > 0 )
		{
			GotoState('stateRunFromHarry');
		}
		//log("StatePatrol!");
		
		ftemp = PlayerHarry.Location.Y - Location.Y;
		
		if ( Abs(ftemp) < PlayerHarry.CollisionRadius )
		{
			if ( CouldTauntHarry() )
			{
				//log("Taunt");
				GotoState('stateTaunt');
			} 
			else if( LineOfSightTo(playerHarry) && (CurrentSpellClass != class'spellDuelExpelliarmus') && ( baseWand(weapon).ChargingLevel() > 0.25 * (2 - Intellect) ) && (fTimeAfterHit <= 0) )
			{
				//log("Shot");
				GotoState('stateShot');
			}
			else
			{			
				if ( Rand(5) == 0 )
				{
					//log("FollowX");
					GotoState('stateFollowHarry_In_X_Dir');
				} 
				else 
				{
					//log("Stay");
					GotoState('stateStay');
				}
			}
		} 
		else 
		{
			GotoState('stateFollowHarry_In_Y_Dir');
		}
}

state stateTaunt
{
	begin:
		Acceleration = vect(0.00,0.00,0.00);
		Velocity = vect(0.00,0.00,0.00);
		TurnOffSpellCursor();
		Sleep(0.01);
		AnimRate = 0.0;
		if ( Rand(2) == 0 )
		{
			PlayAnim('taunt_1');
		} 
		else 
		{
			PlayAnim('taunt_2');
		}
		FinishAnim();
		StartCharging();
		GotoState('statePatrol');
}

state stateStartDuel
{
	begin:
		StartLocation = Location;
		HarryStartLocation = PlayerHarry.Location;
		SayComment(DC_DuelIntro,eHouse,True);
		PlayAnim('duel_idle');
		FinishAnim();
		StartCharging();
		GotoState('statePatrol');
}

state stateDead
{
	function BeginState()
	{
		Velocity = vect(0.00,0.00,0.00);
		Acceleration = vect(0.00,0.00,0.00);
	}
	begin:
		Level.Game.RestartGame();
}

function Tick (float deltaT)
{
	local float savedTimeAfterHit;

	Super.Tick(deltaT);
	savedTimeAfterHit = fTimeAfterHit;
	if ( fTimeAfterHit > 0 )
	{
		fTimeAfterHit -= deltaT;
	}
	
	if ( (savedTimeAfterHit > 0) && (fTimeAfterHit <= 0) )
	{
		StartCharging();
		if (  !PlayerHarry.bDuelIsOver )
		{
			GotoState('statePatrol');
		}
	}
	if ( PlayerHarry.bInDuelingMode &&  !LineOfSightTo(PlayerHarry) )
	{
		if (  !IsInState('stateStay') &&  !IsInState('stateShot') &&  !IsInState('stateDefence') &&  !IsInState('stateStartDuel') )
		{
			GotoState('stateStay');
		}
	}
	if ( (CurrentSpellClass == Class'spellDuelExpelliarmus') && (baseWand(Weapon).ChargingLevel() >= 1) )
	{
		TurnOffSpellCursor();
		StartCharging();
		if (  !PlayerHarry.bDuelIsOver )
		{
			GotoState('statePatrol');
		}
	}
	if ( HarrySpellGoesInMyDirection() )
	{
		StartChargingDefence();
	}
	if ( (CurrentSpellClass == Class'spellDuelExpelliarmus') && (baseWand(Weapon).ChargingLevel() > 0.2 * (1 - Intellect)) && HarrySpellAboutToHitMe() )
	{
		GotoState('stateDefence');
	}
}

function SentEvent (name EName)
{
	if (  !PlayerHarry.bInDuelingMode )
	{
		return;
	}
	if ( EName != 'None' )
	{
		TriggerEvent(EName,None,None);
		PlayerHarry.TurnOffDuelingMode();
		PlayerHarry.ClientMessage("Send event.................." $ string(EName));
	}
}

defaultproperties
{
    DuelCommentNames(0)="None"

    DuelCommentNames(1)="DuelIntro"

    DuelCommentNames(2)="DuelLose"

    DuelCommentNames(3)="DuelWin"

    DuelCommentNames(4)="DuelHry"

    DuelCommentNames(5)="DuelOpp"

    DuelCommentHouseNames(0)="WCG"

    DuelCommentHouseNames(1)="WCR"

    DuelCommentHouseNames(2)="WCH"

    DuelCommentHouseNames(3)="WCS"

    DuelCommentHouseNames(4)="WCN"

    DuelCommentHouseNames(5)="WCO"

    fLimitInXDirection=100.00

    WonEventName=HarryWonDuel

    LostEventName=HarryLostDuel

    Intellect=1.00

    eHouse=HA_Slytherin

    EnemyHealthBar=EnemyBar_Duellist

    SightRadius=512.00

    Mesh=SkeletalMesh'HPModels.skhp2_genfemale1Mesh'

    AmbientGlow=65

    CollisionRadius=15.00

    CollisionHeight=44.00

    bRotateToDesired=False
}