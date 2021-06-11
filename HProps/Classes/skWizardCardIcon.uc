//================================================================================
// skWizardCardIcon.
//================================================================================

class skWizardCardIcon extends HPMeshActor;

//model import (skWizardCardIconMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWizardCardIconMesh ModelFile=Models\skWizardCardIconMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWizardCardIconMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWizardCardIconAnims) -AdamJD 
#exec Anim Import Anim=skWizardCardIconAnims AnimFile=Models\skWizardCardIconAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWizardCardIconMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWizardCardIconMesh Anim=skWizardCardIconAnims
#exec Anim Digest Anim=skWizardCardIconAnims VERBOSE 

//texture import (WizardCardIconTex0) -AdamJD 
#exec Texture Import File=Textures\WizardCardIconTex0.png Name=WizardCardIconTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWizardCardIconMesh Num=0 Texture=WizardCardIconTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skWizardCardIconMesh
}
