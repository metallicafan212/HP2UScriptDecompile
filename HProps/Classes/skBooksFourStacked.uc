//================================================================================
// skBooksFourStacked.
//================================================================================

class skBooksFourStacked extends HPMeshActor;

//model import (skBooksFourStackedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksFourStackedMesh ModelFile=Models\skBooksFourStackedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksFourStackedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksFourStackedAnims) -AdamJD 
#exec Anim Import Anim=skBooksFourStackedAnims AnimFile=Models\skBooksFourStackedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksFourStackedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksFourStackedMesh Anim=skBooksFourStackedAnims
#exec Anim Digest Anim=skBooksFourStackedAnims VERBOSE 

//texture import (skBooksFourStackedTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksFourStackedTex0.png Name=skBooksFourStackedTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksFourStackedMesh Num=0 Texture=skBooksFourStackedTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksFourStackedMesh
}
