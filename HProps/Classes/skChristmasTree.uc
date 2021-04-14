//================================================================================
// skChristmasTree.
//================================================================================

class skChristmasTree extends HPMeshActor;

//model import (skChristmasTreeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skChristmasTreeMesh ModelFile=Models\skChristmasTreeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skChristmasTreeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skChristmasTreeAnims) -AdamJD 
#exec Anim Import Anim=skChristmasTreeAnims AnimFile=Models\skChristmasTreeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skChristmasTreeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skChristmasTreeMesh Anim=skChristmasTreeAnims
#exec Anim Digest Anim=skChristmasTreeAnims VERBOSE 

//texture import (skChristmasTreeTex0) -AdamJD 
#exec Texture Import File=Textures\skChristmasTreeTex0.png Name=skChristmasTreeTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skChristmasTreeMesh Num=0 Texture=skChristmasTreeTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skChristmasTreeMesh
}
