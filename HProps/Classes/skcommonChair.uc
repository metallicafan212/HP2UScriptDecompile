//================================================================================
// skcommonChair.
//================================================================================

class skcommonChair extends HPMeshActor;

//model import (skcommonChairMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skcommonChairMesh ModelFile=Models\skcommonChairMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skcommonChairMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skcommonChairAnims) -AdamJD 
#exec Anim Import Anim=skcommonChairAnims AnimFile=Models\skcommonChairAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skcommonChairMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skcommonChairMesh Anim=skcommonChairAnims
#exec Anim Digest Anim=skcommonChairAnims VERBOSE 

//texture import (skcommonChairTex0) -AdamJD 
#exec Texture Import File=Textures\skcommonChairTex0.png Name=skcommonChairTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skcommonChairMesh Num=0 Texture=skcommonChairTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skcommonChairMesh
}
