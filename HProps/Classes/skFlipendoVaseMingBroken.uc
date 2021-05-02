//================================================================================
// skFlipendoVaseMingBroken.
//================================================================================

class skFlipendoVaseMingBroken extends HPMeshActor;

//model import (skFlipendoVaseMingBrokenMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseMingBrokenMesh ModelFile=Models\skFlipendoVaseMingBrokenMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseMingBrokenMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseMingBrokenAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseMingBrokenAnims AnimFile=Models\skFlipendoVaseMingBrokenAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseMingBrokenMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseMingBrokenMesh Anim=skFlipendoVaseMingBrokenAnims
#exec Anim Digest Anim=skFlipendoVaseMingBrokenAnims VERBOSE 

//texture import (skFlipendoVaseMingBrokenTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseMingBrokenTex0.png Name=skFlipendoVaseMingBrokenTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseMingBrokenMesh Num=0 Texture=skFlipendoVaseMingBrokenTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseMingBrokenMesh
}
