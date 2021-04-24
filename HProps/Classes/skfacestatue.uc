//================================================================================
// skfacestatue.
//================================================================================

class skfacestatue extends HPMeshActor;

//model import (skfacestatueMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skfacestatueMesh ModelFile=Models\skfacestatueMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skfacestatueMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skfacestatueAnims) -AdamJD 
#exec Anim Import Anim=skfacestatueAnims AnimFile=Models\skfacestatueAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skfacestatueMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skfacestatueMesh Anim=skfacestatueAnims
#exec Anim Digest Anim=skfacestatueAnims VERBOSE 

//texture import (skfacestatueTex0) -AdamJD 
#exec Texture Import File=Textures\skfacestatueTex0.png Name=skfacestatueTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skfacestatueMesh Num=0 Texture=skfacestatueTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skfacestatueMesh
}
