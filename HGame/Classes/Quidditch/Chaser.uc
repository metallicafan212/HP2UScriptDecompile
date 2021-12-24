//================================================================================
// Chaser.
//================================================================================

class Chaser extends QuidditchPlayer;

state Fly
{
begin:
loop:
  FinishAnim();
  if ( bCapturedByCutScene )
  {
    if ( VSize(Velocity) < 50.0 )
    {
      LoopAnim('hover',,0.5);
    } else {
      LoopAnim('Fly_forward',,0.5);
    }
  } else {
    if ( FRand() < 0.89999998 )
    {
      LoopAnim('Fly_forward',,0.5);
    } else //{
      if ( FRand() < 0.922 )
      {
        LoopAnim('catch_right',,0.5);
        goto ('Catch');
      } else {
        LoopAnim('Look',,0.5);
      }
    //}
  }
  goto ('Loop');
Catch:
  FinishAnim();
  LoopAnim('Hold',,0.5);
  FinishAnim();
  Sleep(3.0);
  LoopAnim('throw_right',,0.5);
  goto ('Loop');
}

defaultproperties
{
    HouseDisplayInfo(0)=(Sex=SX_Female,Mesh=SkeletalMesh'HPModels.skQuidPlayerFMesh',MultiSkins[0]=Texture'HPModels.Skins.skQuidPlayerF_GTex0')

    HouseDisplayInfo(1)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skQuidPlayerMMesh',MultiSkins[0]=Texture'HPModels.Skins.skQuidPlayerM_RTex0')

    HouseDisplayInfo(2)=(Sex=SX_Female,Mesh=SkeletalMesh'HPModels.skQuidPlayerFMesh',MultiSkins[0]=Texture'HPModels.Skins.skQuidPlayerF_HTex0')

    HouseDisplayInfo(3)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skQuidPlayerMMesh',MultiSkins[0]=Texture'HPModels.Skins.skQuidPlayerM_STex0')

    IPSpeed=600.00
}
