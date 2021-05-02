//================================================================================
// skFlipendoVaseBronzeBroken.
//================================================================================

class skFlipendoVaseBronzeBroken extends HPMeshActor;

//model import (skFlipendoVaseBronzeBrokenMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFlipendoVaseBronzeBrokenMesh ModelFile=Models\skFlipendoVaseBronzeBrokenMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFlipendoVaseBronzeBrokenMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFlipendoVaseBronzeBrokenAnims) -AdamJD 
#exec Anim Import Anim=skFlipendoVaseBronzeBrokenAnims AnimFile=Models\skFlipendoVaseBronzeBrokenAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFlipendoVaseBronzeBrokenMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFlipendoVaseBronzeBrokenMesh Anim=skFlipendoVaseBronzeBrokenAnims
#exec Anim Digest Anim=skFlipendoVaseBronzeBrokenAnims VERBOSE 

//texture import (skFlipendoVaseBronzeBrokenTex0) -AdamJD 
#exec Texture Import File=Textures\skFlipendoVaseBronzeBrokenTex0.png Name=skFlipendoVaseBronzeBrokenTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFlipendoVaseBronzeBrokenMesh Num=0 Texture=skFlipendoVaseBronzeBrokenTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFlipendoVaseBronzeBrokenMesh
}
