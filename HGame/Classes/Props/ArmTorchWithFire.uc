//================================================================================
// ArmTorchWithFire.
//================================================================================

class ArmTorchWithFire extends ArmTorch;

defaultproperties
{
    attachedParticleClass(0)=Class'HPParticle.FireHP2'

    attachedParticleOffset(0)=(X=-18.00,Y=-4.00,Z=14.00)

    AmbientSound=Sound'HPSounds.General.torch01'

    SoundRadius=16

    SoundVolume=96

	//fix the torch and fire draw order issue (to be compatible with the new engine) -AdamJD  
	bDrawChildrenFirst=True
}
