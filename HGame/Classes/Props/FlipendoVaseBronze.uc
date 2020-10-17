//================================================================================
// FlipendoVaseBronze.
//================================================================================

class FlipendoVaseBronze extends HFlipendo;

var Class<Actor> ShardType;
var Mesh brokentypeMesh;
var bool bBustedOnce;

auto state waitforspell
{
  function Trigger (Actor Other, Pawn EventInstigator)
  {
    GotoState('Break');
  }
  
  function bool HandleSpellFlipendo (optional baseSpell spell, optional Vector vHitLocation)
  {
    local Vector Dir;
    local Vector Vel;
    local Actor newSpawn;
    local Rotator NewRot;
  
    Dir.X = 20.0;
    Dir.Y = 0.0;
    Dir.Z = 0.0;
    Dir = Dir >> Rotation;
    Vel = Dir * 4;
    Dir = Dir + Location;
    PlaySound(Sound'vase_breaking');
    newSpawn = FancySpawn(Class'avifors_hit');
    SetCollision(False,False,False);
    if (  !bBustedOnce )
    {
      newSpawn = FancySpawn(transformInto);
      if ( newSpawn.IsA('Jellybean') )
      {
        newSpawn.Velocity = Vel;
      }
    }
    if (  !bBustedOnce )
    {
      NewRot = rotator((Location - vHitLocation) * vect(1.00,1.00,0.00));
      SetRotation(NewRot);
      Mesh = brokentypeMesh;
      bBustedOnce = True;
    } else {
      Destroy();
    }
    SetCollision(False,False,False);
    FancySpawn(Class'FlipendoVaseBronzeShard');
    FancySpawn(Class'FlipendoVaseBronzeShard');
    FancySpawn(Class'FlipendoVaseBronzeShard');
    FancySpawn(Class'FlipendoVaseBronzeShard');
    FancySpawn(Class'FlipendoVaseBronzeShard');
    FancySpawn(Class'FlipendoVaseBronzeShard');
    SetCollision(True,True,True);
    return True;
  }
  
}

defaultproperties
{
    ShardType=Class'FlipendoVaseBronzeShard'

    brokentypeMesh=SkeletalMesh'HProps.skFlipendoVaseBronzeBrokenMesh'

    // eVulnerableToSpell=13
	eVulnerableToSpell=SPELL_Flipendo

    Mesh=SkeletalMesh'HProps.skFlipendoVaseBronzeMesh'

    CollisionRadius=15.00

    CollisionHeight=19.00
}
