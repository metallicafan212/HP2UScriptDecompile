//================================================================================
// skCutSceneMarker.
//================================================================================

class skCutSceneMarker extends HPMeshActor;

//model import (skCutSceneMarkerMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skCutSceneMarkerMesh ModelFile=Models\skCutSceneMarkerMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skCutSceneMarkerMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skCutSceneMarkerAnims) -AdamJD 
#exec Anim Import Anim=skCutSceneMarkerAnims AnimFile=Models\skCutSceneMarkerAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skCutSceneMarkerMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skCutSceneMarkerMesh Anim=skCutSceneMarkerAnims
#exec Anim Digest Anim=skCutSceneMarkerAnims VERBOSE 

//texture import (skCutSceneMarkerTex0) -AdamJD 
#exec Texture Import File=Textures\skCutSceneMarkerTex0.png Name=skCutSceneMarkerTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skCutSceneMarkerMesh Num=0 Texture=skCutSceneMarkerTex0

defaultproperties
{
    DrawType=DT_Mesh

    Mesh=skCutSceneMarkerMesh
}
