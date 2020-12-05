#priority 49

function BuildExecute (target as string, raw_json_text as string[]) {
	var c = "";
	for item in raw_json_text {
		c += ("," + item);
	}
	return "tellraw "+ target + " [\"\"" + c + "]";
}

function BuildTellraw (target as string, raw_json_text as string[]) {
	var c = "";
	for item in raw_json_text {
		c += ("," + item);
	}
	return "tellraw "+ target + " [\"\"" + c + "]";
}







