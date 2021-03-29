//================================================================================
// skBeanBrown.
//================================================================================

class skBeanBrown extends HPMeshActor;

//model import (skBeanBrownMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBeanBrownMesh ModelFile=Models\skBeanBrownMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBeanBrownMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBeanBrownAnims) -AdamJD 
#exec Anim Import Anim=skBeanBrownAnims AnimFile=Models\skBeanBrownAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBeanBrownMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBeanBrownMesh Anim=skBeanBrownAnims
#exec Anim Digest Anim=skBeanBrownAnims VERBOSE 

//texture import (skBeanBrownTex0) -AdamJD 
#exec Texture Import File=Textures\skBeanBrownTex0.png Name=skBeanBrownTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBeanBrownMesh Num=0 Texture=skBeanBrownTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBeanBrownMesh
}
