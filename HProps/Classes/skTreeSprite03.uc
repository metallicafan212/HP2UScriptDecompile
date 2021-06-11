//================================================================================
// skTreeSprite03.
//================================================================================

class skTreeSprite03 extends HPMeshActor;

//model import (skTreeSprite03Mesh) -AdamJD 
#exec Mesh ModelImport Mesh=skTreeSprite03Mesh ModelFile=Models\skTreeSprite03Mesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skTreeSprite03Mesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skTreeSprite03Anims) -AdamJD 
#exec Anim Import Anim=skTreeSprite03Anims AnimFile=Models\skTreeSprite03Anims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skTreeSprite03Mesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skTreeSprite03Mesh Anim=skTreeSprite03Anims
#exec Anim Digest Anim=skTreeSprite03Anims VERBOSE 

//texture import (skTreeSprite03Tex0) -AdamJD 
#exec Texture Import File=Textures\skTreeSprite03Tex0.png Name=skTreeSprite03Tex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=2 Group=Skins 
#exec MeshMap SetTexture MeshMap=skTreeSprite03Mesh Num=0 Texture=skTreeSprite03Tex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skTreeSprite03Mesh
}
