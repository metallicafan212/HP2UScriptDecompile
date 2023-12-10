//================================================================================
// spellTrigger.
//================================================================================

class spellTrigger extends Trigger;

//texture import -AdamJD
#exec Texture Import File=Textures\spell_trigger.PNG Name=spell_trigger COMPRESSION=P8 UPSCALE=1 Mips=0 Flags=2

var() bool bHitJustFromFront;

function BeginPlay()
{
	Super.BeginPlay();
}

function bool IsRelevant (Actor Other)
{
	if (  !bInitiallyActive )
	{
		if ( baseSpell(Other) == None )
		{
			bInitiallyActive = True;
			Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!making active1 " $ string(Other));
			return False;
		}
		if ( baseSpell(Other).SpellType == eVulnerableToSpell )
		{
			return False;
		} 
		else 
		{
			bInitiallyActive = True;
			Log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!making active 2 " $ string(Other));
			return False;
		}
		return False;
	}
	if ( baseSpell(Other) == None )
	{
		return False;
	}
	if ( baseSpell(Other).SpellType == eVulnerableToSpell )
	{
		return True;
	} 
	else 
	{
		return False;
	}
}

function Touch (Actor Other)
{
	local Actor A;

	if ( IsRelevant(Other) )
	{
		if ( bTriggerOnceOnly )
		{
			SetCollision(False);
			bProjTarget = False;
		}
	}
	Super.Touch(Other);
}

state() OtherTriggerToggles
{
	function Trigger (Actor Other, Pawn EventInstigator)
	{
		Super.Trigger(Other,EventInstigator);
		bProjTarget =  !bProjTarget;
	}
}

state() OtherTriggerTurnsOn
{
	function Trigger (Actor Other, Pawn EventInstigator)
	{
		Super.Trigger(Other,EventInstigator);
		bProjTarget = True;
	}
}

state() OtherTriggerTurnsOff
{
	function Trigger (Actor Other, Pawn EventInstigator)
	{
		Super.Trigger(Other,EventInstigator);
		bProjTarget = False;
	}
}

defaultproperties
{
    // TriggerType=4
	TriggerType=TT_Shoot

    // Style=2
	Style=STY_Masked

    Texture=Texture'spell_trigger'

    bProjTarget=True
}
