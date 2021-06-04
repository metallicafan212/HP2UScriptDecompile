//================================================================================
// skSpottedJellyBean.
//================================================================================

class skSpottedJellyBean extends HPMeshActor;

//model import (skSpottedJellyBeanMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSpottedJellyBeanMesh ModelFile=Models\skSpottedJellyBeanMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSpottedJellyBeanMesh X=0 Y=0 Z=16 Yaw=0 Pitch=0 Roll=0 

//anim import (skSpottedJellyBeanAnims) -AdamJD 
#exec Anim Import Anim=skSpottedJellyBeanAnims AnimFile=Models\skSpottedJellyBeanAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skSpottedJellyBeanMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSpottedJellyBeanMesh Anim=skSpottedJellyBeanAnims
#exec Anim Digest Anim=skSpottedJellyBeanAnims VERBOSE 

//texture import (skSpottedJellyBeanTex0) -AdamJD 
#exec Texture Import File=Textures\skSpottedJellyBeanTex0.png Name=skSpottedJellyBeanTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSpottedJellyBeanMesh Num=0 Texture=skSpottedJellyBeanTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skSpottedJellyBeanMesh
}
