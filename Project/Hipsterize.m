Package["Project`"]

(* this is declaring that a certain simbol can be used OUTSIDE the paclet *)
PackageExport[Hipsterize]

Hipsterize[image_] := 
	Join[
		ColorSeparate @ image, {
			image, 
			ColorNegate[image], 
			ColorQuantize[image, 3], 
			Image[image, ColorSpace -> "HSB"], 
			Image[image, ColorSpace -> "LAB"], 
			Image[image, ColorSpace -> "LCH"], 
			Image[image, ColorSpace -> "LUV"], 
			Image[image, ColorSpace -> "XYZ"]
		}
	]