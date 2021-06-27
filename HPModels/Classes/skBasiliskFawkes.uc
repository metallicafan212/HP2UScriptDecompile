//================================================================================
// skBasiliskFawkes.
//================================================================================

class skBasiliskFawkes extends HPMeshActor;

//model import (skBasiliskFawkesMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBasiliskFawkesMesh ModelFile=Models\skBasiliskFawkesMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBasiliskFawkesMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBasiliskFawkesAnims) -AdamJD 
#exec Anim Import Anim=skBasiliskFawkesAnims AnimFile=Models\skBasiliskFawkesAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBasiliskFawkesMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBasiliskFawkesMesh Anim=skBasiliskFawkesAnims
#exec Anim Digest Anim=skBasiliskFawkesAnims VERBOSE 

//texture import (skBasiliskFawkesTex0) -AdamJD 
#exec Texture Import File=Textures\skBasiliskFawkesTex0.png Name=skBasiliskFawkesTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBasiliskFawkesMesh Num=0 Texture=skBasiliskFawkesTex0

//texture import (skBasiliskFawkesTex1) -AdamJD 
#exec Texture Import File=Textures\skBasiliskFawkesTex1.png Name=skBasiliskFawkesTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBasiliskFawkesMesh Num=1 Texture=skBasiliskFawkesTex1

//texture import (skBasiliskFawkesTex2) -AdamJD 
#exec Texture Import File=Textures\skBasiliskFawkesTex2.png Name=skBasiliskFawkesTex2 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBasiliskFawkesMesh Num=2 Texture=skBasiliskFawkesTex2

//texture import (skBasiliskFawkesTex3) -AdamJD 
#exec Texture Import File=Textures\skBasiliskFawkesTex3.png Name=skBasiliskFawkesTex3 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBasiliskFawkesMesh Num=3 Texture=skBasiliskFawkesTex3

//texture import (skBasiliskFawkesTex4) -AdamJD 
#exec Texture Import File=Textures\skBasiliskFawkesTex4.png Name=skBasiliskFawkesTex4 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBasiliskFawkesMesh Num=4 Texture=skBasiliskFawkesTex4

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBasiliskFawkesMesh
}
