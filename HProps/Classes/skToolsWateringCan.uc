//================================================================================
// skToolsWateringCan.
//================================================================================

class skToolsWateringCan extends HPMeshActor;

//model import (skToolsWateringCanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skToolsWateringCanMesh ModelFile=Models\skToolsWateringCanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skToolsWateringCanMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skToolsWateringCanAnims) -AdamJD 
#exec Anim Import Anim=skToolsWateringCanAnims AnimFile=Models\skToolsWateringCanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skToolsWateringCanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skToolsWateringCanMesh Anim=skToolsWateringCanAnims
#exec Anim Digest Anim=skToolsWateringCanAnims VERBOSE 

//texture import (skToolsWateringCanTex0) -AdamJD 
#exec Texture Import File=Textures\skToolsWateringCanTex0.png Name=skToolsWateringCanTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skToolsWateringCanMesh Num=0 Texture=skToolsWateringCanTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skToolsWateringCanMesh
}
