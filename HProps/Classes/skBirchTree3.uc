//================================================================================
// skBirchTree3.
//================================================================================

class skBirchTree3 extends HPMeshActor;

//model import (skBirchTree3Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBirchTree3Mesh ModelFile=Models\skBirchTree3Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBirchTree3Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBirchTree3Anims) -AdamJD 
#exec Anim Import Anim=skBirchTree3Anims AnimFile=Models\skBirchTree3Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBirchTree3Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBirchTree3Mesh Anim=skBirchTree3Anims
#exec Anim Digest Anim=skBirchTree3Anims VERBOSE 

//texture import (skBirchTree3Tex0) -AdamJD 
#exec Texture Import File=Textures\skBirchTree3Tex0.png Name=skBirchTree3Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBirchTree3Mesh Num=0 Texture=skBirchTree3Tex0

//texture import (skBirchTree3Tex1) -AdamJD 
#exec Texture Import File=Textures\skBirchTree3Tex1.png Name=skBirchTree3Tex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBirchTree3Mesh Num=1 Texture=skBirchTree3Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBirchTree3Mesh
}
