//================================================================================
// Halo.
//================================================================================

class Halo extends Sprite;

function PostBeginPlay()
{
  if ( Owner != None )
  {
    DrawScale *= Owner.DrawScale;
    SetPhysics(PHYS_Trailer);
    bTrailerPrePivot = False;
  }
}

function TakeDamage (int Damage, Pawn InstigatedBy, Vector HitLocation, Vector Momentum, name DamageType)
{
}

