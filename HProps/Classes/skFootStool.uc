//================================================================================
// skFootStool.
//================================================================================

class skFootStool extends HPMeshActor;

//model import (skFootStoolMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFootStoolMesh ModelFile=Models\skFootStoolMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFootStoolMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFootStoolAnims) -AdamJD 
#exec Anim Import Anim=skFootStoolAnims AnimFile=Models\skFootStoolAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFootStoolMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFootStoolMesh Anim=skFootStoolAnims
#exec Anim Digest Anim=skFootStoolAnims VERBOSE 

//texture import (skFootStoolTex0) -AdamJD 
#exec Texture Import File=Textures\skFootStoolTex0.png Name=skFootStoolTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFootStoolMesh Num=0 Texture=skFootStoolTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFootStoolMesh
}
