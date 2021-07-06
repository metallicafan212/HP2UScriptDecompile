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
  textureBarEmpty = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2EnemyHealthEmpty",Class'Texture'));
}

function Start (HChar EnemyIn)
{
  local string MatchOpponent;

  Enemy = EnemyIn;
  switch (EnemyIn.EnemyHealthBar)
  {
    // case EnemyIn.0:
	case EnemyIn.EEnemyBar.EnemyBar_Aragog:
		textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2EnemyHealthAragog",Class'Texture'));
		break;
    // case EnemyIn.1:
	case EnemyIn.EEnemyBar.EnemyBar_Basilisk:
		textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2EnemyHealthBasilisk",Class'Texture'));
		break;
    // case EnemyIn.2:
	case EnemyIn.EEnemyBar.EnemyBar_Duellist:
		textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2EnemyHealthWizard",Class'Texture'));
		break;
    // case EnemyIn.3:
	case EnemyIn.EEnemyBar.EnemyBar_Peeves:
		textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2EnemyHealthPeeves",Class'Texture'));
		break;
    // case EnemyIn.4:
	case EnemyIn.EEnemyBar.EnemyBar_Seeker:
		switch (Seeker(EnemyIn).eHouse)
		{
		  // case 0:
		  case Seeker(EnemyIn).HouseAffiliation.HA_Gryffindor:
			  textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2_QuidBarGryf",Class'Texture'));
			  break;
		  // case 1:
		  case Seeker(EnemyIn).HouseAffiliation.HA_Ravenclaw:
			  textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2_QuidBarRave",Class'Texture'));
			  break;
		  // case 2:
		  case Seeker(EnemyIn).HouseAffiliation.HA_Hufflepuff:
			  textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2_QuidBarHuff",Class'Texture'));
			  break;
		  // case 3:
		  case Seeker(EnemyIn).HouseAffiliation.HA_Slytherin:
			  textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2_QuidBarSlyth",Class'Texture'));
			  break;
		  default:
		}
		break;
    default:
		Log("ERROR: Missing enemy health enum");
		textureBarFull = Texture(DynamicLoadObject("HP2_Menu.Icon.HP2EnemyHealthWizard",Class'Texture'));
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
    local float fIconX;
    local float fIconY;
    local float fEnemyHealth;
    local float fEmptyHealth;
    local float fEmptyW;
    local float fBarEmptyOffset;
    local float fSegmentWidth;
    local float fSegmentStartAt;
  
    fScaleFactor = GetScaleFactor(Canvas);
    fIconX = 4.0 * fScaleFactor;
    fIconY = Canvas.SizeY - fScaleFactor * 110.0;
    Canvas.SetPos(fIconX,fIconY);
    Canvas.DrawIcon(textureBarFull,fScaleFactor);
    fEnemyHealth = Enemy.GetHealth();
    fEnemyHealth = FClamp(fEnemyHealth,0.0,1.0);
    fEmptyHealth = 1.0 - fEnemyHealth;
    fSegmentWidth = fEnemyHealth * 116.0;
    Canvas.SetPos(fIconX + 5 * fScaleFactor,fIconY + 83 * fScaleFactor);
    Canvas.DrawTile(textureBarEmpty,fSegmentWidth * fScaleFactor,textureBarEmpty.VSize * fScaleFactor,0.0,0.0,fSegmentWidth,textureBarEmpty.VSize);
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
