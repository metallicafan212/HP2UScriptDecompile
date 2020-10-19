//================================================================================
// HProp.
//================================================================================

class HProp extends HPawn;

const START_CAM_ZOOM_DIST= 160.0;
enum EPickupFlyTo {
  FT_None,
  FT_Camera,
  FT_HudPosition,
  FT_DropOffInWorld
};

var Sound soundPickup;
var Sound soundPickup2;
var Sound soundDropOff;
var bool bPickupOnTouch;
var name EventToSendOnPickup;
var int nPickupIncrement;
var EPickupFlyTo PickupFlyTo;
var float fTotalFlyTime;
var float fCurrFlyTime;
var Vector vectHudLocation;
var float fCurrCameraZoomDist;
var bool bReadyForFlyEffect;
var Vector vectDropOffLoc;
var bool bDestroyAfterDropOff;
var float fMinFlyToHudScale;
var float fMaxFlyToHudScale;
var(StatusManager) Class<StatusGroup> classStatusGroup;
var(StatusManager) Class<StatusItem> classStatusItem;
var bool bBounceIntoPlaceTiming;
var float fBounceIntoPlaceTimeout;
var bool bBounceIntoPlace;
var Sound soundBounce;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  if ( bBounceIntoPlace )
  {
    bBounce = True;
    // SetPhysics(2);
	SetPhysics(PHYS_Falling);
    bBounceIntoPlaceTiming = False;
  }
}

function bool CanPickupNow (Actor Other)
{
  return (bPickupOnTouch == True) && (Other == PlayerHarry) && (GetStateName() != 'PickupProp') &&  !PlayerHarry.IsEngagedWithVendor() &&  !PlayerHarry.IsMixingPotion();
}

event Touch (Actor Other)
{
  if ( CanPickupNow(Other) )
  {
    DoPickupProp();
  }
}

function FaceCamera ()
{
  local Rotator R;

  R = PlayerHarry.Cam.Rotation;
  R.Yaw += 65536 / 4;
  R.Roll = R.Pitch;
  R.Pitch = 0;
  DesiredRotation = R;
  SetRotation(R);
}

function ZoomToCamera ()
{
  local Vector V;

  V.X = fCurrCameraZoomDist;
  SetLocation(PlayerHarry.Cam.Location + (V >> PlayerHarry.Cam.Rotation));
}

function FlyToNewPosition (float fMovePercent)
{
  local Vector vectMove;
  local bool bMovedSmooth;

  if ( fMovePercent < 1 )
  {
    fMovePercent = 1.0;
  }
  if ( PickupFlyTo == FT_HudPosition )
  {
    vectMove = (vectHudLocation - Location) / fMovePercent;
  } else //{
    if ( PickupFlyTo == FT_DropOffInWorld )
    {
      vectMove = (vectDropOffLoc - Location) / fMovePercent;
    } else {
      PlayerHarry.ClientMessage("ERROR:  Unrecognized PickupFlyTo value");
    }
  //}
  MoveSmooth(vectMove);
  DrawScale *= 0.94999999;
  if ( DrawScale < fMinFlyToHudScale )
  {
    DrawScale = fMinFlyToHudScale;
  }
}

function RenderHud (Canvas Canvas)
{
  Canvas.DrawActor(self,False,True);
}

function DoPickupProp ()
{
  GotoState('PickupProp');
}

function DoDropOffProp (Vector vSetDropOff, bool bDestroyWhenDone)
{
  vectDropOffLoc = vSetDropOff;
  bDestroyAfterDropOff = bDestroyWhenDone;
  GotoState('DropOffProp');
}

event HitWall (Vector HitNormal, Actor Wall)
{
  PlayerHarry.ClientMessage("hitwall " $ string(Wall.Name));
  if ( IsInState('PickupProp') || IsInState('DropOffProp') )
  {
    bHidden = True;
    bCollideWorld = False;
    SetCollision(False,False,False);
    HPHud(PlayerHarry.myHUD).RegisterPickupProp(self);
  }
}

function SetFlyProps ()
{
  // SetPhysics(4);
  SetPhysics(PHYS_Flying);
  bBounce = False;
  bCollideWorld = True;
  SetCollision(False,False,False);
}

function TickPickupOrDropOff (float Delta)
{
  local Vector Dest;

  if (  !bReadyForFlyEffect )
  {
    return;
  }
  switch (PickupFlyTo)
  {
    // case 2:
	case FT_HudPosition:
		//KW left this empty? -AdamJD
    // case 3:
	case FT_DropOffInWorld:
		fCurrFlyTime -= Delta;
		if ( fCurrFlyTime > 0 )
		{
		  FlyToNewPosition(fCurrFlyTime / Delta);
		}
		break;
    // case 1:
	case FT_Camera:
		fCurrCameraZoomDist -= Delta * 400;
		if ( fCurrCameraZoomDist > 0 )
		{
		  ZoomToCamera();
		  FaceCamera();
		}
		break;
    default:
		PlayerHarry.ClientMessage("ERROR:  Pickup type not recognized");
		break;
  }
}

state DropOffProp
{
  event Tick (float Delta)
  {
    TickPickupOrDropOff(Delta);
  }
  
  event BeginState ()
  {
    // PickupFlyTo = 3;
	PickupFlyTo = FT_DropOffInWorld;
    bReadyForFlyEffect = False;
  }
  
 begin:
  DrawScale = fMaxFlyToHudScale;
  if ( soundDropOff != None )
  {
    PlaySound(soundDropOff);
  }
  SetFlyProps();
  fCurrFlyTime = fTotalFlyTime;
  PlayerHarry.managerStatus.DropOffItem(self);
  bReadyForFlyEffect = True;
  // if ( fCurrFlyTime > byte(0) )
  while ( fCurrFlyTime > 0 )
  {
    Sleep(0.1);
    // goto JL0050;
  }
  HPHud(PlayerHarry.myHUD).UnregisterPickupProp(self);
  if ( bDestroyAfterDropOff == True )
  {
    bHidden = True;
    Destroy();
  }
}

state PickupProp
{
  event Tick (float Delta)
  {
    TickPickupOrDropOff(Delta);
  }
  
  event BeginState ()
  {
    bReadyForFlyEffect = False;
  }
  
 begin:
  DrawScale = fMaxFlyToHudScale;
  if ( (soundPickup != None) && (soundPickup2 != None) )
  {
    if ( Rand(2) == 0 )
    {
      PlaySound(soundPickup);
    } else {
      PlaySound(soundPickup2);
    }
  } else //{
    if ( soundPickup != None )
    {
      PlaySound(soundPickup);
    } else //{
      if ( soundPickup2 != None )
      {
        PlaySound(soundPickup2);
      }
    //}
  //}
  SetFlyProps();
  if ( PickupFlyTo == FT_HudPosition )
  {
    fCurrFlyTime = fTotalFlyTime;
    vectHudLocation = PlayerHarry.managerStatus.GetHudLocation(self);
    bReadyForFlyEffect = True;
    // if ( fCurrFlyTime > 0 )
	while ( fCurrFlyTime > 0 )
    {
      Sleep(0.1);
// JL00B2:
      // goto JL00B2;
    }
  } else //{
    if ( PickupFlyTo == FT_Camera )
    {
      FaceCamera();
      fCurrCameraZoomDist = 160.0;
      bReadyForFlyEffect = True;
      // if ( fCurrCameraZoomDist > 0 )
	  while ( fCurrCameraZoomDist > 0 )
      {
        Sleep(0.2);
        // goto JL00F3;
      }
    }
  //}
  PlayerHarry.managerStatus_PickupItem(self);
  if ( EventToSendOnPickup != 'None' )
  {
    TriggerEvent(EventToSendOnPickup,self,self);
  }
  bHidden = True;
  HPHud(PlayerHarry.myHUD).UnregisterPickupProp(self);
  Destroy();
}

state BounceIntoPlace
{
  function BeginState ()
  {
    bBounceIntoPlaceTiming = False;
    fBounceIntoPlaceTimeout = 5.0;
  }
  
  function Tick (float DeltaTime)
  {
    local Rotator NewRotation;
  
    Super.Tick(DeltaTime);
    NewRotation = Rotation;
    NewRotation.Yaw += 30000 * DeltaTime;
    SetRotation(NewRotation);
    if ( bBounceIntoPlaceTiming )
    {
      fBounceIntoPlaceTimeout -= DeltaTime;
    }
  }
  
  function HitWall (Vector HitNormal, Actor Wall)
  {
    Velocity *= 0.5;
    Velocity = MirrorVectorByNormal(Velocity,HitNormal);
    bBounceIntoPlaceTiming = True;
    if ( bBounceIntoPlaceTiming && (fBounceIntoPlaceTimeout >= 0) )
    {
      if ( (Abs(Velocity.Z) > 10) && (soundBounce != None) )
      {
        PlaySound(soundBounce,,Abs(Velocity.Z) / 100,,);
      }
    }
  }
  
 begin:
 loop:
  Sleep(1.0);
  goto ('Loop');
}

defaultproperties
{
    nPickupIncrement=1

    fTotalFlyTime=0.25

    fMinFlyToHudScale=0.50

    fMaxFlyToHudScale=1.00

    bGestureFaceHorizOnly=False

    AmbientGlow=75

    bBlockCamera=True
}
