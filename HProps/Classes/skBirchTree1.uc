//================================================================================
// skBirchTree1.
//================================================================================

class skBirchTree1 extends HPMeshActor;

//model import (skBirchTree1Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skBirchTree1Mesh ModelFile=Models\skBirchTree1Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skBirchTree1Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skBirchTree1Anims) -AdamJD 
#exec Anim Import Anim=skBirchTree1Anims AnimFile=Models\skBirchTree1Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skBirchTree1Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skBirchTree1Mesh Anim=skBirchTree1Anims
#exec Anim Digest Anim=skBirchTree1Anims VERBOSE 

//texture import (skBirchTree1Tex0) -AdamJD 
#exec Texture Import File=Textures\skBirchTree1Tex0.png Name=skBirchTree1Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBirchTree1Mesh Num=0 Texture=skBirchTree1Tex0

//texture import (skBirchTree1Tex1) -AdamJD 
#exec Texture Import File=Textures\skBirchTree1Tex1.png Name=skBirchTree1Tex1 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skBirchTree1Mesh Num=1 Texture=skBirchTree1Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skBirchTree1Mesh
}
