//================================================================================
// skDiffindoWeb1.
//================================================================================

class skDiffindoWeb1 extends HPMeshActor;

//model import (skDiffindoWeb1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDiffindoWeb1Mesh ModelFile=Models\skDiffindoWeb1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDiffindoWeb1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDiffindoWeb1Anims) -AdamJD 
#exec Anim Import Anim=skDiffindoWeb1Anims AnimFile=Models\skDiffindoWeb1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDiffindoWeb1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDiffindoWeb1Mesh Anim=skDiffindoWeb1Anims
#exec Anim Digest Anim=skDiffindoWeb1Anims VERBOSE 

//texture import (skDiffindoWeb1Tex0) -AdamJD 
#exec Texture Import File=Textures\skDiffindoWeb1Tex0.png Name=skDiffindoWeb1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoWeb1Mesh Num=0 Texture=skDiffindoWeb1Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDiffindoWeb1Mesh
}
