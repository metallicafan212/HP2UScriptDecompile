//================================================================================
// skWoodFireplaceLogs.
//================================================================================

class skWoodFireplaceLogs extends HPMeshActor;

//model import (skWoodFireplaceLogsMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWoodFireplaceLogsMesh ModelFile=Models\skWoodFireplaceLogsMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWoodFireplaceLogsMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWoodFireplaceLogsAnims) -AdamJD 
#exec Anim Import Anim=skWoodFireplaceLogsAnims AnimFile=Models\skWoodFireplaceLogsAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWoodFireplaceLogsMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWoodFireplaceLogsMesh Anim=skWoodFireplaceLogsAnims
#exec Anim Digest Anim=skWoodFireplaceLogsAnims VERBOSE 

//texture import (skWoodFireplaceLogsTex0) -AdamJD 
#exec Texture Import File=Textures\skWoodFireplaceLogsTex0.png Name=skWoodFireplaceLogsTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWoodFireplaceLogsMesh Num=0 Texture=skWoodFireplaceLogsTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skWoodFireplaceLogsMesh
}
