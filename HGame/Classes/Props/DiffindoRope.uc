//================================================================================
// DiffindoRope.
//================================================================================

class DiffindoRope extends HDiffindo;

var ParticleFX fxShimmer;
var Class<ParticleFX> fxShimmerClass;

function PreBeginPlay ()
{
  Super.PreBeginPlay();
  SetCollision(True,True,True);
  if ( fxShimmer == None )
  {
    fxShimmer = Spawn(fxShimmerClass);
    fxShimmer.SetLocation(Location);
    fxShimmer.SetOwner(self);
    fxShimmer.SourceHeight.Base = CollisionHeight * 1.39999998;
    fxShimmer.SourceWidth.Base = CollisionWidth * 1.39999998;
    fxShimmer.SourceDepth.Base = CollisionRadius * 1.39999998;
  }
}

event Destroyed ()
{
  if ( fxShimmer != None )
  {
    fxShimmer.Shutdown();
  }
  Super.Destroyed();
}

defaultproperties
{
    fxShimmerClass=Class'HPParticle.Diffindo_ropeFx'

    fSingleCutTimer=0.20

    fDiffindoTimer=2.00

    DiffindoImpactSound=Sound'HPSounds.Magic_sfx.DFO_hit_rope'

    DiffindoCutSound=None

    Mesh=SkeletalMesh'HProps.skDiffindoRope64Mesh'

    // CollideType=2
	CollideType=CT_Box
}
