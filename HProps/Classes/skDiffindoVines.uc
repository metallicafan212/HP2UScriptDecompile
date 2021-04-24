//================================================================================
// skDiffindoVines.
//================================================================================

class skDiffindoVines extends HPMeshActor;

//model import (skDiffindoVinesMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skDiffindoVinesMesh ModelFile=Models\skDiffindoVinesMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skDiffindoVinesMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skDiffindoVinesAnims) -AdamJD 
#exec Anim Import Anim=skDiffindoVinesAnims AnimFile=Models\skDiffindoVinesAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skDiffindoVinesMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skDiffindoVinesMesh Anim=skDiffindoVinesAnims
#exec Anim Digest Anim=skDiffindoVinesAnims VERBOSE 

//texture import (skDiffindoVinesTex0) -AdamJD 
#exec Texture Import File=Textures\skDiffindoVinesTex0.png Name=skDiffindoVinesTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoVinesMesh Num=0 Texture=skDiffindoVinesTex0

//texture import (skDiffindoVinesTex1) -AdamJD 
#exec Texture Import File=Textures\skDiffindoVinesTex1.png Name=skDiffindoVinesTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skDiffindoVinesMesh Num=1 Texture=skDiffindoVinesTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skDiffindoVinesMesh
}
