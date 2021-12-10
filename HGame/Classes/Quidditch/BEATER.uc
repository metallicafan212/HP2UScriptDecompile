//================================================================================
// BEATER.
//================================================================================

class BEATER extends QuidditchPlayer;

state() Fly
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
    if ( bCaughtTarget )
    {
      LoopAnim('Hold',,0.1);
    } else //{
      if ( FRand() < 0.41 )
      {
        LoopAnim('Fly_forward',,0.5);
      } else //{
        if ( FRand() < 0.62 )
        {
          LoopAnim('Look',,0.5);
        } else //{
          if ( FRand() < 0.69999999 )
          {
            LoopAnim('hover',,0.5);
          } else //{
            if ( FRand() < 0.81 )
            {
              if ( eHouse == HA_Gryffindor )
              {
                LoopAnim('throw_left',,0.5);
              } else {
                LoopAnim('hit_bludger_left',,0.5);
              }
            } else //{
              if ( eHouse == HA_Gryffindor )
              {
                LoopAnim('throw_right',,0.5);
              } else {
                LoopAnim('hit_bludger_right',,0.5);
              }
            //}
          //}
        //}
      //}
    //}
  }
  goto ('Loop');
}

defaultproperties
{
    HouseDisplayInfo(0)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skGeorgeWQuidMesh',MultiSkins[0]=Texture'HPModels.Skins.skGeorgeWQuidTex0',MultiSkins[1]=Texture'HPModels.Skins.skGeorgeWQuidTex1',MultiSkins[2]=Texture'HPModels.Skins.skGeorgeWQuidTex2',MultiSkins[3]=Texture'HPModels.Skins.skGeorgeWQuidTex3',MultiSkins[4]=Texture'HPModels.Skins.skGeorgeWQuidTex4')

    HouseDisplayInfo(1)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skBeaterMesh',MultiSkins[0]=Texture'HPModels.Skins.skBeater_RTex0')

    HouseDisplayInfo(2)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skBeaterMesh',MultiSkins[0]=Texture'HPModels.Skins.skBeater_HTex0')

    HouseDisplayInfo(3)=(Sex=SX_Male,Mesh=SkeletalMesh'HPModels.skBeaterMesh',MultiSkins[0]=Texture'HPModels.Skins.skBeater_STex0')

    IPSpeed=600.00
}
