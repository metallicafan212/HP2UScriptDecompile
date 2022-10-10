//================================================================================
// ArmTorch_Sepia.
//================================================================================

class ArmTorch_Sepia extends ArmTorch;

defaultproperties
{
    attachedParticleClass(0)=Class'HPParticle.FireHP2Sepia'

    attachedParticleOffset(0)=(X=-18.00,Y=-4.00,Z=14.00)

    Mesh=SkeletalMesh'HProps.skArmTorchSepiaMesh'
	
	//fix the torch and fire draw order issue (to be compatible with the new engine) -AdamJD  
	bDrawChildrenFirst=True
}
