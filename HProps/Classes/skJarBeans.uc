//================================================================================
// skJarBeans.
//================================================================================

class skJarBeans extends HPMeshActor;

//model import (skJarBeansMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJarBeansMesh ModelFile=Models\skJarBeansMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJarBeansMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0

//anim import (skJarBeansAnims) -AdamJD 
#exec Anim Import Anim=skJarBeansAnims AnimFile=Models\skJarBeansAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJarBeansMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJarBeansMesh Anim=skJarBeansAnims
#exec Anim Digest Anim=skJarBeansAnims VERBOSE 

//texture import (skJarBeansTex0) -AdamJD 
#exec Texture Import File=Textures\skJarBeansTex0.png Name=skJarBeansTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarBeansMesh Num=0 Texture=skJarBeansTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJarBeansMesh
}
