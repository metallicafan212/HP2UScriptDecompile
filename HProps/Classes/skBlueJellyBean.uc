//================================================================================
// skBlueJellyBean.
//================================================================================

class skBlueJellyBean extends HPMeshActor;

//model import (skBlueJellyBeanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBlueJellyBeanMesh ModelFile=Models\skBlueJellyBeanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBlueJellyBeanMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skBlueJellyBeanAnims) -AdamJD 
#exec Anim Import Anim=skBlueJellyBeanAnims AnimFile=Models\skBlueJellyBeanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBlueJellyBeanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBlueJellyBeanMesh Anim=skBlueJellyBeanAnims
#exec Anim Digest Anim=skBlueJellyBeanAnims VERBOSE 

//texture import (skBlueJellyBeanTex0) -AdamJD 
#exec Texture Import File=Textures\skBlueJellyBeanTex0.png Name=skBlueJellyBeanTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBlueJellyBeanMesh Num=0 Texture=skBlueJellyBeanTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBlueJellyBeanMesh
}
