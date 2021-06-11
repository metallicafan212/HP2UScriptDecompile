//================================================================================
// skvenom.
//================================================================================

class skvenom extends HPMeshActor;

//model import (skvenomMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skvenomMesh ModelFile=Models\skvenomMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skvenomMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skvenomAnims) -AdamJD 
#exec Anim Import Anim=skvenomAnims AnimFile=Models\skvenomAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skvenomMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skvenomMesh Anim=skvenomAnims
#exec Anim Digest Anim=skvenomAnims VERBOSE 

//texture import (skvenomTex0) -AdamJD 
#exec Texture Import File=Textures\skvenomTex0.png Name=skvenomTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skvenomMesh Num=0 Texture=skvenomTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skvenomMesh
}
