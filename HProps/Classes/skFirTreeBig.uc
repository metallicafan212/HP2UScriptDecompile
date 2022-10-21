//================================================================================
// skFirTreeBig.
//================================================================================

class skFirTreeBig extends HPMeshActor;

//model import (skFirTreeBigMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFirTreeBigMesh ModelFile=Models\skFirTreeBigMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFirTreeBigMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFirTreeBigAnims) -AdamJD 
#exec Anim Import Anim=skFirTreeBigAnims AnimFile=Models\skFirTreeBigAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFirTreeBigMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFirTreeBigMesh Anim=skFirTreeBigAnims
#exec Anim Digest Anim=skFirTreeBigAnims VERBOSE 

//texture import (skFirTreeBigTex0) -AdamJD 
#exec Texture Import File=Textures\skFirTreeBigTex0.png Name=skFirTreeBigTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeBigMesh Num=0 Texture=skFirTreeBigTex0

//texture import (skFirTreeBigTex1) -AdamJD 
#exec Texture Import File=Textures\skFirTreeBigTex1.png Name=skFirTreeBigTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeBigMesh Num=1 Texture=skFirTreeBigTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFirTreeBigMesh
}
