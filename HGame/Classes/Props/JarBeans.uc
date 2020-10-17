//================================================================================
// JarBeans.
//================================================================================

class JarBeans extends HBottlesJars;

const fSPAWN_BEAN_RATE= 0.1;
var int nAddBeans;
var int nPointsPerBean;
var string strCueAddBeansDone;
var Jellybean NewJellybean;
var Vector vTopOfJar;
var StatusGroup sgJBeans;
var StatusItem siJBeans;
var float fWaitAfterDone;
var bool bCutBypass;
var float fTimeBetweenBeans;

function bool CutCommand (string Command, optional string cue, optional bool bFastFlag)
{
  local string sActualCommand;
  local string sCutName;
  local Actor A;

  sActualCommand = ParseDelimitedString(Command," ",1,False);
  if ( sActualCommand ~= "Capture" )
  {
    return True;
  } else //{
    if ( sActualCommand ~= "Release" )
    {
      return True;
    } else //{
      if ( sActualCommand ~= "AddBeans" )
      {
        nAddBeans = 2 * PlayerHarry.DuelRankBeans;
        if ( bFastFlag == True )
        {
          sgJBeans = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
          siJBeans = sgJBeans.GetStatusItem(Class'StatusItemJellybeans');
          siJBeans.IncrementCount(nAddBeans);
          if ( cue != "" )
          {
            CutCue(cue);
          }
        } else {
          strCueAddBeansDone = cue;
          bCutBypass = False;
          fWaitAfterDone = 0.0;
          GotoState('GiveHarryBeans');
        }
        return True;
      } else {
        return Super.CutCommand(Command,cue,bFastFlag);
      }
    //}
  //}
}

auto state Idle
{
}

state GiveHarryBeans
{
  function CutBypass ()
  {
    Super.CutBypass();
    GotoState('Idle');
  }
  
  function Tick (float fDelta)
  {
    if ( bCutBypass )
    {
      return;
    }
    if ( nAddBeans > 0 )
    {
      if ( fTimeBetweenBeans >= 0.1 )
      {
        fTimeBetweenBeans = 0.0;
        if ( nAddBeans < nPointsPerBean )
        {
          nPointsPerBean = nAddBeans;
        }
        NewJellybean = Jellybean(FancySpawn(Class'Jellybean',,,vTopOfJar));
        // NewJellybean.SetPhysics(1);
		NewJellybean.SetPhysics(PHYS_Walking);
        NewJellybean.nPickupIncrement = nPointsPerBean;
        NewJellybean.DoPickupProp();
        nAddBeans -= nPointsPerBean;
      } else {
        fTimeBetweenBeans += fDelta;
      }
    } else //{
      if ( fWaitAfterDone < 0.5 )
      {
        fWaitAfterDone += fDelta;
      } else {
        GotoState('Idle');
      }
    //}
  }
  
  function BeginState ()
  {
    vTopOfJar = Location;
    vTopOfJar.Z += CollisionHeight;
    if ( nAddBeans > 30 )
    {
      nPointsPerBean = nAddBeans / 30;
    } else {
      nPointsPerBean = 1;
    }
    sgJBeans = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupJellybeans');
    siJBeans = sgJBeans.GetStatusItem(Class'StatusItemJellybeans');
    sgJBeans.SetEffectTypeToPermanent();
    sgJBeans.SetCutSceneRenderMode(True);
    fTimeBetweenBeans = 0.1;
  }
  
  function EndState ()
  {
    if ( nAddBeans > 0 )
    {
      siJBeans.IncrementCount(nAddBeans);
    }
    sgJBeans.SetEffectTypeToNormal();
    sgJBeans.SetCutSceneRenderModeToNormal();
    if ( strCueAddBeansDone != "" )
    {
      CutCue(strCueAddBeansDone);
    }
  }
  
}

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skJarBeansMesh'

    DrawScale=2.50

    CollisionRadius=18.00

    CollisionHeight=32.00

    CutName="JarBeans"

}
