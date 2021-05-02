//================================================================================
// skFordAngliaDamagedLow.
//================================================================================

class skFordAngliaDamagedLow extends HPMeshActor;

//model import (skFordAngliaDamagedLowMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFordAngliaDamagedLowMesh ModelFile=Models\skFordAngliaDamagedLowMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFordAngliaDamagedLowMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFordAngliaDamagedLowAnims) -AdamJD 
#exec Anim Import Anim=skFordAngliaDamagedLowAnims AnimFile=Models\skFordAngliaDamagedLowAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFordAngliaDamagedLowMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFordAngliaDamagedLowMesh Anim=skFordAngliaDamagedLowAnims
#exec Anim Digest Anim=skFordAngliaDamagedLowAnims VERBOSE 

//texture import (skFordAngliaDamagedLowTex0) -AdamJD 
#exec Texture Import File=Textures\skFordAngliaDamagedLowTex0.png Name=skFordAngliaDamagedLowTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordAngliaDamagedLowMesh Num=0 Texture=skFordAngliaDamagedLowTex0

//texture import (skFordAngliaDamagedLowTex1) -AdamJD 
#exec Texture Import File=Textures\skFordAngliaDamagedLowTex1.png Name=skFordAngliaDamagedLowTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFordAngliaDamagedLowMesh Num=1 Texture=skFordAngliaDamagedLowTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFordAngliaDamagedLowMesh
}
