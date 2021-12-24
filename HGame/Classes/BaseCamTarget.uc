//================================================================================
// BaseCamTarget.
//================================================================================

class BaseCamTarget extends HiddenHPawn; 

var Actor aAttachedTo;
var Vector vOffset;
var bool bRelative;
var BaseCam Cam;

function bool IsAttached()
{ 
  return aAttachedTo != None;
}

function SetOffset (Vector V)
{
  vOffset = V;
  UpdateOrientation();
}

function SetXOffset (float X)
{
  vOffset.X = X;
  UpdateOrientation();
}

function SetYOffset (float Y)
{
  vOffset.Y = Y;
  UpdateOrientation();
}

function SetZOffset (float Z)
{
  vOffset.Z = Z;
  UpdateOrientation();
}

function SetAttachedTo (Actor A)
{
  aAttachedTo = A;
  UpdateOrientation();
  TickParent = aAttachedTo;
}

function bool SetAttachedToByName (name nName)
{
  local Actor A;

  if ( nName != 'None' )
  {
    foreach AllActors(Class'Actor',A)
    {
      if ( (A.Name == nName) || (A.CutName ~= string(nName)) )
      {
        aAttachedTo = A;
        if ( bRelative )
        {
          SetLocation(aAttachedTo.Location + (vOffset >> aAttachedTo.Rotation));
        } else {
          SetLocation(aAttachedTo.Location + vOffset);
        }
        TickParent = aAttachedTo;
        PlayerHarry.ClientMessage("CamTarget is AttachedTo: " $ string(aAttachedTo));
        return True;
      }
    }
  }
  PlayerHarry.ClientMessage("Could not find targetActor with the name -> " $ string(nName));
  PlayerHarry.ClientMessage("Valid names you can use are as follows:");
  foreach AllActors(Class'Actor',A)
  {
    PlayerHarry.ClientMessage(string(A));
  }
  return False;
}

function bool SetAttachedToByCutName (string sCutName)
{
  local Actor A;

  if ( sCutName ~= "none" )
  {
    aAttachedTo = None;
    return True;
  }
  foreach AllActors(Class'Actor',A)
  {
    if ( (A.CutName ~= sCutName) || (string(A.Name) ~= sCutName) )
    {
      aAttachedTo = A;
      if ( bRelative )
      {
        SetLocation(aAttachedTo.Location + (vOffset >> aAttachedTo.Rotation));
      } else {
        SetLocation(aAttachedTo.Location + vOffset);
      }
      TickParent = aAttachedTo;
      return True;
    }
  }
  Cam.CutErrorString = "baseCam target could not find the actor with the CutName: " $ sCutName;
  return False;
}

function SetNewRotation (Rotator Rot)
{
	DesiredRotation = Rot;
	DesiredRotation.Yaw = DesiredRotation.Yaw & 65535;
	DesiredRotation.Pitch = DesiredRotation.Pitch & 65535;
	DesiredRotation.Roll = DesiredRotation.Roll & 65535;
	SetRotation(DesiredRotation);
}

event Tick (float fTimeDelta)
{
  Super.Tick(fTimeDelta);
  UpdateOrientation();
}

function UpdateOrientation()
{
  local Vector Delta;

  if ( aAttachedTo != None )
  {
    Delta = Vec(0.0,0.0,aAttachedTo.SavedPrePivotZ);
    SetNewRotation(aAttachedTo.Rotation);
    if ( bRelative )
    {
      SetLocation(aAttachedTo.Location + Delta + (vOffset >> Rotation));
    } else {
      SetLocation(aAttachedTo.Location + Delta + vOffset);
    }
  }
}

defaultproperties
{
    bIgnoreZonePainDamage=True

}
