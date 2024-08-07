//================================================================================
// skGreenJellyBean.
//================================================================================

class skGreenJellyBean extends HPMeshActor;

//model import (skGreenJellyBeanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skGreenJellyBeanMesh ModelFile=Models\skGreenJellyBeanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skGreenJellyBeanMesh X=0 Y=0 Z=16 Yaw=0 Pitch=0 Roll=0 

//anim import (skGreenJellyBeanAnims) -AdamJD 
#exec Anim Import Anim=skGreenJellyBeanAnims AnimFile=Models\skGreenJellyBeanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skGreenJellyBeanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skGreenJellyBeanMesh Anim=skGreenJellyBeanAnims
#exec Anim Digest Anim=skGreenJellyBeanAnims VERBOSE 

//texture import (skGreenJellyBeanTex0) -AdamJD 
#exec Texture Import File=Textures\skGreenJellyBeanTex0.png Name=skGreenJellyBeanTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skGreenJellyBeanMesh Num=0 Texture=skGreenJellyBeanTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skGreenJellyBeanMesh
}
