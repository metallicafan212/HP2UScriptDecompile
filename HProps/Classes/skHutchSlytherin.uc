//================================================================================
// skHutchSlytherin.
//================================================================================

class skHutchSlytherin extends HPMeshActor;

//model import (skHutchSlytherinMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skHutchSlytherinMesh ModelFile=Models\skHutchSlytherinMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skHutchSlytherinMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skHutchSlytherinAnims) -AdamJD 
#exec Anim Import Anim=skHutchSlytherinAnims AnimFile=Models\skHutchSlytherinAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skHutchSlytherinMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skHutchSlytherinMesh Anim=skHutchSlytherinAnims
#exec Anim Digest Anim=skHutchSlytherinAnims VERBOSE 

//texture import (skHutchSlytherinTex0) -AdamJD 
#exec Texture Import File=Textures\skHutchSlytherinTex0.png Name=skHutchSlytherinTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skHutchSlytherinMesh Num=0 Texture=skHutchSlytherinTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skHutchSlytherinMesh
}
