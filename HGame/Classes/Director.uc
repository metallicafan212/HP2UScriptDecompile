//================================================================================
// Director.
//================================================================================

class Director extends Actor;

var harry PlayerHarry;
var baseConsole Console;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  foreach AllActors(Class'harry',PlayerHarry)
  {
    // goto JL001A;
	break;
  }
}

function OnTouchEvent (Pawn Subject, Actor Object)
{
  PlayerHarry.ClientMessage(string(Subject.Name) $ " touched " $ string(Object.Name));
}

function OnUnTouchEvent (Pawn Subject, Actor Object)
{
  PlayerHarry.ClientMessage(string(Subject.Name) $ " untouched " $ string(Object.Name));
}

function OnBumpEvent (Pawn Subject, Actor Object)
{
  PlayerHarry.ClientMessage(string(Subject.Name) $ " bumped " $ string(Object.Name));
}

function OnHitEvent (Pawn Subject)
{
  PlayerHarry.ClientMessage(string(Subject.Name) $ " hit an obstacle");
}

function OnTakeDamage (Pawn Subject, int Damage, Pawn InstigatedBy, name DamageType)
{
  PlayerHarry.ClientMessage(string(Subject.Name) $ " took '" $ string(DamageType) $ "' damage");
}

function OnCutSceneEvent (name CutSceneTag)
{
  PlayerHarry.ClientMessage("CutScene " $ string(CutSceneTag) $ " triggered Director");
}

function OnTriggerEvent (Actor Other, Pawn EventInstigator)
{
  PlayerHarry.ClientMessage(string(Other) $ " triggered Director with " $ string(EventInstigator));
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  local CutScene CutScene;

  CutScene = CutScene(Other);
  if ( CutScene != None )
  {
    OnCutSceneEvent(CutScene.Tag);
  } else {
    OnTriggerEvent(Other,EventInstigator);
  }
}

function bool OnCutCapture()
{
  return True;
}

function bool OnCutRelease()
{
  return True;
}

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    return OnCutCapture();
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      return OnCutRelease();
    } else {
      PlayerHarry.ClientMessage("Director received an unknown cut-command");
      return Super.CutCommand(Command,cue,bFastFlag);
    }
  //}
}

function bool CutQuestion (string question)
{
  CutErrorString = "Unanswered";
  return False;
}

function OnPlayerPossessed()
{
  Log("Player possessed");
  Console = baseConsole(PlayerHarry.Player.Console);
}

function OnPlayerTravelPostAccept()
{
  Log("Player processed TravelPostAccept event");
}

function OnPlayerDying()
{
  PlayerHarry.ClientMessage("Player dying...");
}

function OnPlayersDeath()
{
  PlayerHarry.ClientMessage("Director: Player died");
}

function OnActionKeyPressed()
{
  PlayerHarry.ClientMessage("Action key pressed");
}

defaultproperties
{
    bHidden=True

    Tag=Director

    Texture=Texture'Engine.S_Flag'

    DrawScale=3.00

}
