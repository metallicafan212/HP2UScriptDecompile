//================================================================================
// skcommonCouch.
//================================================================================

class skcommonCouch extends HPMeshActor;

//model import (skcommonCouchMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skcommonCouchMesh ModelFile=Models\skcommonCouchMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skcommonCouchMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skcommonCouchAnims) -AdamJD 
#exec Anim Import Anim=skcommonCouchAnims AnimFile=Models\skcommonCouchAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skcommonCouchMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skcommonCouchMesh Anim=skcommonCouchAnims
#exec Anim Digest Anim=skcommonCouchAnims VERBOSE 

//texture import (skcommonCouchTex0) -AdamJD 
#exec Texture Import File=Textures\skcommonCouchTex0.png Name=skcommonCouchTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skcommonCouchMesh Num=0 Texture=skcommonCouchTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skcommonCouchMesh
}
