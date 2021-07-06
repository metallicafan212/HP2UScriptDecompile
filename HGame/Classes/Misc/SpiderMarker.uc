//================================================================================
// SpiderMarker.
//================================================================================

class SpiderMarker extends Actor;

//texture import -AdamJD
#exec Texture Import File=Textures\HiddenPawn.PNG Name=HiddenPawn COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914

const BOOL_DEBUG_AI= false;
var() bool bCenter;
var() string GroupName;
var() int numLargeSpiders;
var() int numSmallSpiders;
var() float checkSpiderTime;
var float checkTime;
var SpiderSpawner largeSpawner;
var SpiderSpawner smallSpawner;
var PlayerPawn PlayerHarry;
var Aragog Spider;

function PreBeginPlay()
{
  Super.PreBeginPlay();
  SetCollision(,);
  bCollideWorld = False;
  foreach AllActors(Class'PlayerPawn',PlayerHarry)
  {
    // goto JL0027;
	break;
  }
  foreach AllActors(Class'Aragog',Spider)
  {
    // goto JL003C;
	break;
  }
}

function PostBeginPlay()
{
  SetCollision(True,False,False);
  if ( (numSmallSpiders != 0) || (numLargeSpiders != 0) )
  {
    FindClosestSpawner();
    checkTime = checkSpiderTime;
  }
}

function FindClosestSpawner()
{
  local int Counter;
  local float Dist;
  local float farthestDist;
  local SpiderSpawner ss;

  farthestDist = 1215752192.0;
  if ( numSmallSpiders != 0 )
  {
    foreach AllActors(Class'SpiderSpawner',ss)
    {
      if ( ss.bSmallSpiders == True )
      {
        if ( VSize(ss.Location - Location) < farthestDist )
        {
          smallSpawner = ss;
          farthestDist = VSize(ss.Location - Location);
        }
      }
    }
  }
  farthestDist = 1215752192.0;
  if ( numLargeSpiders != 0 )
  {
    foreach AllActors(Class'SpiderSpawner',ss)
    {
      if ( ss.bSmallSpiders == False )
      {
        if ( VSize(ss.Location - Location) < farthestDist )
        {
          largeSpawner = ss;
          farthestDist = VSize(ss.Location - Location);
        }
      }
    }
  }
}

function incrementNumSmallSpiders()
{
  if ( numSmallSpiders != 0 )
  {
    numSmallSpiders++;
  }
}

function incrementNumLargeSpiders()
{
  if ( numLargeSpiders != 0 )
  {
    numLargeSpiders++;
  }
}

function disableMarker()
{
  numLargeSpiders = 0;
  numSmallSpiders = 0;
  GotoState('disabled');
}

function Touch (Actor Other)
{
  Super.Touch(Other);
}

function UnTouch (Actor Other)
{
  Super.UnTouch(Other);
}

function Bump (Actor Other)
{
  Touch(Other);
}

auto state justWait
{
  function Tick (float DeltaTime)
  {
    local int smallFound;
    local int largeFound;
    local SpiderSmall smallSpider;
    local SpiderLarge largeSpider;
  
    if ( (numSmallSpiders != 0) || (numLargeSpiders != 0) )
    {
      checkTime -= DeltaTime;
      if ( checkTime <= 0 )
      {
        checkTime = checkSpiderTime;
        if ( numSmallSpiders != 0 )
        {
          foreach AllActors(Class'SpiderSmall',smallSpider)
          {
            if ( smallSpider.GroupName == GroupName )
            {
              smallFound++;
            }
          }
        }
        if ( numLargeSpiders != 0 )
        {
          foreach AllActors(Class'SpiderLarge',largeSpider)
          {
            if ( largeSpider.GroupName == GroupName )
            {
              largeFound++;
            }
          }
        }
        if ( largeFound < numLargeSpiders )
        {
          PlayerHarry.ClientMessage("Spawning Large Spiders :  " $ string(numLargeSpiders - largeFound));
          largeSpawner.SpawnRandomSpiders(numLargeSpiders - largeFound);
        }
        if ( smallFound < numSmallSpiders )
        {
          PlayerHarry.ClientMessage("Spawning Small Spiders :  " $ string(numSmallSpiders - smallFound));
          smallSpawner.SpawnRandomSpiders(numSmallSpiders - smallFound);
        }
      }
    }
  }
  
}

state disabled
{
}

defaultproperties
{
    GroupName="'"

    checkSpiderTime=15.00

    bHidden=True

    Tag="'"

    Texture=Texture'HGame.HiddenPawn'

    CollisionRadius=50.00

    CollisionHeight=5.00
}
