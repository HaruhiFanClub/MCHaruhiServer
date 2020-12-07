import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityItem;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.entity.IEntityEquipmentSlot;
import crafttweaker.damage.IDamageSource;
import crafttweaker.events.IEventManager;
import crafttweaker.event.ILivingEvent;
import crafttweaker.event.EntityLivingDeathDropsEvent;
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.event.PlayerAttackEntityEvent;
import crafttweaker.event.IEventCancelable;
import crafttweaker.server.IServer;
import crafttweaker.game.IGame;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IItemCondition;
import mods.zenutils.UUID;
import mods.ctutils.utils.Math;
import scripts.utils.common.RunCmd;
import scripts.utils.command.vanilla.BuildTellraw;
import scripts.utils.command.extend.BuildServerChan;

events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent) {
	if (!event.player.world.remote) {
		val player = event.player;
		val name = player.name;
		
		val data = {PlayerPersisted:{loggedIn:0}} as IData + player.data;
		val logged_in = data.PlayerPersisted.loggedIn.asInt();

		if (logged_in != 0) {
			RunCmd(BuildTellraw(
				name,
				[
					"{\"translate\":\"message.shw.login.player.1\",\"with\":[\"" + name + "\"]}",
					"{\"selector\": \"@a[name=" + name + "]\"}"
				] as string[]
			));
		} else {
			RunCmd(BuildServerChan(
				"@a",
				[
					"{\"translate\":\"message.shw.login.newplayer.1\"}",
					"{\"selector\": \"@a[name=" + name + "]\"}"
				] as string[]
			));
		}

		RunCmd("scoreboard players set " + name + " loggedIn " + (logged_in+1));
		player.update({PlayerPersisted:{loggedIn:logged_in+1}} as IData);
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
					val tellraw = BuildTellraw(
						"@a",
						[
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.1\",\"color\":\"gray\"}",
							"{\"text\":\""+player.name+"\",\"color\":\"gray\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Name:§7 "+player.name+"\n§rUUID:§7 "+player_uuid+"\n§rPos:§7 X:"+player.posX+",Y:"+player.posY+",Z:"+player.posZ+",DIM:"+player.dimension+"\"}}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.2\",\"color\":\"gray\"}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.name\",\"color\":\"gray\",\"hoverEvent\":{\"action\":\"show_item\",\"value\":\"{\\\"id\\\":\\\"contenttweaker:physics_excalibur\\\",\\\"Count\\\":1}\"}}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.3\",\"color\":\"gray\"}",
							"{\"text\":\""+target.definition.name+"\",\"color\":\"gray\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Name:§7 "+target.definition.name+"\n§rDisplay Name:§7 "+target.displayName+"\n§rCustom Name:§7 "+target.customName+"\n§rID:§7 "+target.definition.id+"\n§rUUID:§7 "+target_uuid+"\n§rPos: §7 X:"+target.posX+",Y:"+target.posY+",Z:"+target.posZ+",DIM:"+target.dimension+"\"}}",
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.success.4\",\"color\":\"gray\"}"
						] as string[]
					);
					RunCmd(tellraw);
					player.setItemToSlot(crafttweaker.entity.IEntityEquipmentSlot.mainHand(), <contenttweaker:physics_excalibur>);
					return;
				}
				if (player.isSneaking) {
					event.cancel();
					val tellraw = BuildTellraw(
						player_uuid,
						[
							"{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.1\"}",
							"{\"text\":\"\n  \"}","{\"text\":\"ID:\"}","{\"text\":\" " + target.definition.id + "\"}",
							"{\"text\":\"\n  \"}","{\"text\":\"UUID:\"}","{\"text\":\" " + target_uuid + "\",\"insertion\":\"" + target_uuid + "\",\"hoverEvent\":{\"action\":\"show_text\",\"value\":\"Shift-click to insert into chat input\"}}",
							"{\"text\":\"\n  \"}","{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.2\"}","{\"text\":\" " + target.definition.name + "\"}",
							"{\"text\":\"\n  \"}","{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.4\"}","{\"text\":\" " + target.displayName + "\"}",
							"{\"text\":\"\n  \"}","{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.5\"}","{\"text\":\" " + target.customName + "\"}",
							"{\"text\":\"\n  \"}","{\"translate\":\"item.contenttweaker.physics_excalibur.message.info.3\"}","{\"text\":\" X:"+target.posX+",Y:"+target.posY+",Z:"+target.posZ+",DIM:"+target.dimension+"\"}",
						] as string[]
					);
					RunCmd(tellraw);
					return;
				}
				event.cancel();
				RunCmd(BuildTellraw(player.name,["{\"translate\":\"item.contenttweaker.physics_excalibur.message.fail.2\"}"]));

			} else {
				event.cancel();
				RunCmd(BuildTellraw(player.name,["{\"translate\":\"item.contenttweaker.physics_excalibur.message.fail.1\"}"]));
			}
		}
	}
});


events.onEntityLivingDeathDrops(function(event as EntityLivingDeathDropsEvent){
	if ((!event.entityLivingBase.world.remote) && (event.damageSource.getDamageType() == "anvil") && (!isNull(event.entityLivingBase.definition))) {
		if (Math.random() > 0.95){
			event.addItem(<contenttweaker:nijigen_crystal>.createEntityItem(event.entityLivingBase.world, event.entityLivingBase.position));
		}
	}
});
