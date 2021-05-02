//================================================================================
// skFirTreeThin.
//================================================================================

class skFirTreeThin extends HPMeshActor;

//model import (skFirTreeThinMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skFirTreeThinMesh ModelFile=Models\skFirTreeThinMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skFirTreeThinMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skFirTreeThinAnims) -AdamJD 
#exec Anim Import Anim=skFirTreeThinAnims AnimFile=Models\skFirTreeThinAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skFirTreeThinMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skFirTreeThinMesh Anim=skFirTreeThinAnims
#exec Anim Digest Anim=skFirTreeThinAnims VERBOSE

//texture import (skFirTreeThinTex0) -AdamJD 
#exec Texture Import File=Textures\skFirTreeThinTex0.png Name=skFirTreeThinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeThinMesh Num=0 Texture=skFirTreeThinTex0

//texture import (skFirTreeThinTex1) -AdamJD 
#exec Texture Import File=Textures\skFirTreeThinTex1.png Name=skFirTreeThinTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skFirTreeThinMesh Num=1 Texture=skFirTreeThinTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skFirTreeThinMesh
}
