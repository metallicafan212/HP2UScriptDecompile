//================================================================================
// skJarWiggentreeBark.
//================================================================================

class skJarWiggentreeBark extends HPMeshActor;

//model import (skJarWiggentreeBarkMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skJarWiggentreeBarkMesh ModelFile=Models\skJarWiggentreeBarkMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skJarWiggentreeBarkMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skJarWiggentreeBarkAnims) -AdamJD 
#exec Anim Import Anim=skJarWiggentreeBarkAnims AnimFile=Models\skJarWiggentreeBarkAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skJarWiggentreeBarkMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skJarWiggentreeBarkMesh Anim=skJarWiggentreeBarkAnims
#exec Anim Digest Anim=skJarWiggentreeBarkAnims VERBOSE 

//texture import (skJarWiggentreeBarkTex0) -AdamJD 
#exec Texture Import File=Textures\skJarWiggentreeBarkTex0.png Name=skJarWiggentreeBarkTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarWiggentreeBarkMesh Num=0 Texture=skJarWiggentreeBarkTex0

//texture import (skJarWiggentreeBarkTex1) -AdamJD 
#exec Texture Import File=Textures\skJarWiggentreeBarkTex1.png Name=skJarWiggentreeBarkTex1 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarWiggentreeBarkMesh Num=1 Texture=skJarWiggentreeBarkTex1

//texture import (skJarWiggentreeBarkTex2) -AdamJD 
#exec Texture Import File=Textures\skJarWiggentreeBarkTex2.png Name=skJarWiggentreeBarkTex2 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skJarWiggentreeBarkMesh Num=2 Texture=skJarWiggentreeBarkTex2

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skJarWiggentreeBarkMesh
}
