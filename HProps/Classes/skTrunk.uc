//================================================================================
// skTrunk.
//================================================================================

class skTrunk extends HPMeshActor;

//model import (skTrunkMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTrunkMesh ModelFile=Models\skTrunkMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTrunkMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTrunkAnims) -AdamJD 
#exec Anim Import Anim=skTrunkAnims AnimFile=Models\skTrunkAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTrunkMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTrunkMesh Anim=skTrunkAnims
#exec Anim Digest Anim=skTrunkAnims VERBOSE 

//texture import (skTrunkTex0) -AdamJD 
#exec Texture Import File=Textures\skTrunkTex0.png Name=skTrunkTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTrunkMesh Num=0 Texture=skTrunkTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTrunkMesh
}
