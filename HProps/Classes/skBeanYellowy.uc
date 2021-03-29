//================================================================================
// skBeanYellowy.
//================================================================================

class skBeanYellowy extends HPMeshActor;

//model import (skBeanYellowyMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBeanYellowyMesh ModelFile=Models\skBeanYellowyMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBeanYellowyMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBeanYellowyAnims) -AdamJD 
#exec Anim Import Anim=skBeanYellowyAnims AnimFile=Models\skBeanYellowyAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBeanYellowyMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBeanYellowyMesh Anim=skBeanYellowyAnims
#exec Anim Digest Anim=skBeanYellowyAnims VERBOSE 

//texture import (skBeanYellowyTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanYellowyTex0.png Name=skBeanYellowyTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBeanYellowyMesh Num=0 Texture=skBeanYellowyTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBeanYellowyMesh
}
