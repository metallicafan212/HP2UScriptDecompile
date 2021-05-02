//================================================================================
// skFramesEmpty.
//================================================================================

class skFramesEmpty extends HPMeshActor;

//model import (skFramesEmptyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFramesEmptyMesh ModelFile=Models\skFramesEmptyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFramesEmptyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFramesEmptyAnims) -AdamJD 
#exec Anim Import Anim=skFramesEmptyAnims AnimFile=Models\skFramesEmptyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFramesEmptyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFramesEmptyMesh Anim=skFramesEmptyAnims
#exec Anim Digest Anim=skFramesEmptyAnims VERBOSE 

//texture import (skFramesEmptyTex0) -AdamJD 
#exec Texture Import File=Textures\skFramesEmptyTex0.png Name=skFramesEmptyTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFramesEmptyMesh Num=0 Texture=skFramesEmptyTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFramesEmptyMesh
}
