//class created by me to add the exec commands for finding the HPParticle textures instead of having to put them in each individual class -AdamJD
class _HPParticleImports extends Actor 
	abstract;

//get the HPParticle textures -AdamJD
#exec OBJ LOAD FILE=..\Textures\HP_FX.utx 		Package=HPParticle.hp_fx
#exec OBJ LOAD FILE=..\Textures\Particles.utx 	Package=HPParticle.particle_fx