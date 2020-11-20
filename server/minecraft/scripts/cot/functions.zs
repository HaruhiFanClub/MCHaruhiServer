#priority 32766
#loader contenttweaker

import crafttweaker.server.IServer;
import crafttweaker.command.ICommandManager;
import crafttweaker.command.ICommand;
import crafttweaker.command.ICommandSender;
import crafttweaker.player.IPlayer;

function GTellraw (target as string, raw_json_text as string[]) {
	var c = "";
	for item in raw_json_text {
		c += ("," + item);
	}
	server.commandManager.executeCommand(server,"tellraw "+ target + " [\"\"" + c + "]");
}

function GLog (raw as string[]) {
	var c = "";
	for item in raw {
		c += (item + ",");
	}
	logger.logInfo(c);
}



