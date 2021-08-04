//================================================================================
// skBedGryffindor.
//================================================================================

class skBedGryffindor extends HPMeshActor;

//model import (skBedGryffindorMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBedGryffindorMesh ModelFile=Models\skBedGryffindorMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBedGryffindorMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBedGryffindorAnims) -AdamJD 
#exec Anim Import Anim=skBedGryffindorAnims AnimFile=Models\skBedGryffindorAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBedGryffindorMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBedGryffindorMesh Anim=skBedGryffindorAnims
#exec Anim Digest Anim=skBedGryffindorAnims VERBOSE 

//texture import (skBedGryffindorTex0) -AdamJD 
#exec Texture Import File=Textures\skBedGryffindorTex0.png Name=skBedGryffindorTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBedGryffindorMesh Num=0 Texture=skBedGryffindorTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBedGryffindorMesh
}
