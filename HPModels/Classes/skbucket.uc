//================================================================================
// skbucket.
//================================================================================

class skbucket extends HPMesh
  Abstract;
  
//model import (skbucketMesh) -AdamJD 
#exec Mesh ModelImport Mesh=skbucketMesh ModelFile=Models\skbucketMesh.psk LODStyle=10 
#exec Mesh Origin Mesh=skbucketMesh X=0 Y=0 Z=0 Yaw=0 Pitch=0 Roll=0 

//anim import (skbucketAnims) -AdamJD 
#exec Anim Import Anim=skbucketAnims AnimFile=Models\skbucketAnims.psa Compress=1 MaxKeys=999999 ImportSeqs=1 
#exec MeshMap Scale MeshMap=skbucketMesh X=1.0 Y=1.0 Z=1.0 
#exec Mesh DefaultAnim Mesh=skbucketMesh Anim=skbucketAnims
#exec Anim Digest Anim=skbucketAnims VERBOSE 

//texture import (skbucketTex0) -AdamJD 
#exec Texture Import File=Textures\skbucketTex0.png Name=skbucketTex0 COMPRESSION=0 UPSCALE=1 Mips=1 Flags=0 Group=Skins 
#exec MeshMap SetTexture MeshMap=skbucketMesh Num=0 Texture=skbucketTex0

