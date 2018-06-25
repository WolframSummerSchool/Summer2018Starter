BeginPackage["Project`"]
EndPackage[]

(* All loading of the paclet's Wolfram Language code should go through this file. *)

(* Developer maintains this list of symbols.
   autoloadSymbols must agree with the symbols listed in the Kernel extension in the PacletInfo.m file.
*)

Map[
    (Unprotect[#];ClearAll[#]) &, {
        "Project`*",
        "Project`*`*",
        "Project`*`*`*"
    }
]

PacletManager`Package`loadWolframLanguageCode[
    "Project", 
    "Project`", 
    DirectoryName[$InputFileName], 
    "Main.m",
    "AutoUpdate" -> True,
    "ForceMX" -> False, 
    "Lock" -> False,
    "AutoloadSymbols" -> {},
    "HiddenImports" -> {}
]