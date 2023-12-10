//================================================================================
// cAnimChannel.
//================================================================================

class cAnimChannel extends AnimChannel;

var int LastAnimFrame;
var bool bCasting;
var float fTimeInRictusempra;
var float fTimeInMimbleWimble;

function Cast()
{
  Duellist(Owner).Cast();
}

auto state stateIdle
{
  function BeginState()
  {
    Duellist(Owner).PlayIdle();
  }
}

function DoCast()
{
  if (  !IsInState('stateCast') )
  {
    GotoState('stateCast');
  }
}

state stateCast
{
  function BeginState()
  {
    bCasting = True;
    Duellist(Owner).DuellistAnimType =  AT_Combine;
  }
  
  function Tick (float dtime)
  {
    local int Frame;
  
    Super.Tick(dtime);
    Frame = AnimFrame * 33;
	if ( (Frame >= 20) && (LastAnimFrame < 20) )
    {
      Duellist(Owner).Cast();
    }
    LastAnimFrame = Frame;
  }
  
 begin:
  PlayAnim('Cast',,[TweenTime]0.3);
  FinishAnim();
  Duellist(Owner).DuellistAnimType =  AT_Replace;
  bCasting = False;
  GotoState('stateIdle');
}

function DoCharging()
{
  if (  !IsInState('stateCharging') )
  {
    GotoState('stateCharging');
  }
}

state stateCharging
{
begin:
  Duellist(Owner).DuellistAnimType =  AT_Combine;
  LoopAnim('duel_charge',,[TweenTime]0.3);
  GotoState('stateIdle');
}

function DoDefence()
{
  if (  !IsInState('stateDefence') )
  {
    GotoState('stateDefence');
  }
}

state stateDefence
{
  function BeginState()
  {
    bCasting = True;
    Duellist(Owner).bReboundingSpells = True;
    Duellist(Owner).DuellistAnimType =  AT_Combine;
  }
  
 begin:
  Duellist(Owner).Defence();
  PlayAnim('cast_Expelliarmus',,[TweenTime]0.3);
  FinishAnim();
  Duellist(Owner).DuellistAnimType =  AT_Replace;
  Duellist(Owner).bReboundingSpells = False;
  bCasting = False;
  GotoState('stateIdle');
}

function DoKnockBack()
{
  if (  !IsInState('stateKnockBack') )
  {
    GotoState('stateKnockBack');
  }
}

state stateKnockBack
{
begin:
  Duellist(Owner).DuellistAnimType =  AT_Combine;
  PlayAnim('react_backfire',,[TweenTime]0.3);
  FinishAnim();
  Duellist(Owner).DuellistAnimType =  AT_Replace;
  GotoState('stateIdle');
}

function DoReactRictusempra()
{
  if (  !IsInState('stateReactRictusempra') )
  {
    GotoState('stateReactRictusempra');
  }
}

function QuitThisState (bool rictusempra)
{
  Duellist(Owner).GotoState('statePatrol');
  if ( rictusempra )
  {
    Duellist(Owner).StartCharging();
  }
  GotoState('stateIdle');
}

state stateReactRictusempra
{
  function Tick (float dtime)
  {
    fTimeInRictusempra += dtime;
    if ( fTimeInRictusempra > 2 )
    {
      QuitThisState(True);
    }
  }
  
  function BeginState()
  {
    Duellist(Owner).DuellistAnimType =  AT_Combine;
    fTimeInRictusempra = 0.0;
  }
  
 begin:
  Duellist(Owner).StopCharging();
  PlayAnim('react_rictusempra',,[TweenTime]0.3);
  Sleep(0.1);
  FinishAnim();
  Duellist(Owner).DuellistAnimType =  AT_Replace;
  QuitThisState(True);
}

function DoReactMimbleWimble()
{
  if (  !IsInState('stateReactMimbleWimble') )
  {
    GotoState('stateReactMimbleWimble');
  }
}

state stateReactMimbleWimble
{
  function Tick (float dtime)
  {
    fTimeInMimbleWimble += dtime;
    if ( fTimeInMimbleWimble > 2 )
    {
      QuitThisState(False);
    }
  }
  
  function BeginState()
  {
    Duellist(Owner).DuellistAnimType =  AT_Combine;
    fTimeInMimbleWimble = 0.0;
  }
  
 begin:
  Duellist(Owner).StopCharging();
  PlayAnim('mimblewimble',,[TweenTime]0.3);
  Sleep(0.1);
  FinishAnim();
  Duellist(Owner).DuellistAnimType =  AT_Replace;
  QuitThisState(False);
}

