#priority 32767

import crafttweaker.server.IServer;
import crafttweaker.command.ICommandManager;
import crafttweaker.command.ICommand;
import crafttweaker.command.ICommandSender;
import crafttweaker.player.IPlayer;

function BuildTellraw (target as string, raw_json_text as string[]) {
	var c = "";
	for item in raw_json_text {
		c += ("," + item);
	}
	return "tellraw "+ target + " [\"\"" + c + "]";
}

function BuildServerChan (target as string, raw_json_text as string[]) {
	var json = ["{\"translate\":\"character.server_chan.name\",\"bold\":true}"] as string[];
	for item in raw_json_text {
		json += item;
	}
	return BuildTellraw(target,json);
}

function RunCmd (c as string) {
	server.commandManager.executeCommand(server,c);
}




