//================================================================================
// BeanRoomTimerManager.
//================================================================================

class BeanRoomTimerManager extends CountdownTimerManager;

function float GetTimerDuration()
{
  local harry PlayerHarry;
  local StatusGroup sgHousePts;
  local int nGryffPts;
  local int nRavenPts;
  local int nHuffPts;
  local int nSlythPts;
  local int nBestNonGryffPts;
  local int nGryffAheadBy;

  if ( fDuration != 0 )
  {
    return fDuration;
  }
  PlayerHarry = harry(Level.PlayerHarryActor);
  sgHousePts = PlayerHarry.managerStatus.GetStatusGroup(Class'StatusGroupHousePoints');
  if ( sgHousePts == None )
  {
    Log("ERROR: Couldn't get StatusGroupHousepoints object");
  }
  nGryffPts = sgHousePts.GetStatusItem(Class'StatusItemGryffindorPts').nCount;
  nRavenPts = sgHousePts.GetStatusItem(Class'StatusItemRavenclawPts').nCount;
  nHuffPts = sgHousePts.GetStatusItem(Class'StatusItemHufflePuffPts').nCount;
  nSlythPts = sgHousePts.GetStatusItem(Class'StatusItemSlytherinPts').nCount;
  nBestNonGryffPts = Max(nRavenPts,nHuffPts);
  nBestNonGryffPts = Max(nBestNonGryffPts,nSlythPts);
  if ( nGryffPts < nBestNonGryffPts )
  {
    Log("ERROR: Gryffindor not ahead-- should not be in bonus level");
    nGryffPts = nBestNonGryffPts;
  }
  nGryffAheadBy = nGryffPts - nBestNonGryffPts;
  if ( nGryffAheadBy > 1500 )
  {
    fDuration = 400.0;
  } else //{
    if ( nGryffAheadBy > 1200 )
    {
      fDuration = 370.0;
    } else //{
      if ( nGryffAheadBy > 1000 )
      {
        fDuration = 350.0;
      } else //{
        if ( nGryffAheadBy > 800 )
        {
          fDuration = 340.0;
        } else //{
          if ( nGryffAheadBy > 600 )
          {
            fDuration = 330.0;
          } else //{
            if ( nGryffAheadBy > 500 )
            {
              fDuration = 320.0;
            } else //{
              if ( nGryffAheadBy > 450 )
              {
                fDuration = 310.0;
              } else //{
                if ( nGryffAheadBy > 380 )
                {
                  fDuration = 300.0;
                } else //{
                  if ( nGryffAheadBy > 330 )
                  {
                    fDuration = 280.0;
                  } else //{
                    if ( nGryffAheadBy > 300 )
                    {
                      fDuration = 250.0;
                    } else //{
                      if ( nGryffAheadBy > 280 )
                      {
                        fDuration = 220.0;
                      } else //{
                        if ( nGryffAheadBy > 250 )
                        {
                          fDuration = 190.0;
                        } else //{
                          if ( nGryffAheadBy > 220 )
                          {
                            fDuration = 170.0;
                          } else //{
                            if ( nGryffAheadBy > 190 )
                            {
                              fDuration = 150.0;
                            } else //{
                              if ( nGryffAheadBy > 175 )
                              {
                                fDuration = 140.0;
                              } else //{
                                if ( nGryffAheadBy > 185 )
                                {
                                  fDuration = 130.0;
                                } else //{
                                  if ( nGryffAheadBy > 165 )
                                  {
                                    fDuration = 120.0;
                                  } else //{
                                    if ( nGryffAheadBy > 150 )
                                    {
                                      fDuration = 110.0;
                                    } else //{
                                      if ( nGryffAheadBy > 120 )
                                      {
                                        fDuration = 100.0;
                                      } else //{
                                        if ( nGryffAheadBy > 100 )
                                        {
                                          fDuration = 90.0;
                                        } else //{
                                          if ( nGryffAheadBy > 85 )
                                          {
                                            fDuration = 80.0;
                                          } else //{
                                            if ( nGryffAheadBy > 70 )
                                            {
                                              fDuration = 70.0;
                                            } else //{
                                              if ( nGryffAheadBy > 55 )
                                              {
                                                fDuration = 60.0;
                                              } else //{
                                                if ( nGryffAheadBy > 40 )
                                                {
                                                  fDuration = 50.0;
                                                } else //{
                                                  if ( nGryffAheadBy > 30 )
                                                  {
                                                    fDuration = 40.0;
                                                  } else //{
                                                    if ( nGryffAheadBy > 20 )
                                                    {
                                                      fDuration = 35.0;
                                                    } else //{
                                                      if ( nGryffAheadBy > 15 )
                                                      {
                                                        fDuration = 30.0;
                                                      } else //{
                                                        if ( nGryffAheadBy > 10 )
                                                        {
                                                          fDuration = 25.0;
                                                        } else //{
                                                          if ( nGryffAheadBy > 5 )
                                                          {
                                                            fDuration = 20.0;
                                                          } else {
                                                            fDuration = 10.0;
                                                          }
														 
			//WTF UTPT... -AdamJD
                                                        // }
                                                      // }
                                                    // }
                                                  // }
                                                // }
                                              // }
                                            // }
                                          // }
                                        // }
                                      // }
                                    // }
                                  // }
                                // }
                              // }
                            // }
                          // }
                        // }
                      // }
                    // }
                  // }
                // }
              // }
            // }
          // }
        // }
      // }
    // }
  // }
  return fDuration;
}

defaultproperties
{
    CutName="BeanRoomTimerManager"

}
