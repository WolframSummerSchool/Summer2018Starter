
generator[n_] := Module[
	{tab, rot},
	tab = RandomReal[{-1/2, 1/2}, {n, 2}];
	rot = RotationMatrix[Pi/3];
	ImageResize[Graphics[
	{Hue[SeedRandom[n]; RandomReal[]], Opacity[RandomReal[{0.3, 0.6}]],
	 Polygon[tab.MatrixPower[rot, #]] & /@ Range[6]}, 
	Background -> White
], {400, 400}]]

$SnowFlakerForm = FormFunction[
	{"SnowFlake" -> <|"Interpreter"-> "Integer", "Input" -> "12"|>},
	HTTPRedirect[$AppRoot <> "snowflake/" <> ToString[#SnowFlake]] &
]

$AppRoot := Replace[$EvaluationCloudObject, {None -> "/", c_CloudObject :> First[c] <> "/"}]; 

templateLoader[path_] := FileTemplate[
	FileNameJoin[{"Templates", path}],
	Path -> DirectoryName[$InputFileName]
];
templateResponse[path_String, rest___] :=
	templateResponse[templateLoader[path], rest]

templateResponse[template_, context_, meta_:<||>] := 
	HTTPResponse[
		TemplateApply[
			template, <|
				context, 
				"AppRoot" -> $AppRoot
			|>
		],
		meta
	]

$SnowFlakerApp = With[{
	home     = templateLoader["index.html"], 
	detail   = templateLoader["detail.html"],
	notfound = templateLoader["404.html"]
	},
	URLDispatcher[{
		"/" ~~ EndOfString :> Replace[
			$SnowFlakerForm[Replace[HTTPRequestData["FormRules"], {} -> None]],
			form_FormFunction :> templateResponse[
				home, {
				"result" -> form
			}]
		],
		"/snowflake/" ~~ n:DigitCharacter.. ~~ EndOfString 
			:> templateResponse[detail, {
				"title" -> "SnowFlaker / "<> n,
				"description" -> "This is the snow flake "<> n <>" which is super cool.",
				"result" -> generator[FromDigits[n]],
				"number" -> FromDigits[n]
			}],
		___ :> templateResponse[
			notfound,
			<||>,
			<|"StatusCode" -> 404|>
			]
		}
	]
];