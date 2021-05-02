//================================================================================
// skFlipendoVaseGreenBroken.
//================================================================================

class skFlipendoVaseGreenBroken extends HPMeshActor;

//model import (skFlipendoVaseGreenBrokenMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseGreenBrokenMesh ModelFile=Models\skFlipendoVaseGreenBrokenMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseGreenBrokenMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skFlipendoVaseGreenBrokenAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseGreenBrokenAnims AnimFile=Models\skFlipendoVaseGreenBrokenAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseGreenBrokenMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseGreenBrokenMesh Anim=skFlipendoVaseGreenBrokenAnims
#exec Anim Digest Anim=skFlipendoVaseGreenBrokenAnims VERBOSE 

//texture import (skFlipendoVaseGreenBrokenTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseGreenBrokenTex0.png Name=skFlipendoVaseGreenBrokenTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseGreenBrokenMesh Num=0 Texture=skFlipendoVaseGreenBrokenTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseGreenBrokenMesh
}
