import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntity;
import crafttweaker.entity.IEntityLiving;
import crafttweaker.entity.IEntityLivingBase;
import crafttweaker.events.IEventManager;
import crafttweaker.event.PlayerTickEvent;
import crafttweaker.event.PlayerLoggedInEvent;
import crafttweaker.server.IServer;
import crafttweaker.game.IGame;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IItemCondition;
import crafttweaker.command.ICommandManager;
import crafttweaker.command.ICommand;
import crafttweaker.command.ICommandSender;

recipes.remove(<vs_control:rotation_axle>);
recipes.remove(<chiselsandbits:bit_bag>);
recipes.remove(<chiselsandbits:chisel_diamond>);
recipes.remove(<chiselsandbits:chisel_gold>);
recipes.remove(<chiselsandbits:chisel_iron>);
recipes.remove(<chiselsandbits:chisel_stone>);
recipes.remove(<chiselsandbits:chiseled_clay>);
recipes.remove(<chiselsandbits:chiseled_cloth>);
recipes.remove(<chiselsandbits:chiseled_fluid>);
recipes.remove(<chiselsandbits:chiseled_glass>);
recipes.remove(<chiselsandbits:chiseled_grass>);
recipes.remove(<chiselsandbits:chiseled_ground>);
recipes.remove(<chiselsandbits:chiseled_ice>);
recipes.remove(<chiselsandbits:chiseled_iron>);
recipes.remove(<chiselsandbits:chiseled_leaves>);
recipes.remove(<chiselsandbits:chiseled_packedice>);
recipes.remove(<chiselsandbits:chiseled_rock>);
recipes.remove(<chiselsandbits:chiseled_sand>);
recipes.remove(<chiselsandbits:chiseled_snow>);
recipes.remove(<chiselsandbits:chiseled_wood>);
recipes.remove(<chiselsandbits:mirrorprint>);
recipes.remove(<chiselsandbits:negativeprint>);
recipes.remove(<chiselsandbits:positiveprint>);
recipes.remove(<chiselsandbits:tape_measure>);
recipes.remove(<chiselsandbits:wrench_wood>);
recipes.remove(<toughasnails:temperature_coil:*>);
recipes.remove(<ic2:te:2>);
mods.jei.JEI.addDescription(<ic2:te:2>, "?你在想甚?");
recipes.remove(<ic2:te:82>);
recipes.remove(<ic2:dynamite>);
recipes.remove(<ic2:dynamite_sticky>);
recipes.remove(<randomthings:spectrecoil_number>);
recipes.remove(<randomthings:spectrecoil_ender>);
recipes.remove(<randomthings:spectrecoil_redstone>);
recipes.remove(<randomthings:spectrecoil_normal>);
recipes.remove(<randomthings:spectrekey>);
recipes.remove(<randomthings:spectreanchor>);
recipes.remove(<ebwizardry:wizard_handbook>);
recipes.remove(<roughtweaks:bandage>);
recipes.remove(<botania:laputashard:*>);
recipes.remove(<botania:teruterubozu>);
recipes.remove(<botania:enderhand>);
recipes.remove(<botania:blackholetalisman>);
recipes.remove(<appliedenergistics2:spatial_pylon>);

recipes.addShaped(<vs_control:vs_wrench>, [[null, <ore:ingotIron>, null], [null, <ore:ingotIron>, <ore:ingotIron>], [<vs_world:valkyrium_crystal>, null, null]]);
recipes.addShaped(<vs_control:ship_helm>, [[null, <ore:gemDiamond>, null], [<ore:gemDiamond>, <vs_world:valkyrium_crystal>, <ore:gemDiamond>], [null, <ore:gemDiamond>, null]]);
recipes.addShaped(<vs_control:speed_telegraph>, [[null, <vs_world:valkyrium_crystal>, null], [null, <minecraft:iron_ingot>, null], [<minecraft:iron_ingot>, <minecraft:iron_ingot>, <minecraft:iron_ingot>]]);
recipes.addShaped(<vs_control:network_relay>, [[null, <vs_world:valkyrium_crystal>, null], [<minecraft:iron_ingot>, <minecraft:iron_ingot>, <minecraft:iron_ingot>]]);
recipes.addShaped(<vs_control:lift_lever>, [[null, null, <ore:ingotIron>], [null, <ore:ingotIron>, <ore:ingotIron>], [<minecraft:iron_ingot>, <vs_world:valkyrium_crystal>, <ore:ingotIron>]]);
recipes.addShaped(<vs_control:rudder_part>, [[<vs_world:valkyrium_crystal>, <vs_world:valkyrium_crystal>, <minecraft:iron_ingot>], [null, <vs_world:valkyrium_crystal>, <minecraft:iron_ingot>], [null, null, <minecraft:iron_ingot>]]);
recipes.addShaped(<vs_control:gearbox>, [[<ore:ingotIron>, <minecraft:gold_ingot>, <ore:ingotIron>], [<minecraft:gold_ingot>, <vs_world:valkyrium_crystal>, <minecraft:gold_ingot>], [<ore:ingotIron>, <minecraft:gold_ingot>, <ore:ingotIron>]]);
recipes.addShaped(<vs_control:giant_propeller_part>, [[null, <minecraft:iron_ingot>, null], [<minecraft:iron_ingot>, <vs_world:valkyrium_crystal>, <minecraft:iron_ingot>], [null, <minecraft:iron_ingot>, null]]);
recipes.addShaped(<vs_control:rotation_axle>, [[<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>]]);
recipes.addShaped(<vs_control:gyroscope_dampener>, [[<minecraft:iron_ingot>, null, <minecraft:iron_ingot>], [null, <vs_control:compacted_valkyrium>, null], [<minecraft:iron_ingot>, null, <ore:ingotIron>]]);
recipes.addShaped(<vs_control:gyroscope_stabilizer>, [[null, <minecraft:iron_ingot>, null], [<ore:ingotIron>, <vs_control:compacted_valkyrium>, <ore:ingotIron>], [null, <ore:ingotIron>, null]]);

recipes.addShaped(
	<roughtweaks:bandage>, 
	[
		[<ore:paper>, <ore:ingotGold>, <ore:paper>],
		[<minecraft:clay_ball>, <ore:wool>, <minecraft:clay_ball>],
		[<ore:paper>, <ore:string>, <ore:paper>]
	]
);


recipes.remove(<randomthings:timeinabottle>);
recipes.addShaped(
	<randomthings:timeinabottle>,
	[
		[<ore:gemLapis>,<botania:manaresource:14>,<ore:gemLapis>],
		[<ore:gemDiamond>,<minecraft:clock>,<ore:gemDiamond>],
		[<ic2:misc_resource:1>,<minecraft:glass_bottle>,<ic2:misc_resource:1>] // 铱矿石
	]
);

recipes.remove(<ic2:mining_laser>);
<toughasnails:tan_icon>.displayName = "采 矿 镭 射 枪";
recipes.remove(<toughasnails:tan_icon>);
recipes.addShaped(
	<toughasnails:tan_icon>,
	[
		[<ore:dustRedstone>, <ore:dustRedstone>, <ore:energyCrystal>],
		[<ore:plateAdvancedAlloy>, <ore:plateAdvancedAlloy>, <ore:circuitAdvanced>],
		[null, <ore:plateAdvancedAlloy>, <ore:plateAdvancedAlloy>]
	]
);
mods.jei.JEI.addDescription(<toughasnails:tan_icon>, "采矿镭射枪的合成用替代品");
mods.jei.JEI.addDescription(<ic2:mining_laser>, "不会吧不会吧，不会真有人以为服务器里给用这玩意吧？");

recipes.remove(<ic2:te:52>);
recipes.addShaped(
	<ic2:te:52>, 
	[
		[<ic2:crafting:5>, <toughasnails:tan_icon>, <ic2:crafting:5>],
		[<ore:ingotIron>, <ore:machineBlockAdvanced>, <ore:ingotIron>],
		[<ore:ingotIron>, <ic2:crafting:6>, <ore:ingotIron>]
	]
);

recipes.remove(<ic2:te:57>);
recipes.addShaped(
	<ic2:te:57>, 
	[
		[<ore:plateAdvancedAlloy>, <toughasnails:tan_icon>, <ore:plateAdvancedAlloy>],
		[<ic2:te:74>, <ore:machineBlockAdvanced>, <ic2:te:39>],
		[<ore:plateAdvancedAlloy>, <ic2:te:60>, <ore:plateAdvancedAlloy>]
	]
);

recipes.remove(<ic2:te:62>);
recipes.addShaped(
	<ic2:te:62>,
	[
		[<ic2:resource:11>, <ic2:resource:11>, <ic2:resource:11>],
		[<ic2:crystal_memory>, <ore:machineBlockAdvanced>, <ic2:crystal_memory>],
		[<toughasnails:tan_icon>, <ore:circuitAdvanced>, <toughasnails:tan_icon>]
	]
);

recipes.addShaped(
	<ebwizardry:astral_diamond>,
	[
		[<ore:blockDiamond>, <botania:storage:3>, <ore:blockDiamond>],
		[<botania:storage:3>, <ore:netherStar>, <botania:storage:3>],
		[<ore:blockDiamond>, <botania:storage:3>, <ore:blockDiamond>]
	]
);


mods.ic2.Macerator.addRecipe(<appliedenergistics2:material:8>, <appliedenergistics2:material:7>);
mods.ic2.Macerator.addRecipe(<appliedenergistics2:material:2>, <appliedenergistics2:material:0>);
mods.ic2.Macerator.addRecipe(<appliedenergistics2:material:3>, <minecraft:quartz>);
mods.ic2.Macerator.addRecipe(<appliedenergistics2:material:45>, <appliedenergistics2:sky_stone_block>);

mods.botania.Apothecary.removeRecipe("loonium");

mods.touhoulittlemaid.Altar.removeRecipe("touhou_little_maid:craft_gashapon_machines");


function BuildTellraw (target as string, raw_json_text as string[]) {
	var c = "";
	for item in raw_json_text {
		c += ("," + item);
	}
	return "tellraw "+ target + " [\"\"" + c + "]";
}

function RunCmd (c as string) {
	server.commandManager.executeCommand(server,c);
}


events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent) {
	if (!event.player.world.remote) {
		var player = event.player;
		var name = player.name;
		RunCmd("scoreboard players add " + name + " loggedIn 1");
		// RunCmd(
		// 	"execute @a[name=" + name + ",score_loggedIn=1] ~ ~ ~ " + BuildServerChan(
		// 		"@a",
		// 		[
		// 			"{\"translate\":\"message.shw.login.newplayer.1\"}",
		// 			"{\"selector\": \"@a[name=" + name + "]\"}"
		// 		] as string[]
		// 	)
		// );
		// RunCmd(
		// 	"execute @a[name=" + name + "] ~ ~ ~ " + BuildTellraw(
		// 		name,
		// 		[
		// 			"{\"translate\":\"message.shw.login.player.1\",\"with\":[\"" + name + "\"]}",
		// 			"{\"selector\": \"@a[name=" + name + "]\"}"
		// 		] as string[]
		// 	)
		// );
		// RunCmd(
		// 	"execute @a[name=" + name + "] ~ ~ ~ " + BuildTellraw(
		// 		name,
		// 		[
		// 			"{\"translate\":\"message.shw.login.player.2\"}",
		// 			"{\"score\":{\"name\":\"" + name + "\",\"objective\":\"loggedIn\"},\"color\":\"gray\"}"
		// 		] as string[]
		// 	)
		// );
	}
});