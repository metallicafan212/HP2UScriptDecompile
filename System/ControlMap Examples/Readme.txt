Adding in new binds is easy with the M212FEBindPage

The default files that come with the Widescreen mod are designed to be
used with the stock game's controls, however, many UnrealScript coders
are going to want to add in more controls to the game. Originally, this
was a big pain in the ass from how the menu was coded, and how Categories
implicitly worked. Here, they are instead explicitly defined per command.

M212ControlMap.GIN or M212ControlMap_Controller.GIN
	The layout and command file.

Each line represents a slot on the page, which by default has 24 slots,
split into 2 columns. Exceeding 24 results in it creating a new page,
scaling infinitely if need be (though you really should not be adding 
that many). 

Line commands:
"label" 			Creates a label, which is white.
"" or "blank" 		Creates a blank element, useful for spacing and aesthetics.

Otherwise, it is interpreted as a command. Command labels appear green.

Command syntax:
Category:Command	Colon seperated category and command that should be bound
Example:	ingame:Jump
Creates the Jump command under the ingame category

Categories allow for certain rules to be followed. Within a category, only one
command can be bound to the same key. For example: Forwards and Backwards can't
both be bound to W. However, you could bind both Use Wand and Catch/Push in Quidditch
since they are in different categories. This is used intentionally for the controller
binds for Skip Cutscene.



M212ControlMap_Lang.[Language Extension] or M212ControlMap_Controller_Lang.[Langauge Extension]
By default, it attempts to load the matching language extension for the control map.
If it does not exist, it reverts to INT, and loads that one. This is used for the 
Widescreen mod to load the stock translation files for the already existing binds.

This file directly corresponds to the layout of the ControlMap. It's recommended to open
both files in Notepad++, right click one of them and Move To Other View, which will let
you edit them side by side.

Line commands:
"localization"		Loads from a localization file, under the [All] section. Designed
only for KnowWonder's already made localization files, as it's just harder to work with.
Syntax:	Localization.File.Key	
Example:	Localization.HPMenu.Options_0029
Will appear as the translation for "Jump"

Otherwise, the labels will appear to be how they've been written in the translation file.
This makes it nice and easy to directly correlate names to commands (Like Use Wand to AltFire)