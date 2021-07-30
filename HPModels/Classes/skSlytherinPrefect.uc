//================================================================================
// skSlytherinPrefect.
//================================================================================

class skSlytherinPrefect extends HPMesh
  Abstract;
  
//model import (skSlytherinPrefectMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skSlytherinPrefectMesh ModelFile=Models\skSlytherinPrefectMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skSlytherinPrefectMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//shared anim import (skGeorgeWeasleyAnims) -AdamJD 
#exec MeshMap Scale MeshMap=skSlytherinPrefectMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skSlytherinPrefectMesh Anim=skGeorgeWeasleyAnims

//texture import (skSlytherinPrefectTex0) -AdamJD 
#exec Texture Import File=Textures\skSlytherinPrefectTex0.png Name=skSlytherinPrefectTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSlytherinPrefectMesh Num=0 Texture=skSlytherinPrefectTex0

//texture import (skSlytherinPrefectTex1) -AdamJD 
#exec Texture Import File=Textures\skSlytherinPrefectTex1.png Name=skSlytherinPrefectTex1 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skSlytherinPrefectMesh Num=1 Texture=skSlytherinPrefectTex1

