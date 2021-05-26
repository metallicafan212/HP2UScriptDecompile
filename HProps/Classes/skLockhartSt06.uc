//================================================================================
// skLockhartSt06.
//================================================================================

class skLockhartSt06 extends HPMeshActor;

//model import (skLockhartSt06Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skLockhartSt06Mesh ModelFile=Models\skLockhartSt06Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skLockhartSt06Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skLockhartSt06Anims) -AdamJD 
#exec Anim Import Anim=skLockhartSt06Anims AnimFile=Models\skLockhartSt06Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skLockhartSt06Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skLockhartSt06Mesh Anim=skLockhartSt06Anims
#exec Anim Digest Anim=skLockhartSt06Anims VERBOSE 

//texture import (skLockhartSt06Tex0) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt06Tex0.png Name=skLockhartSt06Tex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt06Mesh Num=0 Texture=skLockhartSt06Tex0

//texture import (skLockhartSt06Tex1) -AdamJD 
#exec Texture Import File=Textures\skLockhartSt06Tex1.png Name=skLockhartSt06Tex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skLockhartSt06Mesh Num=1 Texture=skLockhartSt06Tex1

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skLockhartSt06Mesh
}
