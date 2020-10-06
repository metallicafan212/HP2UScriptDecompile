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

function PostBeginPlay ()
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
  
    // I = 0;
    // if ( I < 3 )
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
      // I++;
      // goto JL0007;
    }
	
    // I = 0;
    // if ( I < 3 )
	for(I = 0; I < 3; I++)
    {
	/*
      // if ( bool(PlayerHarry.Physics) == bool(2) )
	  if ( PlayerHarry.Physics == PHYS_Falling )
      {
        // goto JL03D7;
		continue;
      }
      if (  !ColObj[I].bBlockPlayers )
      {
        // goto JL03D7;
		continue;
      }
      vHLoc = PlayerHarry.Location;
      if ( VSize(vHLoc - ColObj[I].Location) > 200 )
      {
        // goto JL03D7;
		continue;
      }
      GetAxes(ColObj[I].Rotation,vX,vY,vZ);
      V = vX * (ColObj[I].CollisionRadius / 2);
      D = ColObj[I].CollisionRadius / 2 + PlayerHarry.CollisionRadius;
      if ( ((vHLoc - ColObj[I].Location + V) Dot vX) > D )
      {
        // goto JL03D7;
		continue;
      }
      if ( ((vHLoc - ColObj[I].Location - V) Dot  -vX) > D )
      {
        // goto JL03D7;
		continue;
      }
      V = vY * (ColObj[I].CollisionWidth / 2);
      D = ColObj[I].CollisionWidth / 2 + PlayerHarry.CollisionRadius;
      if ( ((vHLoc - ColObj[I].Location + V) Dot vY) > D )
      {
        // goto JL03D7;
		continue;
      }
      if ( ((vHLoc - ColObj[I].Location - V) Dot  -vY) > D )
      {
        // goto JL03D7;
		continue;
      }
      if (  !PlayerHarry.HarryIsDead() )
      {
        PlayerHarry.TakeDamage(Damage,tree,vect(0.00,0.00,0.00),vect(0.00,0.00,0.00),'None');
        PlayerHarry.DoJump();
        if ( ((vHLoc - ColObj[I].Location) Dot vX) > 0 )
        {
          PlayerHarry.Velocity = (vX + vect(0.00,0.00,1.00)) * 200;
        } else {
          PlayerHarry.Velocity = ( -vX + vect(0.00,0.00,1.00)) * 200;
        }
      }
	  
      // goto JL03E1;
      // I++;
      // goto JL00D1;
	  break;
    }
	*/
		
		//rewritten this code because the original doesn't work -AdamJD
		//
		if(PlayerHarry.Physics == PHYS_Falling)
		{
			continue;
		}

		if( !ColObj[i].bBlockPlayers )
		{
			continue;
		}

		vHLoc = PlayerHarry.Location;
		
		if(VSize(vHLoc - ColObj[i].Location) > 200)
		{
			continue;
		}

		GetAxes( ColObj[i].Rotation, vX, vY, vZ );
		
		v = vX * (ColObj[i].CollisionRadius / 2);
		d = ColObj[i].CollisionRadius/2 + PlayerHarry.CollisionRadius;
		
		if( ((vHLoc - (ColObj[i].Location + v)) dot  vX) > d )
		{
			continue;
		}
		
		if( ((vHLoc - (ColObj[i].Location - v)) dot -vX) > d )
		{
			continue;
		}
		
		v = vY * (ColObj[i].CollisionWidth / 2);
		d = ColObj[i].CollisionWidth/2 + PlayerHarry.CollisionRadius;
		
		if( ((vHLoc - (ColObj[i].Location + v)) dot  vY) > d )
		{
			continue;
		}
		
		if( ((vHLoc - (ColObj[i].Location - v)) dot -vY) > d )
		{
			continue;
		}
		
		if(!PlayerHarry.HarryIsDead())
		{
			PlayerHarry.TakeDamage( Damage, tree, vect(0,0,0), Vect(0,0,0), '');
			PlayerHarry.DoJump();
			
			if( ((vHLoc - ColObj[i].Location) dot vX) > 0 )
			{
				PlayerHarry.velocity = ( vX + vect(0,0,1)) * 200;
			}
			else
			{
				PlayerHarry.velocity = (-vX + vect(0,0,1)) * 200;
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
  ColObj[1].PlaySound(BackGroundRootSound,/*1*/SLOT_Misc,RandRange(0.81,1.0) * 0.5,,,RandRange(0.62,0.81));
  ColObj[1].PlaySound(Sound'pig_squeal1',/*2*/SLOT_Pain,RandRange(0.41,0.41),,,RandRange(0.23,0.25999999));
  switch (Rand(3))
  {
    case 0:
    ColObj[1].PlaySound(Sound'Root_up_creak1',/*0*/SLOT_None,RandRange(0.81,1.0) * 0.5,,,RandRange(0.81,1.25));
    break;
    case 1:
    ColObj[1].PlaySound(Sound'Root_up_creak2',/*0*/SLOT_None,RandRange(0.81,1.0) * 0.5,,,RandRange(0.81,1.25));
    break;
    case 2:
    ColObj[1].PlaySound(Sound'Root_up_creak3',/*0*/SLOT_None,RandRange(0.81,1.0) * 0.5,,,RandRange(0.81,1.25));
    break;
    default:
  }
  do
  {
    PlayAnim(RootAnimNameUp,tree.GetUpAnimRate(WhichRoot,TimingStage),0.1);
    FinishAnim();
    PlayAnim(RootAnimNameLoop,1.0,0.1);
    Sleep(tree.GetUpTime(WhichRoot,TimingStage));
    PlayAnim(RootAnimNameDown,tree.GetDownAnimRate(WhichRoot,TimingStage),0.1);
    ColObj[1].PlaySound(Sound'whomp06',/*0*/SLOT_None,RandRange(0.81,1.0),,,RandRange(0.69999999,0.81));
	do
	{
      Sleep(0.01);
	}
	until( AnimFrame > 3.0 / 9.0 );
    // if (! AnimFrame > 3.0 / 9.0 ) goto JL0203;
    DoHitGroundEffects();
    AnimRate = 1.0;
    FinishAnim();
    ColObj[1].StopSound(BackGroundRootSound,/*1*/SLOT_Misc);
    ColObj[1].StopSound(Sound'pig_squeal1',/*2*/SLOT_Pain,1.0);
    Sleep(tree.GetOnGroundTime(WhichRoot,TimingStage));
    TimingStage++;
    if ( (TimingStage >= 10) || (tree.GetUpAnimRate(WhichRoot,TimingStage) == 0) )
    {
      TimingStage = 0;
    }
  }
  until((VSize2D(PlayerHarry.Location - ColObj[1].Location) > 500) || bGoDisabled)
  // if (! (VSize2D(PlayerHarry.Location - ColObj[1].Location) > byte(500)) || bGoDisabled ) goto JL0000;
  GotoState('stateIdle');
}

function DoHitGroundEffects ()
{
  local Vector vX;
  local Vector vY;
  local Vector vZ;
  local int I;
  local int NumDustParts;

  GetAxes(ColObj[0].Rotation,vX,vY,vZ);
  if ( (PlayerHarry.Location - ColObj[0].Location) Dot vX < 0 )
  {
    vX =  -vX;
  }
  vX *= ColObj[0].CollisionRadius / 2;
  vY *= ColObj[0].CollisionWidth;
  vZ *=  -ColObj[0].CollisionHeight;
  NumDustParts = RandRange(3.0,4.0);
  
  // I = 0;
  // if ( I < NumDustParts )
  for(I = 0; I < NumDustParts; I++)
  {
    Spawn(PickRandomDustParticle(),None,,ColObj[0].Location + vX + vY * RandRange(-1.0,1.0) + vZ);
    // I++;
    // goto JL00C3;
  }
  
  NumDustParts = RandRange(2.0,4.0);
  // I = 0;
  // if ( I < NumDustParts )
  for(I = 0; I < NumDustParts; I++)
  {
    Spawn(PickRandomDustParticle(),None,,ColObj[1].Location + vX + vY * RandRange(-1.0,1.0) + vZ);
    // I++;
    // goto JL0136;
  }
  
  NumDustParts = RandRange(1.0,2.0);
  // I = 0;
  // if ( I < NumDustParts )
  for(I = 0; I < NumDustParts; I++)
  {
    Spawn(PickRandomDustParticle(),None,,ColObj[2].Location + vX + vY * RandRange(-1.0,1.0) + vZ);
    // I++;
    // goto JL01A9;
  }
  
  switch (Rand(3))
  {
    case 0:
    ColObj[1].PlaySound(Sound'Big_whomp2',/*5*/SLOT_Talk,1.0,,,RandRange(0.62,0.81));
    break;
    case 1:
    ColObj[1].PlaySound(Sound'Big_whomp3',/*5*/SLOT_Talk,1.0,,,RandRange(0.62,0.81));
    break;
    case 2:
    ColObj[1].PlaySound(Sound'Big_whomp4',/*5*/SLOT_Talk,1.0,,,RandRange(0.62,0.81));
    break;
    default:
  }
  ColObj[1].PlaySound(Sound'big_block_fall',/*0*/SLOT_None,0.62,,1000000.0,RandRange(0.5,0.69999999));
  PlayerHarry.ShakeView(0.5,200.0,200.0);
}

function Class<Dustclouds> PickRandomDustParticle ()
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
