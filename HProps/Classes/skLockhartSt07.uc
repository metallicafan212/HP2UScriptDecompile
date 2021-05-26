//================================================================================
// skLockhartSt07.
//================================================================================

class skLockhartSt07 extends HPMeshActor;

//model import (skLockhartSt07Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt07Mesh ModelFile=Models\skLockhartSt07Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt07Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt07Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt07Anims AnimFile=Models\skLockhartSt07Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt07Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt07Mesh Anim=skLockhartSt07Anims
#exec Anim Digest Anim=skLockhartSt07Anims VERBOSE 

//texture import (skLockhartSt07Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt07Tex0.png Name=skLockhartSt07Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt07Mesh Num=0 Texture=skLockhartSt07Tex0

//texture import (skLockhartSt07Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt07Tex1.png Name=skLockhartSt07Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt07Mesh Num=1 Texture=skLockhartSt07Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt07Mesh
}
