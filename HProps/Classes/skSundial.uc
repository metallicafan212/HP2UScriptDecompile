//================================================================================
// skSundial.
//================================================================================

class skSundial extends HPMeshActor;

//model import (skSundialMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSundialMesh ModelFile=Models\skSundialMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSundialMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSundialAnims) -AdamJD 
#exec Anim Import Anim=skSundialAnims AnimFile=Models\skSundialAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSundialMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSundialMesh Anim=skSundialAnims
#exec Anim Digest Anim=skSundialAnims VERBOSE 

//texture import (skSundialTex0) -AdamJD 
#exec Texture Import File=Textures\skSundialTex0.png Name=skSundialTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSundialMesh Num=0 Texture=skSundialTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSundialMesh
}
