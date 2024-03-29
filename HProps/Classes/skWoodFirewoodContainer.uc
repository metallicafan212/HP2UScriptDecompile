//================================================================================
// skWoodFirewoodContainer.
//================================================================================

class skWoodFirewoodContainer extends HPMeshActor;

//model import (skWoodFirewoodContainerMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skWoodFirewoodContainerMesh ModelFile=Models\skWoodFirewoodContainerMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skWoodFirewoodContainerMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skWoodFirewoodContainerAnims) -AdamJD 
#exec Anim Import Anim=skWoodFirewoodContainerAnims AnimFile=Models\skWoodFirewoodContainerAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skWoodFirewoodContainerMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skWoodFirewoodContainerMesh Anim=skWoodFirewoodContainerAnims
#exec Anim Digest Anim=skWoodFirewoodContainerAnims VERBOSE 

//texture import (skWoodFirewoodContainerTex0) -AdamJD 
#exec Texture Import File=Textures\skWoodFirewoodContainerTex0.png Name=skWoodFirewoodContainerTex0 COMPRESSION=3 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skWoodFirewoodContainerMesh Num=0 Texture=skWoodFirewoodContainerTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skWoodFirewoodContainerMesh
}
