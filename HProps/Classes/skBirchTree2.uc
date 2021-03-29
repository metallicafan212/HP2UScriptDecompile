//================================================================================
// skBirchTree2.
//================================================================================

class skBirchTree2 extends HPMeshActor;

//model import (skBirchTree2Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBirchTree2Mesh ModelFile=Models\skBirchTree2Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBirchTree2Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBirchTree2Anims) -AdamJD 
#exec Anim Import Anim=skBirchTree2Anims AnimFile=Models\skBirchTree2Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBirchTree2Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBirchTree2Mesh Anim=skBirchTree2Anims
#exec Anim Digest Anim=skBirchTree2Anims VERBOSE 

//texture import (skBirchTree2Tex0) -AdamJD 
#exec Texture Import File=Textures\skBirchTree2Tex0.png Name=skBirchTree2Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBirchTree2Mesh Num=0 Texture=skBirchTree2Tex0

//texture import (skBirchTree2Tex1) -AdamJD 
#exec Texture Import File=Textures\skBirchTree2Tex1.png Name=skBirchTree2Tex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBirchTree2Mesh Num=1 Texture=skBirchTree2Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBirchTree2Mesh
}
