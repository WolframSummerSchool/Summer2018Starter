myInternalFunction[image_] := Join[
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

(* this is a function that returns a list of hipster images *)
Hipsterize[image___] := myInternalFunction[image] 