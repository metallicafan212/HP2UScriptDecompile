//================================================================================
// skFlipendoVaseMing.
//================================================================================

class skFlipendoVaseMing extends HPMeshActor;

//model import (skFlipendoVaseMingMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseMingMesh ModelFile=Models\skFlipendoVaseMingMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseMingMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseMingAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseMingAnims AnimFile=Models\skFlipendoVaseMingAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseMingMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseMingMesh Anim=skFlipendoVaseMingAnims
#exec Anim Digest Anim=skFlipendoVaseMingAnims VERBOSE 

//texture import (skFlipendoVaseMingTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseMingTex0.png Name=skFlipendoVaseMingTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseMingMesh Num=0 Texture=skFlipendoVaseMingTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseMingMesh
}
