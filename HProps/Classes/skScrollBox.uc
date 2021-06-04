//================================================================================
// skScrollBox.
//================================================================================

class skScrollBox extends HPMeshActor;

//model import (skScrollBoxMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skScrollBoxMesh ModelFile=Models\skScrollBoxMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skScrollBoxMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skScrollBoxAnims) -AdamJD 
#exec Anim Import Anim=skScrollBoxAnims AnimFile=Models\skScrollBoxAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skScrollBoxMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skScrollBoxMesh Anim=skScrollBoxAnims
#exec Anim Digest Anim=skScrollBoxAnims VERBOSE 

//texture import (skScrollBoxTex0) -AdamJD 
#exec Texture Import File=Textures\skScrollBoxTex0.png Name=skScrollBoxTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skScrollBoxMesh Num=0 Texture=skScrollBoxTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skScrollBoxMesh
}
