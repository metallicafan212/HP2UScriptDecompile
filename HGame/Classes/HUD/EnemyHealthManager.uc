//================================================================================
// EnemyHealthManager.
//================================================================================

class EnemyHealthManager extends HudItemManager;

const fSCREEN_UP_FROM_BOTTOM_Y=   110.0;
const fSCREEN_X= 4;
const fBAR_START_Y= 83;
const fBAR_START_X= 5;
const fBAR_H= 20.0;
const fBAR_W= 116.0;
const strBAR_EMPTY= "HP2_Menu.Icon.HP2EnemyHealthEmpty";
const strBAR_SEEKER_HUF= "HP2_Menu.Icon.HP2_QuidBarHuff";
const strBAR_SEEKER_SLY= "HP2_Menu.Icon.HP2_QuidBarSlyth";
const strBAR_SEEKER_RAV= "HP2_Menu.Icon.HP2_QuidBarRave";
const strBAR_SEEKER_GRY= "HP2_Menu.Icon.HP2_QuidBarGryf";
const strBAR_PEEVES= "HP2_Menu.Icon.HP2EnemyHealthPeeves";
const strBAR_DUELLIST= "HP2_Menu.Icon.HP2EnemyHealthWizard";
const strBAR_BASILISK= "HP2_Menu.Icon.HP2EnemyHealthBasilisk";
const strBAR_ARAGOG= "HP2_Menu.Icon.HP2EnemyHealthAragog";
var Texture textureBarFull;
var Texture textureBarEmpty;
var HChar Enemy;
var bool bRegisteredWithHud;


event PostBeginPlay()
{
	Super.PostBeginPlay();
	textureBarEmpty = Texture(DynamicLoadObject(strBAR_EMPTY, Class'Texture'));
}

function Start (HChar EnemyIn)
{
	local string MatchOpponent;

	Enemy = EnemyIn;
	switch (EnemyIn.EnemyHealthBar)
	{
		case EnemyIn.EEnemyBar.EnemyBar_Aragog:
			textureBarFull = Texture(DynamicLoadObject(strBAR_ARAGOG, Class'Texture'));
			break;

		case EnemyIn.EEnemyBar.EnemyBar_Basilisk:
			textureBarFull = Texture(DynamicLoadObject(strBAR_BASILISK, Class'Texture'));
			break;
  
		case EnemyIn.EEnemyBar.EnemyBar_Duellist:
			textureBarFull = Texture(DynamicLoadObject(strBAR_DUELLIST, Class'Texture'));
			break;

		case EnemyIn.EEnemyBar.EnemyBar_Peeves:
			textureBarFull = Texture(DynamicLoadObject(strBAR_PEEVES, Class'Texture'));
			break;
   
		case EnemyIn.EEnemyBar.EnemyBar_Seeker:
			switch (Seeker(EnemyIn).eHouse)
			{
		  
				case Seeker(EnemyIn).HouseAffiliation.HA_Gryffindor:
					textureBarFull = Texture(DynamicLoadObject(strBAR_SEEKER_GRY, Class'Texture'));
					break;
		  
				case Seeker(EnemyIn).HouseAffiliation.HA_Ravenclaw:
					textureBarFull = Texture(DynamicLoadObject(strBAR_SEEKER_RAV, Class'Texture'));
					break;
		
				case Seeker(EnemyIn).HouseAffiliation.HA_Hufflepuff:
					textureBarFull = Texture(DynamicLoadObject(strBAR_SEEKER_HUF, Class'Texture'));
					break;
		  
				case Seeker(EnemyIn).HouseAffiliation.HA_Slytherin:
					textureBarFull = Texture(DynamicLoadObject(strBAR_SEEKER_SLY, Class'Texture'));
					break;
			}
		break;
		
		default:
			Log("ERROR: Missing enemy health enum");
			textureBarFull = Texture(DynamicLoadObject(strBAR_DUELLIST, Class'Texture'));
			break;
	}
	GotoState('DisplayEnemyHealth');
}

function End()
{
	HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterEnemyHealth(None);
	bRegisteredWithHud = False;
	GotoState('Idle');
}

auto state Idle
{
}

state DisplayEnemyHealth
{
	event Tick (float fDelta)
	{
		if (  !bRegisteredWithHud )
		{
			if ( Level.PlayerHarryActor.myHUD != None )
			{
				HPHud(harry(Level.PlayerHarryActor).myHUD).RegisterEnemyHealth(self);
				bRegisteredWithHud = True;
			}
		}
	}
  
	function RenderHudItemManager (Canvas Canvas, bool bMenuMode, bool bFullCutMode, bool bHalfCutMode)
	{
		local float fScaleFactor;
		//local float fIconX;
		//local float fIconY;

		// Omega: Auto-casting not supported by out vars... again
		local int fIconX;
		local int fIconY;

		local float fEnemyHealth;
		local float fEmptyHealth;
		local float fEmptyW;
		local float fBarEmptyOffset;
		local float fSegmentWidth;
		local float fSegmentStartAt;
		
		CheckHUDReferences();
  
		fScaleFactor = GetScaleFactor(Canvas) * Class'M212HScale'.Static.CanvasGetHeightScale(Canvas);

		fIconX = fSCREEN_X  * fScaleFactor;
		fIconY = Canvas.SizeY - fScaleFactor * fSCREEN_UP_FROM_BOTTOM_Y;

		// Omega: Apply alignment and then the HUD scale
		AlignXToLeft(Canvas, fIconX);
		fIconX = ApplyHUDScale(Canvas, fIconX);

		Canvas.SetPos(fIconX,fIconY);
		Canvas.DrawIcon(textureBarFull,fScaleFactor);

		fEnemyHealth = Enemy.GetHealth();
		fEnemyHealth = FClamp(fEnemyHealth,0.0,1.0);
		fEmptyHealth = 1.0 - fEnemyHealth;

		fSegmentWidth = fEnemyHealth * fBAR_W;

		Canvas.SetPos(fIconX + fBAR_START_X * fScaleFactor,fIconY + fBAR_START_Y * fScaleFactor);
		Canvas.DrawTile(textureBarEmpty, fSegmentWidth * fScaleFactor, textureBarEmpty.VSize * fScaleFactor, 0.0, 0.0, fSegmentWidth, textureBarEmpty.VSize);

		if ( fEnemyHealth <= 0.0 )
		{
			End();
		}
	}
  
}

defaultproperties
{
    bHidden=True

    // DrawType=1
	DrawType=DT_Sprite
}
