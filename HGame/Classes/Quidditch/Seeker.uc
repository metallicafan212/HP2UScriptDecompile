//================================================================================
// Seeker.
//================================================================================

class Seeker extends QuidditchPlayer;

state Fly
{
  function BeginState ()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' Begin Seeking'));
    Log(string(Name) $ string(' Begin Seeking'));
    LoopAnim('Fly_forward',RandRange(0.922,1.084));
    if (  !bCapturedByCutScene )
    {
      FlyOnPath(PathToFly,iReturnPoint);
    }
  }
  
  function EndState ()
  {
    PlayerHarry.ClientMessage(string(Name) $ string(' End Seeking'));
    Log(string(Name) $ string(' End Seeking'));
    StopFlyingOnPath();
  }
  
 begin:
 loop:
  FinishAnim();
  if ( bCapturedByCutScene )
  {
    if ( bCaughtTarget )
    {
      LoopAnim('Hold',,0.1);
    } else {
      if ( VSize(Velocity) < 50.0 )
      {
        LoopAnim('hover',RandRange(0.922,1.084),0.5);
      } else {
        LoopAnim('Fly_forward',RandRange(0.922,1.084),0.5);
      }
    }
  } else {
    if ( (LookForTarget != None) &&  !bCaughtTarget &&  !LookForTarget.bHidden && (PathToFly != Path_Intro) &&  !bStunned )
    {
      Log(string(Name) $ " Sees Target, will pursue");
      GotoState('Pursue');
    }
    if ( bCaughtTarget )
    {
      LoopAnim('Hold',,0.1);
    } else //{
      if ( bStunned )
      {
        LoopAnim('Stunned',,0.5);
      } else //{
        if ( FRand() < 0.41 )
        {
          LoopAnim('Fly_forward',RandRange(0.922,1.084),0.5);
        } else //{
          if ( FRand() < 0.81 )
          {
            LoopAnim('Look',RandRange(0.922,1.084),0.5);
          } else {
            LoopAnim('hover',RandRange(0.922,1.084),0.5);
          }
        //}
      //}
    //}
  }
  goto ('Loop');
}

defaultproperties
{
    HouseDisplayInfo(0)=(Sex=SX_Female,Mesh=SkeletalMesh'HPModels.skQuidPlayerFMesh',MultiSkins=Texture'HPModels.Skins.skQuidPlayerF_GTex0')

    HouseDisplayInfo(1)=(Sex=SX_Female,Mesh=SkeletalMesh'HPModels.skQuidPlayerFMesh',MultiSkins=Texture'HPModels.Skins.skQuidPlayerF_RTex0')

    HouseDisplayInfo(2)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skQuidPlayerMMesh',MultiSkins=Texture'HPModels.Skins.skQuidPlayerM_HTex0')

    HouseDisplayInfo(3)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skDracoQuidMesh',MultiSkins=Texture'HPModels.Skins.skDracoQuidTex0')

    // EnemyHealthBar=4
	EnemyHealthBar=EnemyBar_Seeker

    IPSpeed=600.00
}
