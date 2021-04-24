//================================================================================
// skDiffindoRope128.
//================================================================================

class skDiffindoRope128 extends HPMeshActor;

//model import (skDiffindoRope128Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDiffindoRope128Mesh ModelFile=Models\skDiffindoRope128Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDiffindoRope128Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDiffindoRope128Anims) -AdamJD 
#exec Anim Import Anim=skDiffindoRope128Anims AnimFile=Models\skDiffindoRope128Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDiffindoRope128Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDiffindoRope128Mesh Anim=skDiffindoRope128Anims
#exec Anim Digest Anim=skDiffindoRope128Anims VERBOSE 

//texture import (skDiffindoRope128Tex0) -AdamJD 
#exec Texture Import File=Textures\skDiffindoRope128Tex0.png Name=skDiffindoRope128Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoRope128Mesh Num=0 Texture=skDiffindoRope128Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDiffindoRope128Mesh
}
