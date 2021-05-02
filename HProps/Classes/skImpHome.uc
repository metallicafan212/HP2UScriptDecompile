//================================================================================
// skImpHome.
//================================================================================

class skImpHome extends HPMeshActor;

//model import (skImpHomeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skImpHomeMesh ModelFile=Models\skImpHomeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skImpHomeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skImpHomeAnims) -AdamJD 
#exec Anim Import Anim=skImpHomeAnims AnimFile=Models\skImpHomeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skImpHomeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skImpHomeMesh Anim=skImpHomeAnims
#exec Anim Digest Anim=skImpHomeAnims VERBOSE 

//texture import (skImpHomeTex0) -AdamJD 
#exec Texture Import File=Textures\skImpHomeTex0.png Name=skImpHomeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skImpHomeMesh Num=0 Texture=skImpHomeTex0

//texture import (skImpHomeTex1) -AdamJD 
#exec Texture Import File=Textures\skImpHomeTex1.png Name=skImpHomeTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=536870914 Group=Skins 
#exec MeshMap SetTexture MeshMap=skImpHomeMesh Num=1 Texture=skImpHomeTex1

//texture import (skImpHomeTex2) -AdamJD 
#exec Texture Import File=Textures\skImpHomeTex2.png Name=skImpHomeTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skImpHomeMesh Num=2 Texture=skImpHomeTex2

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skImpHomeMesh
}
