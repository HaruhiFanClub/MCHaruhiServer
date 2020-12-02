import mods.zenutils.command.ZenCommand;
import mods.zenutils.command.CommandUtils;
import mods.zenutils.command.IGetTabCompletion;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.data.IData;
import crafttweaker.world.IWorld;
import crafttweaker.player.IPlayer;
import mods.zenutils.UUID;
import scripts.crt.functions.RunCmd;
import scripts.crt.functions.BuildTellraw;

val cmdHat as ZenCommand = ZenCommand.create("hat");
cmdHat.getCommandUsage = function(sender) {
	return "command.shw.hat.usage";
};
cmdHat.requiredPermissionLevel = 0;
cmdHat.tabCompletionGetters = [];
cmdHat.execute = function(command, server, sender, args) {
	if (args.length == 0) {
		val player = CommandUtils.getCommandSenderAsPlayer(sender);
		val item_hand = player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand());
		val item_head = player.getItemInSlot(crafttweaker.entity.IEntityEquipmentSlot.head());
		if ((!isNull(item_head)) && (item_head.tag has "ench") && !(player.creative)) {
			for index,item in item_head.tag.ench.asList() {
					if (item.id == 10 as short) {
					// player.sendChat(game.localize("command.shw.hat.error"));
					RunCmd(BuildTellraw(player.name,["{\"translate\":\"command.shw.hat.error\"}"]));
					return;
				}
			}
		}
		player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.head(), item_hand);
		player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), item_head);
		return;
	}
	CommandUtils.notifyWrongUsage(command, sender);
};
cmdHat.register();


val myScoreCmd as ZenCommand = ZenCommand.create("myscore");
myScoreCmd.getCommandUsage = function(sender) {
	return "command.shw.myscore.usage";
};
myScoreCmd.requiredPermissionLevel = 0;
myScoreCmd.tabCompletionGetters = [];
myScoreCmd.execute = function(command, server, sender, args) {
	val player = CommandUtils.getCommandSenderAsPlayer(sender).getUUID().asString();
	if (args.length == 0) {
		val scoreObjective = {
			"loggedIn" : "message.1",
			"deathCount" : "message.2",
			"killCount" : "message.3"
		} as string[string];
		for obj, lang in scoreObjective {	
			RunCmd(BuildTellraw(
				player,
				[
					"{\"translate\":\"command.shw.myscore." + lang +"\"}",
					"{\"score\":{\"name\":\"*\",\"objective\":\"" + obj + "\"}}"
				] as string[]
			));
		}
		return;
	}
	CommandUtils.notifyWrongUsage(command, sender);
};
myScoreCmd.register();
