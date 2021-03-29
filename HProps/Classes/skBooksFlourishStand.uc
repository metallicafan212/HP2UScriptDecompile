//================================================================================
// skBooksFlourishStand.
//================================================================================

class skBooksFlourishStand extends HPMeshActor;

//model import (skBooksFlourishStandMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBooksFlourishStandMesh ModelFile=Models\skBooksFlourishStandMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBooksFlourishStandMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBooksFlourishStandAnims) -AdamJD 
#exec Anim Import Anim=skBooksFlourishStandAnims AnimFile=Models\skBooksFlourishStandAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBooksFlourishStandMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBooksFlourishStandMesh Anim=skBooksFlourishStandAnims
#exec Anim Digest Anim=skBooksFlourishStandAnims VERBOSE 

//texture import (skBooksFlourishStandTex0) -AdamJD 
#exec Texture Import File=Textures\skBooksFlourishStandTex0.png Name=skBooksFlourishStandTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBooksFlourishStandMesh Num=0 Texture=skBooksFlourishStandTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBooksFlourishStandMesh
}
