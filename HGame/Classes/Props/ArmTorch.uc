//================================================================================
// ArmTorch.
//================================================================================

class ArmTorch extends HCandlesLamps;

defaultproperties
{
    Mesh=SkeletalMesh'HProps.skArmTorchMesh'
	
	//fix the torch and particle draw order issue if no owner is set (to be compatible with the new engine) -AdamJD  
	bDrawColPFXFirst=True
}
