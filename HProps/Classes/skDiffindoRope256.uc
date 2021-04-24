//================================================================================
// skDiffindoRope256.
//================================================================================

class skDiffindoRope256 extends HPMeshActor;

//model import (skDiffindoRope256Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDiffindoRope256Mesh ModelFile=Models\skDiffindoRope256Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDiffindoRope256Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDiffindoRope256Anims) -AdamJD 
#exec Anim Import Anim=skDiffindoRope256Anims AnimFile=Models\skDiffindoRope256Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDiffindoRope256Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDiffindoRope256Mesh Anim=skDiffindoRope256Anims
#exec Anim Digest Anim=skDiffindoRope256Anims VERBOSE 

//texture import (skDiffindoRope256Tex0) -AdamJD 
#exec Texture Import File=Textures\skDiffindoRope256Tex0.png Name=skDiffindoRope256Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoRope256Mesh Num=0 Texture=skDiffindoRope256Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDiffindoRope256Mesh
}
