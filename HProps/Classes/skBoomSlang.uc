//================================================================================
// skBoomSlang.
//================================================================================

class skBoomSlang extends HPMeshActor;

//model import (skBoomSlangMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBoomSlangMesh ModelFile=Models\skBoomSlangMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBoomSlangMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBoomSlangAnims) -AdamJD 
#exec Anim Import Anim=skBoomSlangAnims AnimFile=Models\skBoomSlangAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBoomSlangMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBoomSlangMesh Anim=skBoomSlangAnims
#exec Anim Digest Anim=skBoomSlangAnims VERBOSE 

//texture import (skBoomSlangTex0) -AdamJD 
#exec Texture Import File=Textures\skBoomSlangTex0.png Name=skBoomSlangTex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skBoomSlangMesh Num=0 Texture=skBoomSlangTex0

//texture import (skBoomSlangTex1) -AdamJD 
#exec Texture Import File=Textures\skBoomSlangTex1.png Name=skBoomSlangTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 MaskedOverride=(R=0,G=0,B=0,A=255) Group=Skins 
#exec MeshMap SetTexture MeshMap=skBoomSlangMesh Num=1 Texture=skBoomSlangTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBoomSlangMesh
}
