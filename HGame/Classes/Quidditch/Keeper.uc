//================================================================================
// Keeper.
//================================================================================

class Keeper extends QuidditchPlayer;

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
    if ( FRand() < 0.3 )
    {
      LoopAnim('Fly_forward',,0.5);
    } else //{
      if ( FRand() < 0.6 )
      {
        LoopAnim('Look',,0.5);
      } else {
        LoopAnim('starfish',,0.5);
      }
    //}
  }
  goto ('Loop');
}

defaultproperties
{
    HouseDisplayInfo(0)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skOliverWoodQuidMesh',MultiSkins[0]=Texture'HPModels.Skins.skOliverWoodQuidTex0',MultiSkins[1]=Texture'HPModels.Skins.skOliverWoodQuidTex1',MultiSkins[2]=Texture'HPModels.Skins.skOliverWoodQuidTex2',MultiSkins[3]=Texture'HPModels.Skins.skOliverWoodQuidTex3',MultiSkins[4]=Texture'HPModels.Skins.skOliverWoodQuidTex4')

    HouseDisplayInfo(1)=(Sex=SX_Female,Mesh=SkeletalMesh'HPModels.skQuidPlayerFMesh',MultiSkins[0]=Texture'HPModels.Skins.skQuidPlayerF_RTex0')

    HouseDisplayInfo(2)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skQuidPlayerMMesh',MultiSkins[0]=Texture'HPModels.Skins.skQuidPlayerM_HTex0')

    HouseDisplayInfo(3)=(Sex=SX_Female,Mesh=SkeletalMesh'HPModels.skQuidPlayerFMesh',MultiSkins[0]=Texture'HPModels.Skins.skQuidPlayerF_STex0')

    IPSpeed=300.00
}
