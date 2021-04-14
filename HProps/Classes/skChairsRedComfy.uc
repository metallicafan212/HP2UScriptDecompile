//================================================================================
// skChairsRedComfy.
//================================================================================

class skChairsRedComfy extends HPMeshActor;

//model import (skChairsRedComfyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChairsRedComfyMesh ModelFile=Models\skChairsRedComfyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChairsRedComfyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChairsRedComfyAnims) -AdamJD 
#exec Anim Import Anim=skChairsRedComfyAnims AnimFile=Models\skChairsRedComfyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChairsRedComfyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChairsRedComfyMesh Anim=skChairsRedComfyAnims
#exec Anim Digest Anim=skChairsRedComfyAnims VERBOSE 

//texture import (skChairsRedComfyTex0) -AdamJD 
#exec Texture Import File=Textures\skChairsRedComfyTex0.png Name=skChairsRedComfyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChairsRedComfyMesh Num=0 Texture=skChairsRedComfyTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChairsRedComfyMesh
}
