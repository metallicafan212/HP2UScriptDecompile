//================================================================================
// skDiffindoWeb2.
//================================================================================

class skDiffindoWeb2 extends HPMeshActor;

//model import (skDiffindoWeb2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDiffindoWeb2Mesh ModelFile=Models\skDiffindoWeb2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDiffindoWeb2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDiffindoWeb2Anims) -AdamJD 
#exec Anim Import Anim=skDiffindoWeb2Anims AnimFile=Models\skDiffindoWeb2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDiffindoWeb2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDiffindoWeb2Mesh Anim=skDiffindoWeb2Anims
#exec Anim Digest Anim=skDiffindoWeb2Anims VERBOSE 

//texture import (skDiffindoWeb2Tex0) -AdamJD 
#exec Texture Import File=Textures\skDiffindoWeb2Tex0.png Name=skDiffindoWeb2Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoWeb2Mesh Num=0 Texture=skDiffindoWeb2Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDiffindoWeb2Mesh
}
