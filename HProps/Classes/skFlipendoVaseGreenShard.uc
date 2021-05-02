//================================================================================
// skFlipendoVaseGreenShard.
//================================================================================

class skFlipendoVaseGreenShard extends HPMeshActor;

//model import (skFlipendoVaseGreenShardMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseGreenShardMesh ModelFile=Models\skFlipendoVaseGreenShardMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseGreenShardMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseGreenShardAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseGreenShardAnims AnimFile=Models\skFlipendoVaseGreenShardAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseGreenShardMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseGreenShardMesh Anim=skFlipendoVaseGreenShardAnims
#exec Anim Digest Anim=skFlipendoVaseGreenShardAnims VERBOSE 

//texture import (skFlipendoVaseGreenShardTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseGreenShardTex0.png Name=skFlipendoVaseGreenShardTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseGreenShardMesh Num=0 Texture=skFlipendoVaseGreenShardTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseGreenShardMesh
}
