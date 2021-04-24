//================================================================================
// skDragonSkull.
//================================================================================

class skDragonSkull extends HPMeshActor;

//model import (skDragonSkullMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDragonSkullMesh ModelFile=Models\skDragonSkullMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDragonSkullMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDragonSkullAnims) -AdamJD 
#exec Anim Import Anim=skDragonSkullAnims AnimFile=Models\skDragonSkullAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDragonSkullMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDragonSkullMesh Anim=skDragonSkullAnims
#exec Anim Digest Anim=skDragonSkullAnims VERBOSE 

//texture import (skDragonSkullTex0) -AdamJD 
#exec Texture Import File=Textures\skDragonSkullTex0.png Name=skDragonSkullTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDragonSkullMesh Num=0 Texture=skDragonSkullTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDragonSkullMesh
}
