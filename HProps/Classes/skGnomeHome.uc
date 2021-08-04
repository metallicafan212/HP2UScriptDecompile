//================================================================================
// skGnomeHome.
//================================================================================

class skGnomeHome extends HPMeshActor;

//model import (skGnomeHomeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGnomeHomeMesh ModelFile=Models\skGnomeHomeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGnomeHomeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skGnomeHomeAnims) -AdamJD 
#exec Anim Import Anim=skGnomeHomeAnims AnimFile=Models\skGnomeHomeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skGnomeHomeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGnomeHomeMesh Anim=skGnomeHomeAnims
#exec Anim Digest Anim=skGnomeHomeAnims VERBOSE 

//texture import (skGnomeHomeTex0) -AdamJD 
#exec Texture Import File=Textures\skGnomeHomeTex0.png Name=skGnomeHomeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGnomeHomeMesh Num=0 Texture=skGnomeHomeTex0

//texture import (skGnomeHomeTex1) -AdamJD 
#exec Texture Import File=Textures\skGnomeHomeTex1.png Name=skGnomeHomeTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGnomeHomeMesh Num=1 Texture=skGnomeHomeTex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skGnomeHomeMesh
}
