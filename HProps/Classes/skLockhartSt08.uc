//================================================================================
// skLockhartSt08.
//================================================================================

class skLockhartSt08 extends HPMeshActor;

//model import (skLockhartSt08Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt08Mesh ModelFile=Models\skLockhartSt08Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt08Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt08Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt08Anims AnimFile=Models\skLockhartSt08Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt08Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt08Mesh Anim=skLockhartSt08Anims
#exec Anim Digest Anim=skLockhartSt08Anims VERBOSE

//texture import (skLockhartSt08Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt08Tex0.png Name=skLockhartSt08Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt08Mesh Num=0 Texture=skLockhartSt08Tex0

//texture import (skLockhartSt08Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt08Tex1.png Name=skLockhartSt08Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt08Mesh Num=1 Texture=skLockhartSt08Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt08Mesh
}
