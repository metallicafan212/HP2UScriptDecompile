//================================================================================
// skSnakeRay.
//================================================================================

class skSnakeRay extends HPMeshActor;

//model import (skSnakeRayMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSnakeRayMesh ModelFile=Models\skSnakeRayMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSnakeRayMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSnakeRayAnims) -AdamJD 
#exec Anim Import Anim=skSnakeRayAnims AnimFile=Models\skSnakeRayAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSnakeRayMesh X=0.5 Y=0.5 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSnakeRayMesh Anim=skSnakeRayAnims
#exec Anim Digest Anim=skSnakeRayAnims VERBOSE 

//texture import (skSnakeRayTex0) -AdamJD 
#exec Texture Import File=Textures\skSnakeRayTex0.png Name=skSnakeRayTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSnakeRayMesh Num=0 Texture=skSnakeRayTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSnakeRayMesh
}
