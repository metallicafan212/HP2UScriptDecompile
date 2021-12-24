//================================================================================
// WhompWRController.
//================================================================================

class WhompWRController extends AnimChannel;

var WhompingWillow tree;
var int WhichRoot;
var int TimingStage;
var name RootAnimNameUp;
var name RootAnimNameLoop;
var name RootAnimNameDown;
var GenericColObj ColObj[3];
var float ColTime1[3];
var float ColTime2[3];
var harry PlayerHarry;
var bool bGoDisabled;
var int Damage;
var Sound BackGroundRootSound;

function PostBeginPlay()
{
  tree = WhompingWillow(Owner);
  PlayerHarry = tree.PlayerHarry;
}

auto state stateIdle
{
/*
  Sleep(0.5);
  if (! VSize2D(PlayerHarry.Location - ColObj[1].Location) < byte(500) ) goto JL0000;
*/

begin:	
  do
  {
    Sleep(0.5);	
  }
  until(VSize2D(PlayerHarry.Location - ColObj[1].Location) < 500);
  
  if (  !bGoDisabled )
  {
    GotoState('ThrashingAndSmashing');
  }
}

function Trigger (Actor Other, Pawn EventInstigator)
{
  local WhompWRController A;

  bGoDisabled = True;
}

state ThrashingAndSmashing
{
  function Tick (float dtime)
  {
    local int I;
    local Vector vX;
    local Vector vY;
    local Vector vZ;
    local Vector vHLoc;
    local Vector V;
    local float D;
  
	for(I = 0; I < 3; I++)
    {
      if ( AnimSequence == RootAnimNameUp && AnimFrame < ColTime1[I] || AnimSequence == RootAnimNameDown && AnimFrame > ColTime2[I] )
      {
        if (  !ColObj[I].bBlockPlayers )
        {
          ColObj[I].SetCollision(True,True,True);
        }
      } else {
        if ( ColObj[I].bBlockPlayers )
        {
          ColObj[I].SetCollision(True,True,False);
        }
      }
    }
		
	for(I = 0; I < 3; I++)
    {	
		if(PlayerHarry.Physics == PHYS_Falling)
		{
			continue;
		}

		if( !ColObj[I].bBlockPlayers )
		{
			continue;
		}

		vHLoc = PlayerHarry.Location;
		
		if(VSize(vHLoc - ColObj[I].Location) > 200)
		{
			continue;
		}

		GetAxes( ColObj[I].Rotation, vX, vY, vZ );
		
		V = vX * (ColObj[I].CollisionRadius / 2);
		D = ColObj[I].CollisionRadius / 2 + PlayerHarry.CollisionRadius;
		
		if( ((vHLoc - (ColObj[I].Location + V)) Dot  vX) > D )
		{
			continue;
		}
		
		if( ((vHLoc - (ColObj[I].Location - V)) Dot -vX) > D )
		{
			continue;
		}
		
		V = vY * (ColObj[I].CollisionWidth / 2);
		D = ColObj[I].CollisionWidth / 2 + PlayerHarry.CollisionRadius;
		
		if( ((vHLoc - (ColObj[I].Location + V)) Dot  vY) > D )
		{
			continue;
		}
		
		if( ((vHLoc - (ColObj[I].Location - V)) Dot -vY) > D )
		{
			continue;
		}
		
		if(!PlayerHarry.HarryIsDead())
		{
			PlayerHarry.TakeDamage( Damage, tree, vect(0,0,0), Vect(0,0,0), '');
			PlayerHarry.DoJump();
			
			if( ((vHLoc - ColObj[I].Location) Dot vX) > 0 )
			{
				PlayerHarry.Velocity = ( vX + vect(0,0,1)) * 200;
			}
			else
			{
				PlayerHarry.Velocity = (-vX + vect(0,0,1)) * 200;
			}
		}

		break;
	}
  }
  
 begin:
  if ( FRand() < 0.5 )
  {
    BackGroundRootSound = Sound'willow_base_growl';
  } else {
    BackGroundRootSound = Sound'willow_base_woodmovement';
  }
  do
  {
    ColObj[1].PlaySound(BackGroundRootSound,SLOT_Misc,RandRange(0.81,1.0) * 0.5,,,RandRange(0.62,0.81));
    ColObj[1].PlaySound(Sound'pig_squeal1',SLOT_Pain,RandRange(0.41,0.41),,,RandRange(0.23,0.25999999));
    switch (Rand(3))
    {
      case 0:
      ColObj[1].PlaySound(Sound'Root_up_creak1',SLOT_None,RandRange(0.81,1.0) * 0.5,,,RandRange(0.81,1.25));
      break;
      case 1:
      ColObj[1].PlaySound(Sound'Root_up_creak2',SLOT_None,RandRange(0.81,1.0) * 0.5,,,RandRange(0.81,1.25));
      break;
      case 2:
      ColObj[1].PlaySound(Sound'Root_up_creak3',SLOT_None,RandRange(0.81,1.0) * 0.5,,,RandRange(0.81,1.25));
      break;
      default:
    }
    PlayAnim(RootAnimNameUp,tree.GetUpAnimRate(WhichRoot,TimingStage),0.1);
    FinishAnim();
    PlayAnim(RootAnimNameLoop,1.0,0.1);
    Sleep(tree.GetUpTime(WhichRoot,TimingStage));
    PlayAnim(RootAnimNameDown,tree.GetDownAnimRate(WhichRoot,TimingStage),0.1);
    ColObj[1].PlaySound(Sound'whomp06',SLOT_None,RandRange(0.81,1.0),,,RandRange(0.69999999,0.81));
	do
	{
      Sleep(0.01);
	}
	until( AnimFrame > 3.0 / 9.0 );
    DoHitGroundEffects();
    AnimRate = 1.0;
    FinishAnim();
    ColObj[1].StopSound(BackGroundRootSound,SLOT_Misc);
    ColObj[1].StopSound(Sound'pig_squeal1',SLOT_Pain,1.0);
    Sleep(tree.GetOnGroundTime(WhichRoot,TimingStage));
    TimingStage++;
    if ( (TimingStage >= 10) || (tree.GetUpAnimRate(WhichRoot,TimingStage) == 0) )
    {
      TimingStage = 0;
    }
  }
  until((VSize2D(PlayerHarry.Location - ColObj[1].Location) > 500) || bGoDisabled);
  GotoState('stateIdle');
}

function DoHitGroundEffects()
{
  local Vector vX;
  local Vector vY;
  local Vector vZ;
  local int I;
  local int NumDustParts;

  GetAxes(ColObj[0].Rotation,vX,vY,vZ);
  if ( ((PlayerHarry.Location - ColObj[0].Location) Dot vX) < 0 )
  {
    vX =  -vX;
  }
  vX *= ColObj[0].CollisionRadius / 2;
  vY *= ColObj[0].CollisionWidth;
  vZ *=  -ColObj[0].CollisionHeight;
  
  NumDustParts = RandRange(3.0,4.0);
  for(I = 0; I < NumDustParts; I++)
  {
    Spawn(PickRandomDustParticle(),None,,[SpawnLocation]ColObj[0].Location + vX + vY * RandRange(-1.0,1.0) + vZ);
  }
  
  NumDustParts = RandRange(2.0,4.0);
  for(I = 0; I < NumDustParts; I++)
  {
    Spawn(PickRandomDustParticle(),None,,[SpawnLocation]ColObj[1].Location + vX + vY * RandRange(-1.0,1.0) + vZ);
  }
  
  NumDustParts = RandRange(1.0,2.0);
  for(I = 0; I < NumDustParts; I++)
  {
    Spawn(PickRandomDustParticle(),None,,[SpawnLocation]ColObj[2].Location + vX + vY * RandRange(-1.0,1.0) + vZ);
  }
  
  switch (Rand(3))
  {
    case 0:
    ColObj[1].PlaySound(Sound'Big_whomp2',SLOT_Talk,1.0,,,RandRange(0.62,0.81));
    break;
    case 1:
    ColObj[1].PlaySound(Sound'Big_whomp3',SLOT_Talk,1.0,,,RandRange(0.62,0.81));
    break;
    case 2:
    ColObj[1].PlaySound(Sound'Big_whomp4',SLOT_Talk,1.0,,,RandRange(0.62,0.81));
    break;
    default:
  }
  ColObj[1].PlaySound(Sound'big_block_fall',SLOT_None,0.62,,1000000.0,RandRange(0.5,0.69999999));
  PlayerHarry.ShakeView(0.5,200.0,200.0);
}

function Class<Dustclouds> PickRandomDustParticle()
{
  local int I;

  I = Rand(100);
  if ( I > 60 )
  {
    return Class'DustCloud03_med';
  }
  if ( I > 45 )
  {
    return Class'DustCloud01_tiny';
  }
  if ( I > 30 )
  {
    return Class'DustCloud02_small';
  }
  if ( I > 15 )
  {
    return Class'DustCloud05_lrg';
  }
  return Class'DustCloud04_med';
}

defaultproperties
{
    ColTime1(0)=0.10

    ColTime1(1)=0.09

    ColTime1(2)=0.15

    ColTime2(0)=0.35

    ColTime2(1)=0.30

    ColTime2(2)=0.10

}
