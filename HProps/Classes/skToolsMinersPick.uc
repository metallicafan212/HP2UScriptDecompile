//================================================================================
// skToolsMinersPick.
//================================================================================

class skToolsMinersPick extends HPMeshActor;

//model import (skToolsMinersPickMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skToolsMinersPickMesh ModelFile=Models\skToolsMinersPickMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skToolsMinersPickMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skToolsMinersPickAnims) -AdamJD 
#exec Anim Import Anim=skToolsMinersPickAnims AnimFile=Models\skToolsMinersPickAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skToolsMinersPickMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skToolsMinersPickMesh Anim=skToolsMinersPickAnims
#exec Anim Digest Anim=skToolsMinersPickAnims VERBOSE 

//texture import (skToolsMinersPickTex0) -AdamJD 
#exec Texture Import File=Textures\skToolsMinersPickTex0.png Name=skToolsMinersPickTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skToolsMinersPickMesh Num=0 Texture=skToolsMinersPickTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skToolsMinersPickMesh
}
