//================================================================================
// skCouchSlytherin.
//================================================================================

class skCouchSlytherin extends HPMeshActor;

//model import (skCouchSlytherinMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCouchSlytherinMesh ModelFile=Models\skCouchSlytherinMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCouchSlytherinMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCouchSlytherinAnims) -AdamJD 
#exec Anim Import Anim=skCouchSlytherinAnims AnimFile=Models\skCouchSlytherinAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCouchSlytherinMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCouchSlytherinMesh Anim=skCouchSlytherinAnims
#exec Anim Digest Anim=skCouchSlytherinAnims VERBOSE 

//texture import (skCouchSlytherinTex0) -AdamJD 
#exec Texture Import File=Textures\skCouchSlytherinTex0.png Name=skCouchSlytherinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCouchSlytherinMesh Num=0 Texture=skCouchSlytherinTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCouchSlytherinMesh
}
