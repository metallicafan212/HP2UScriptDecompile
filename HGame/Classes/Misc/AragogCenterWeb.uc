//================================================================================
// AragogCenterWeb.
//================================================================================

class AragogCenterWeb extends Actor;

var Aragog Spider;

function PostBeginPlay ()
{
  Super.PostBeginPlay();
  foreach AllActors(Class'Aragog',Spider)
  {
    // goto JL001A;
	break;
  }
}

function Touch (Actor Other)
{
  if ( Other.IsA('harry') )
  {
    Spider.bOnMyWeb = True;
  }
}

function Bump (Actor Other)
{
  Touch(Other);
}

defaultproperties
{
    bHidden=True

    CollisionRadius=465.00

    CollisionHeight=100.00

    bCollideActors=True

    bCollideWorld=True

    bBlockPlayers=True

}
