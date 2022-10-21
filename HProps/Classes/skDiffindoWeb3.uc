//================================================================================
// skDiffindoWeb3.
//================================================================================

class skDiffindoWeb3 extends HPMeshActor;

//model import (skDiffindoWeb3Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDiffindoWeb3Mesh ModelFile=Models\skDiffindoWeb3Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDiffindoWeb3Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDiffindoWeb3Anims) -AdamJD 
#exec Anim Import Anim=skDiffindoWeb3Anims AnimFile=Models\skDiffindoWeb3Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDiffindoWeb3Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDiffindoWeb3Mesh Anim=skDiffindoWeb3Anims
#exec Anim Digest Anim=skDiffindoWeb3Anims VERBOSE

//texture import (skDiffindoWeb3Tex0) -AdamJD 
#exec Texture Import File=Textures\skDiffindoWeb3Tex0.png Name=skDiffindoWeb3Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=4 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoWeb3Mesh Num=0 Texture=skDiffindoWeb3Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDiffindoWeb3Mesh
}
