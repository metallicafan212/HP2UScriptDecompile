//================================================================================
// skDishesGoblet.
//================================================================================

class skDishesGoblet extends HPMeshActor;

//model import (skDishesGobletMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDishesGobletMesh ModelFile=Models\skDishesGobletMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDishesGobletMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDishesGobletAnims) -AdamJD 
#exec Anim Import Anim=skDishesGobletAnims AnimFile=Models\skDishesGobletAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDishesGobletMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDishesGobletMesh Anim=skDishesGobletAnims
#exec Anim Digest Anim=skDishesGobletAnims VERBOSE 

//texture import (skDishesGobletTex0) -AdamJD 
#exec Texture Import File=Textures\skDishesGobletTex0.png Name=skDishesGobletTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDishesGobletMesh Num=0 Texture=skDishesGobletTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDishesGobletMesh
}
