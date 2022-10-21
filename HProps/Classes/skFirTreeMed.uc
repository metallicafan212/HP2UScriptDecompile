//================================================================================
// skFirTreeMed.
//================================================================================

class skFirTreeMed extends HPMeshActor;

//model import (skFirTreeMedMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFirTreeMedMesh ModelFile=Models\skFirTreeMedMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFirTreeMedMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skFirTreeMedAnims) -AdamJD 
#exec Anim Import Anim=skFirTreeMedAnims AnimFile=Models\skFirTreeMedAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFirTreeMedMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFirTreeMedMesh Anim=skFirTreeMedAnims
#exec Anim Digest Anim=skFirTreeMedAnims VERBOSE

//texture import (skFirTreeMedTex0) -AdamJD 
#exec Texture Import File=Textures\skFirTreeMedTex0.png Name=skFirTreeMedTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeMedMesh Num=0 Texture=skFirTreeMedTex0

//texture import (skFirTreeMedTex1) -AdamJD 
#exec Texture Import File=Textures\skFirTreeMedTex1.png Name=skFirTreeMedTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeMedMesh Num=1 Texture=skFirTreeMedTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFirTreeMedMesh
}
