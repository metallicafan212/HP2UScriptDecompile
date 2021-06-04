//================================================================================
// skSignsArrowFlipendo.
//================================================================================

class skSignsArrowFlipendo extends HPMeshActor;

//model import (skSignsArrowFlipendoMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSignsArrowFlipendoMesh ModelFile=Models\skSignsArrowFlipendoMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSignsArrowFlipendoMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skSignsArrowFlipendoAnims) -AdamJD 
#exec Anim Import Anim=skSignsArrowFlipendoAnims AnimFile=Models\skSignsArrowFlipendoAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSignsArrowFlipendoMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSignsArrowFlipendoMesh Anim=skSignsArrowFlipendoAnims
#exec Anim Digest Anim=skSignsArrowFlipendoAnims VERBOSE 

//texture import (skSignsArrowFlipendoTex0) -AdamJD 
#exec Texture Import File=Textures\skSignsArrowFlipendoTex0.png Name=skSignsArrowFlipendoTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSignsArrowFlipendoMesh Num=0 Texture=skSignsArrowFlipendoTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSignsArrowFlipendoMesh
}
