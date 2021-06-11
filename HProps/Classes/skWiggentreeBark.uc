//================================================================================
// skWiggentreeBark.
//================================================================================

class skWiggentreeBark extends HPMeshActor;

//model import (skWiggentreeBarkMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWiggentreeBarkMesh ModelFile=Models\skWiggentreeBarkMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWiggentreeBarkMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWiggentreeBarkAnims) -AdamJD 
#exec Anim Import Anim=skWiggentreeBarkAnims AnimFile=Models\skWiggentreeBarkAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWiggentreeBarkMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWiggentreeBarkMesh Anim=skWiggentreeBarkAnims
#exec Anim Digest Anim=skWiggentreeBarkAnims VERBOSE 

//texture import (skWiggentreeBarkTex0) -AdamJD 
#exec Texture Import File=Textures\skWiggentreeBarkTex0.png Name=skWiggentreeBarkTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWiggentreeBarkMesh Num=0 Texture=skWiggentreeBarkTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skWiggentreeBarkMesh
}
