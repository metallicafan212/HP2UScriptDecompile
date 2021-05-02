//================================================================================
// skFlipendoVaseBronzeShard.
//================================================================================

class skFlipendoVaseBronzeShard extends HPMeshActor;

//model import (skFlipendoVaseBronzeShardMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseBronzeShardMesh ModelFile=Models\skFlipendoVaseBronzeShardMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseBronzeShardMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseBronzeShardAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseBronzeShardAnims AnimFile=Models\skFlipendoVaseBronzeShardAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseBronzeShardMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseBronzeShardMesh Anim=skFlipendoVaseBronzeShardAnims
#exec Anim Digest Anim=skFlipendoVaseBronzeShardAnims VERBOSE 

//texture import (skFlipendoVaseBronzeShardTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseBronzeShardTex0.png Name=skFlipendoVaseBronzeShardTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseBronzeShardMesh Num=0 Texture=skFlipendoVaseBronzeShardTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseBronzeShardMesh
}
