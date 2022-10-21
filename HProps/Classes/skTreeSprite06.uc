//================================================================================
// skTreeSprite06.
//================================================================================

class skTreeSprite06 extends HPMeshActor;

//model import (skTreeSprite06Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTreeSprite06Mesh ModelFile=Models\skTreeSprite06Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTreeSprite06Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTreeSprite06Anims) -AdamJD 
#exec Anim Import Anim=skTreeSprite06Anims AnimFile=Models\skTreeSprite06Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTreeSprite06Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTreeSprite06Mesh Anim=skTreeSprite06Anims
#exec Anim Digest Anim=skTreeSprite06Anims VERBOSE 

//texture import (skTreeSprite06Tex0) -AdamJD 
#exec Texture Import File=Textures\skTreeSprite06Tex0.png Name=skTreeSprite06Tex0 COMPRESSION=P8 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTreeSprite06Mesh Num=0 Texture=skTreeSprite06Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTreeSprite06Mesh
}
