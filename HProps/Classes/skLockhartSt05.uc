//================================================================================
// skLockhartSt05.
//================================================================================

class skLockhartSt05 extends HPMeshActor;

//model import (skLockhartSt05Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt05Mesh ModelFile=Models\skLockhartSt05Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt05Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt05Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt05Anims AnimFile=Models\skLockhartSt05Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt05Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt05Mesh Anim=skLockhartSt05Anims
#exec Anim Digest Anim=skLockhartSt05Anims VERBOSE

//texture import (skLockhartSt05Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt05Tex0.png Name=skLockhartSt05Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt05Mesh Num=0 Texture=skLockhartSt05Tex0

//texture import (skLockhartSt05Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt05Tex1.png Name=skLockhartSt05Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt05Mesh Num=1 Texture=skLockhartSt05Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt05Mesh
}
