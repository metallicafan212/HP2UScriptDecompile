//================================================================================
// skFlipendoVaseBronze.
//================================================================================

class skFlipendoVaseBronze extends HPMeshActor;

//model import (skFlipendoVaseBronzeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseBronzeMesh ModelFile=Models\skFlipendoVaseBronzeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseBronzeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseBronzeAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseBronzeAnims AnimFile=Models\skFlipendoVaseBronzeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseBronzeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseBronzeMesh Anim=skFlipendoVaseBronzeAnims
#exec Anim Digest Anim=skFlipendoVaseBronzeAnims VERBOSE 

//texture import (skFlipendoVaseBronzeTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseBronzeTex0.png Name=skFlipendoVaseBronzeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseBronzeMesh Num=0 Texture=skFlipendoVaseBronzeTex0

defaultproperties
{
    Mesh=skFlipendoVaseBronzeMesh
}
