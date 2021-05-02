//================================================================================
// skFlipendoVaseGreen.
//================================================================================

class skFlipendoVaseGreen extends HPMeshActor;

//model import (skFlipendoVaseGreenMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseGreenMesh ModelFile=Models\skFlipendoVaseGreenMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseGreenMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseGreenAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseGreenAnims AnimFile=Models\skFlipendoVaseGreenAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseGreenMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseGreenMesh Anim=skFlipendoVaseGreenAnims
#exec Anim Digest Anim=skFlipendoVaseGreenAnims VERBOSE 

//texture import (skFlipendoVaseGreenTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseGreenTex0.png Name=skFlipendoVaseGreenTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseGreenMesh Num=0 Texture=skFlipendoVaseGreenTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseGreenMesh
}
