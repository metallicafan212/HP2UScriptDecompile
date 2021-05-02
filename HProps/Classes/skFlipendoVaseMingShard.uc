//================================================================================
// skFlipendoVaseMingShard.
//================================================================================

class skFlipendoVaseMingShard extends HPMeshActor;

//model import (skFlipendoVaseMingShardMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseMingShardMesh ModelFile=Models\skFlipendoVaseMingShardMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseMingShardMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseMingShardAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseMingShardAnims AnimFile=Models\skFlipendoVaseMingShardAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseMingShardMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseMingShardMesh Anim=skFlipendoVaseMingShardAnims
#exec Anim Digest Anim=skFlipendoVaseMingShardAnims VERBOSE

//texture import (skFlipendoVaseMingShardTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseMingShardTex0.png Name=skFlipendoVaseMingShardTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseMingShardMesh Num=0 Texture=skFlipendoVaseMingShardTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseMingShardMesh
}
