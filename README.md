# HP2UScriptDecompile (Scaling-Patch)
Working decompiles of the obfuscated UScript in HP2 edited to work in widescreen resolutions.  
Requires Metallicafan212's engine to recompile these.

The stock version can be found [here](https://github.com/metallicafan212/HP2UScriptDecompile/tree/master).  
Please note that [Releases](https://github.com/metallicafan212/HP2UScriptDecompile/releases) were built using the stock version.

## WARNING
This is the pre-alpha widescreen mod branch, but most things should work.  
A new version is going to be worked on that will be a complete remake of the stock menus so they fit better on any screen size.

## Compiling yourself
To compile yourself, download the repo and add these folders to your game directiory (above System).
Then, go into default.ini in System and make sure that each package here is in the EditPackages list in [Editor.EditorEngine]

All you have to do is run ucc make in the system directory now.
