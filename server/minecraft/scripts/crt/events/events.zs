import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.events.IEventManager;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.event.EntityLivingUseItemEvent.All;
import crafttweaker.event.EnderTeleportEvent;
import crafttweaker.event.BlockBreakEvent;
import crafttweaker.event.EntityLivingFallEvent;
import crafttweaker.event.EntityLivingDeathDropsEvent;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.event.PlayerChangedDimensionEvent;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerBreakSpeedEvent;
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.event.PlayerAttackEntityEvent;
import crafttweaker.event.IEventCancelable;
import crafttweaker.event.ItemExpireEvent;
import crafttweaker.server.IServer;
import crafttweaker.potions.IPotionEffect;
import crafttweaker.game.IGame;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IItemCondition;
import crafttweaker.command.ICommandManager;
import crafttweaker.command.ICommand;
import crafttweaker.command.ICommandSender;
import mods.zenutils.UUID;

events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent) {
	if (!event.player.world.remote) {
		var player = event.player;
		var name = player.name;
		scripts.crt.functions.RunCmd("scoreboard players add " + name + " loggedIn 1");
		scripts.crt.functions.RunCmd(
			"execute @a[name=" + name + ",score_loggedIn=1] ~ ~ ~ " + scripts.crt.functions.BuildServerChan(
				"@a",
				[
					"{\"translate\":\"message.shw.login.newplayer.1\"}",
					"{\"selector\": \"@a[name=" + name + "]\"}"
				] as string[]
			)
		);
		scripts.crt.functions.RunCmd(
			"execute @a[name=" + name + "] ~ ~ ~ " + scripts.crt.functions.BuildTellraw(
				name,
				[
					"{\"translate\":\"message.shw.login.player.1\",\"with\":[\"" + name + "\"]}",
					"{\"selector\": \"@a[name=" + name + "]\"}"
				] as string[]
			)
		);
		// scripts.crt.functions.RunCmd(
		// 	"execute @a[name=" + name + "] ~ ~ ~ " + scripts.crt.functions.BuildTellraw(
		// 		name,
		// 		[
		// 			"{\"translate\":\"message.shw.login.player.2\"}",
		// 			"{\"score\":{\"name\":\"" + name + "\",\"objective\":\"loggedIn\"},\"color\":\"gray\"}"
		// 		] as string[]
		// 	)
		// );
	}
});


events.onPlayerAttackEntity(function(event as PlayerAttackEntityEvent){
	var player = event.player as IPlayer;
	var target = event.target as IEntity;
	if (!player.world.remote && !target.world.remote) {
		var item = event.player.currentItem;
		if (isNull(item)) {return;}
		if (item.definition.id == "contenttweaker:physics_excalibur" ) {
			if (player.creative) {
				val target_uuid = target.getUUID().asString();
				val player_uuid = player.getUUID().asString();
				if ((item.tag has "mode") && (item.tag.mode == 1)) {
					event.cancel();
					target.setDead();
					print("Player " + player.name + "(" + player_uuid + ") with NBT: " + player.getNBT().asString() + " removed entity " + target.definition.id + "(" + target_uuid + ") with NBT: " + target.getNBT().asString() +" by contenttweaker:physics_excalibur in dimension " + player.dimension);
					val tellraw = scripts.crt.functions.BuildTellraw(
						"@a",
						[
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.1\",\"color\":\"gray\"}",
							"{\"text\":\""+player.name+"\",\"color\":\"gray\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\""+game.localize("item.contenttweaker.physics_excalibur.message.info.2") + "§7 "+player.name+"\n§rUUID:§7 "+player_uuid+"\n§r"+game.localize("item.contenttweaker.physics_excalibur.message.info.3")+"§7 X:"+player.posX+",Y:"+player.posY+",Z:"+player.posZ+",DIM:"+player.dimension+"\"}}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.2\",\"color\":\"gray\"}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.name\",\"color\":\"gray\",\"hoverEvent\":{\"action\":\"show_item\",\"value\":\"{\\\"id\\\":\\\"contenttweaker:physics_excalibur\\\",\\\"Count\\\":1}\"}}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.3\",\"color\":\"gray\"}",
							"{\"text\":\""+target.definition.name+"\",\"color\":\"gray\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\""+game.localize("item.contenttweaker.physics_excalibur.message.info.2")+"§7 "+target.definition.name+"\n§r"+game.localize("item.contenttweaker.physics_excalibur.message.info.4")+"§7 "+target.displayName+"\n§r"+game.localize("item.contenttweaker.physics_excalibur.message.info.5")+"§7 "+target.customName+"\n§rID:§7 "+target.definition.id+"\n§rUUID:§7 "+target_uuid+"\n§r"+game.localize("item.contenttweaker.physics_excalibur.message.info.3")+"§7 X:"+target.posX+",Y:"+target.posY+",Z:"+target.posZ+",DIM:"+target.dimension+"\"}}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.4\",\"color\":\"gray\"}"
						] as string[]
					);
					scripts.crt.functions.RunCmd(tellraw);
					player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), <contenttweaker:physics_excalibur>);
					return;
				}
				if (player.isSneaking) {
					event.cancel();
					val tellraw = scripts.crt.functions.BuildTellraw(
						player_uuid,
						[
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.1\"}",
							"{\"text\":\"\n  \"}",
							"{\"text\":\"ID:\"}",
							"{\"text\":\" " + target.definition.id + "\"}",
							"{\"text\":\"\n  \"}",
							"{\"text\":\"UUID:\"}",
							"{\"text\":\" " + target_uuid + "\",\"insertion\":\"" + target_uuid + "\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"" + game.localize("item.contenttweaker.physics_excalibur.message.hover.2") + "\"}}",
							"{\"text\":\"\n  \"}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.2\"}",
							"{\"text\":\" " + target.definition.name + "\"}",
							"{\"text\":\"\n  \"}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.4\"}",
							"{\"text\":\" " + target.displayName + "\"}",
							"{\"text\":\"\n  \"}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.5\"}",
							"{\"text\":\" " + target.customName + "\"}",
							"{\"text\":\"\n  \"}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.3\"}",
							"{\"text\":\" X:"+target.posX+",Y:"+target.posY+",Z:"+target.posZ+",DIM:"+target.dimension+"\"}",
						] as string[]
					);
					scripts.crt.functions.RunCmd(tellraw);
					return;
				}
				event.cancel();
				player.sendChat(game.localize("item.contenttweaker.physics_excalibur.message.fail.2"));

			} else {
				event.cancel();
				player.sendChat(game.localize("item.contenttweaker.physics_excalibur.message.fail.1"));
			}
		}
	}
});
