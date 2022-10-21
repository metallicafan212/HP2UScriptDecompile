//================================================================================
// skFirTreeThick.
//================================================================================

class skFirTreeThick extends HPMeshActor;

//model import (skFirTreeThickMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFirTreeThickMesh ModelFile=Models\skFirTreeThickMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFirTreeThickMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFirTreeThickAnims) -AdamJD 
#exec Anim Import Anim=skFirTreeThickAnims AnimFile=Models\skFirTreeThickAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFirTreeThickMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFirTreeThickMesh Anim=skFirTreeThickAnims
#exec Anim Digest Anim=skFirTreeThickAnims VERBOSE

//texture import (skFirTreeThickTex0) -AdamJD 
#exec Texture Import File=Textures\skFirTreeThickTex0.png Name=skFirTreeThickTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeThickMesh Num=0 Texture=skFirTreeThickTex0

//texture import (skFirTreeThickTex1) -AdamJD 
#exec Texture Import File=Textures\skFirTreeThickTex1.png Name=skFirTreeThickTex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeThickMesh Num=1 Texture=skFirTreeThickTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFirTreeThickMesh
}
