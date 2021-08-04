//================================================================================
// WizardCardIcon.
//================================================================================

class WizardCardIcon extends HProp
  Abstract;

var() bool bPickupSendsEvent;
var Rotator NewRot;
var Vector StartPoint;
var float fHeight;
var float fTimeToTargetPoint;
var float fTimeToWait;
var float fStartTimeToTargetPoint;
var string WizardName;
var int Id;
var bool bVendorsCanSell;
var string strVendorOwnedAfterGState;
var WizCardSpin SpinFX;
var Vector PreviousLocation;
var bool bBouncingState;
var Texture textureBig;
var string strDescriptionId;
var bool bIsLayered;
var bool bLastLayerIsFire;
var Texture textureLayers[3];

function PreBeginPlay()
{
  Super.PreBeginPlay();
}

function Spawned()
{
  local ParticleFX explosion;

  // SetPhysics(2);
  SetPhysics(PHYS_Falling);
  bBouncingState = True;
  explosion = Spawn(Class'WizCard_Explo',,,Location);
  explosion = Spawn(Class'Spawn_flash_1',,,Location);
  GotoState('bouncing');
}

function PostBeginPlay()
{
  Super.PostBeginPlay();
}

function Touch (Actor Other)
{
  local harry harry;
  local StatusGroupWizardCards sgCards;
  //local Class<StatusItem> classStatusItem;
  local StatusItemWizardCards siCard;
  local int nNewCardCount;
  local int nOldCardCount;
  local Rotator rotPickupFX;

  harry = harry(Other);
  if ( harry == None )
  {
    return;
  }
  if (  !CanPickupNow(Other) )
  {
    return;
  }
  rotPickupFX.Pitch = 16464;
  rotPickupFX.Yaw = 0;
  rotPickupFX.Roll = 0;
  if ( bPickupSendsEvent )
  {
    TriggerEvent(Event,self,None);
  }
  if ( IsA('BronzeCards') )
  {
    classStatusItem = Class'StatusItemBronzeCards';
  } else //{
    if ( IsA('SilverCards') )
    {
      classStatusItem = Class'StatusItemSilverCards';
    } else //{
      if ( IsA('Goldcards') )
      {
        classStatusItem = Class'StatusItemGoldCards';
      } else {
        harry.ClientMessage("Error WizardCard class " $ string(Class) $ " not recognized");
      }
    //}
  //}
  sgCards = StatusGroupWizardCards(harry.managerStatus.GetStatusGroup(Class'StatusGroupWizardCards'));
  siCard = StatusItemWizardCards(sgCards.GetStatusItem(classStatusItem));
  nOldCardCount = siCard.nCount;
  //siCard.SetCardOwner(Id,siCard.1);
  siCard.SetCardOwner(Id,siCard.ECardOwner.CardOwner_Harry);
  nNewCardCount = siCard.nCount;
  if ( IsA('BronzeCards') )
  {
    if ( nOldCardCount != nNewCardCount )
    {
      if ( nNewCardCount % 10 == 0 )
      {
        FancySpawn(Class'BronzeStamina',,,,rotPickupFX);
        harry.DoCelebrateCardSet(True);
      } else {
        FancySpawn(Class'BronzePickup',,,,rotPickupFX);
      }
    }
  } else //{
    if ( IsA('SilverCards') )
    {
      if ( nOldCardCount != nNewCardCount )
      {
        if ( nNewCardCount % 10 == 0 )
        {
          FancySpawn(Class'SilverUnlock',,,,rotPickupFX);
          harry.DoCelebrateCardSet(False);
        } else {
          FancySpawn(Class'SilverPickup',,,,rotPickupFX);
        }
      }
    } else //{
      if ( IsA('Goldcards') )
      {
        FancySpawn(Class'GoldPickup',,,,rotPickupFX);
      }
    //}
  //}
  sgCards.RemoveHarryOwnedCardsFromLevel(self);
  Super.Touch(Other);
}

state bouncing
{
  function HitWall (Vector HitNormal, Actor Wall)
  {
    Log("WizardIcon: Hit wall");
    Velocity *= 0.5;
    Velocity = MirrorVectorByNormal(Velocity,HitNormal);
    if ( HitNormal Dot vect(0.00,0.00,1.00) > 0.86659998 )
    {
      Velocity *= vect(0.00,0.00,1.00);
      GotoState('Wait');
    }
    PreviousLocation = Location;
  }
  
  function Tick (float Delta)
  {
    NewRot = Rotation;
    NewRot.Yaw = NewRot.Yaw + 50000 * Delta;
	SetRotation(NewRot);
  }
  
}

auto state Wait
{
  function HitWall (Vector HitNormal, Actor Wall)
  {
  }
  
  function Tick (float Delta)
  {
    if ( bBouncingState )
    {
      bBouncingState = False;
      GotoState('bouncing');
    }
    NewRot = Rotation;
    NewRot.Yaw = NewRot.Yaw + 50000 * Delta;
	SetRotation(NewRot);
  }
  
 begin:
  Sleep(1.0);
  goto ('Begin');
}

defaultproperties
{
    fHeight=50.00

    fTimeToTargetPoint=3.20

    fTimeToWait=3.00

    WizardName="Unknown"

    nPickupIncrement=0

    bCantStandOnMe=True

    bPersistent=True

    Mesh=SkeletalMesh'HProps.skWizardCardIconMesh'

    DrawScale=2.00

    AmbientGlow=250

    CollisionRadius=12.00

    CollisionHeight=20.00

    bBlockPlayers=False

    bBlockCamera=False

    bBounce=True

    bRotateToDesired=False
}
