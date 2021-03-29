//================================================================================
// skBeanDkBlue.
//================================================================================

class skBeanDkBlue extends HPMeshActor;

//model import (skBeanDkBlueMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBeanDkBlueMesh ModelFile=Models\skBeanDkBlueMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBeanDkBlueMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBeanDkBlueAnims) -AdamJD 
#exec Anim Import Anim=skBeanDkBlueAnims AnimFile=Models\skBeanDkBlueAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBeanDkBlueMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBeanDkBlueMesh Anim=skBeanDkBlueAnims
#exec Anim Digest Anim=skBeanDkBlueAnims VERBOSE 

//texture import (skBeanDkBlueTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanDkBlueTex0.png Name=skBeanDkBlueTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBeanDkBlueMesh Num=0 Texture=skBeanDkBlueTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBeanDkBlueMesh
}
