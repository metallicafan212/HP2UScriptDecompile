//================================================================================
// skBeanOrnge.
//================================================================================

class skBeanOrnge extends HPMeshActor;

//model import (skBeanOrngeMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBeanOrngeMesh ModelFile=Models\skBeanOrngeMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBeanOrngeMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBeanOrngeAnims) -AdamJD 
#exec Anim Import Anim=skBeanOrngeAnims AnimFile=Models\skBeanOrngeAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBeanOrngeMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBeanOrngeMesh Anim=skBeanOrngeAnims
#exec Anim Digest Anim=skBeanOrngeAnims VERBOSE 

//texture import (skBeanOrngeTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanOrngeTex0.png Name=skBeanOrngeTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBeanOrngeMesh Num=0 Texture=skBeanOrngeTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBeanOrngeMesh
}
