//================================================================================
// skFordAngliaDamaged.
//================================================================================

class skFordAngliaDamaged extends HPMeshActor;

//model import (skFordAngliaDamagedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFordAngliaDamagedMesh ModelFile=Models\skFordAngliaDamagedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFordAngliaDamagedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFordAngliaDamagedAnims) -AdamJD 
#exec Anim Import Anim=skFordAngliaDamagedAnims AnimFile=Models\skFordAngliaDamagedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFordAngliaDamagedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFordAngliaDamagedMesh Anim=skFordAngliaDamagedAnims
#exec Anim Digest Anim=skFordAngliaDamagedAnims VERBOSE 

//texture import (skFordAngliaDamagedTex0) -AdamJD 
#exec Texture Import File=Textures\skFordAngliaDamagedTex0.png Name=skFordAngliaDamagedTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordAngliaDamagedMesh Num=0 Texture=skFordAngliaDamagedTex0

//texture import (skFordAngliaDamagedTex1) -AdamJD 
#exec Texture Import File=Textures\skFordAngliaDamagedTex1.png Name=skFordAngliaDamagedTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordAngliaDamagedMesh Num=1 Texture=skFordAngliaDamagedTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFordAngliaDamagedMesh
}
