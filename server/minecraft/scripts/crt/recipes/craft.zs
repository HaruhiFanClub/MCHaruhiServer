import crafttweaker.data.IData;
import crafttweaker.game.IGame;

recipes.addShapeless(<minecraft:nether_star>*9, [<contenttweaker:netherstar_block>]);
recipes.addShapeless(<contenttweaker:netherstar_block>*9, [<contenttweaker:compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:compressed_netherstar_block>*9, [<contenttweaker:double_compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:double_compressed_netherstar_block>*9, [<contenttweaker:triple_compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:triple_compressed_netherstar_block>*9, [<contenttweaker:quadruple_compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:quadruple_compressed_netherstar_block>*9, [<contenttweaker:quintuple_compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:quintuple_compressed_netherstar_block>*9, [<contenttweaker:sextuple_compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:sextuple_compressed_netherstar_block>*9, [<contenttweaker:septuple_compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:septuple_compressed_netherstar_block>*9, [<contenttweaker:eightfold_compressed_netherstar_block>]);
recipes.addShapeless(<contenttweaker:eightfold_compressed_netherstar_block>*9, [<contenttweaker:ninefold_compressed_netherstar_block>]);

recipes.remove(<ic2:mining_laser>);
recipes.addShaped(
	<contenttweaker:crafting_mining_laser>,
	[
		[<ore:dustRedstone>, <ore:dustRedstone>, <ore:energyCrystal>],
		[<ore:plateAdvancedAlloy>, <ore:plateAdvancedAlloy>, <ore:circuitAdvanced>],
		[null, <ore:plateAdvancedAlloy>, <ore:plateAdvancedAlloy>]
	]
);

recipes.remove(<ic2:te:52>);
recipes.addShaped(
	<ic2:te:52>, 
	[
		[<ic2:crafting:5>, <contenttweaker:crafting_mining_laser>, <ic2:crafting:5>],
		[<ore:ingotIron>, <ore:machineBlockAdvanced>, <ore:ingotIron>],
		[<ore:ingotIron>, <ic2:crafting:6>, <ore:ingotIron>]
	]
);

recipes.remove(<ic2:te:57>);
recipes.addShaped(
	<ic2:te:57>, 
	[
		[<ore:plateAdvancedAlloy>, <contenttweaker:crafting_mining_laser>, <ore:plateAdvancedAlloy>],
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
		[<contenttweaker:crafting_mining_laser>, <ore:circuitAdvanced>, <contenttweaker:crafting_mining_laser>]
	]
);

recipes.addShaped(
	<contenttweaker:empty_drinking_water_tank>,
	[
		[<ore:plateTin>, <toughasnails:canteen>, <ore:plateTin>],
		[<ore:plateTin>, <ic2:te:133>, <ore:plateTin>],
		[<ore:plateTin>, <ore:blockGlass>, <ore:plateTin>]
	]
);

//<gravestone:death_info>a.withTag({info: {pos_y: 68, pos_z: 178, pos_x: -210, name: "WakelessSloth56", dim: 0, time: 1605368772924 as long, uuid: "2845a52b-eb23-4b52-9f81-f0f0b5755391", items: []}})

recipes.addShapeless(
	"tditp",
	<contenttweaker:death_teleporter>,
	[
		<gravestone:death_info>
			.only(function (item) {
				if ((item.tag has "info") && !(item.tag has "transformed")) {
					return true;
				}
				return false;
			})
			.transformNew(function (item) {
				return item
					.updateTag(item.tag+{"transformed":1})
					.withLore([game.localize("item.gravestone.death_info.lore.1")+game.localize("item.contenttweaker.death_teleporter.name")]);
			})
			.marked("mark")
	],
	function(out,ins,cInfo){
		val info = ins.mark.tag.info;
		return out.updateTag(info - "items" + {type: 0}).withLore([
				game.localize("item.contenttweaker.death_teleporter.lore.1")+info.name,
				game.localize("item.contenttweaker.death_teleporter.lore.2")+info.uuid,
				game.localize("item.contenttweaker.death_teleporter.lore.3")+"("+info.pos_x+","+info.pos_y+","+info.pos_z+","+info.dim+")",
				game.localize("item.contenttweaker.death_teleporter.lore.4")+info.time
			]);
	},
	null
);

recipes.addShaped(
	"ench_tditp_1",
	<contenttweaker:death_teleporter>,
	[
		[<ore:enderpearl>,<ore:enderpearl>,<ore:enderpearl>],
		[
			<ore:enderpearl>,
			<contenttweaker:death_teleporter>
				.only(function (item) {
					if (!(item.tag has "ench") && (item.tag has "type") && (item.tag.type == 0)) {
						return true;
					}
					return false;
				})
				.marked("mark"),
			<ore:enderpearl>
		],
		[<ore:enderpearl>,<ore:enderpearl>,<ore:enderpearl>],
	],
	function(out,ins,cInfo){
		val data = ins.mark.tag;
		return out.updateTag(data + {ench: [{lvl: 0 as short, id: -1 as short}], type: 1} as IData).withDisplayName("§b" + game.localize("item.contenttweaker.death_teleporter.name"));
	},
	null
);

recipes.addShapeless(
	"ench_tditp_2",
	<contenttweaker:death_teleporter>,
	[
		<minecraft:golden_apple>,
		<minecraft:golden_apple>,
		<contenttweaker:death_teleporter>
			.only(function (item) {
				if ((item.tag has "ench") && (item.tag has "type") && (item.tag.type == 1)) {
					return true;
				}
				return false;
			})
			.marked("mark")
	],
	function(out,ins,cInfo){
		val data = ins.mark.tag;
		return out.updateTag(data + {type: 2} as IData).withDisplayName("§e" + game.localize("item.contenttweaker.death_teleporter.name"));
	},
	null
);