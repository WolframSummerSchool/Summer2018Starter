Package["Project`"]

(* this is declaring that a certain simbol can be used OUTSIDE the paclet *)
PackageExport[CollectData]

CollectData[] := $SomeSymbol * Import[
	(* Paclet Resource is an internal function to resolve the path on disk of a certain folder without hardcoding it.
		Always use this function in your code to resolve data location folder, it makes the code portable to a different machine.
	 *)
	FileNameJoin[{PacletManager`PacletResource["Project", "Assets"], "data.csv"}], 
	"CSV"
]