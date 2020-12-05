import crafttweaker.data.IData;
import crafttweaker.game.IGame;
import crafttweaker.item.IIngredient;
import crafttweaker.item.IItemStack;
import crafttweaker.oredict.IOreDictEntry;

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
			.marked("mark")
	],
	function(out,ins,cInfo){
		val info = ins.mark.tag.info;
		return out.updateTag(info - "items" + {type: 0}).withLore([
				"Name: "+info.name,
				"UUID: "+info.uuid,
				"Pos: "+"("+info.pos_x+","+info.pos_y+","+info.pos_z+","+info.dim+")",
				"Time: "+info.time
			]);
	},
	null
);

recipes.addShaped(
	"ench_tditp_1",
	<contenttweaker:death_teleporter>,
	[
		[null, <ore:enderpearl>, null],
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
		[null, <ore:enderpearl>, null],
	],
	function(out,ins,cInfo){
		val data = ins.mark.tag;
		return out.updateTag(data + {ench: [{lvl: 0 as short, id: -1 as short}], type: 1} as IData).withLore(["§7Upgrade: Ender pearl"]);
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
				if (!(item.tag has "ench") && (item.tag has "type") && (item.tag.type == 0)) {
					return true;
				}
				return false;
			})
			.marked("mark"),
	],
	function(out,ins,cInfo){
		val data = ins.mark.tag;
		return out.updateTag(data + {ench: [{lvl: 0 as short, id: -1 as short}], type: 3} as IData).withLore(["§7Upgrade: Golden apple x2"]);
	},
	null
);

recipes.addShapeless(
	"ench_tditp_3",
	<contenttweaker:death_teleporter>,
	[
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
		return out.updateTag(data + {type: 2} as IData).withLore(["§7Upgrade: Golden apple"]);
	},
	null
);


// =================================================================//
//                       vanilla modification                       //
// =================================================================//

recipes.addShaped(
	"redstone_repeater",
	<minecraft:repeater>,
	[
		[<ore:dustRedstone>, null, <ore:dustRedstone>],
		[<ore:stickWood>, <ore:dustRedstone>, <ore:stickWood>],
		[<ore:stone>, <ore:stone>, <ore:stone>],
	]
);

recipes.addShaped(
	"chest_minecart",
	<minecraft:chest_minecart>,
	[
		[null, null, null],
		[<ore:ingotIron>, <ore:chestWood>, <ore:ingotIron>],
		[<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>],
	]
);

recipes.addShaped(
	"furnace_minecart",
	<minecraft:furnace_minecart>,
	[
		[null, null, null],
		[<ore:ingotIron>, <minecraft:furnace>, <ore:ingotIron>],
		[<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>],
	]
);

recipes.addShaped(
	"hopper_minecart",
	<minecraft:hopper_minecart>,
	[
		[null, null, null],
		[<ore:ingotIron>, <minecraft:hopper>, <ore:ingotIron>],
		[<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>],
	]
);

recipes.addShaped(
	"tnt_minecart",
	<minecraft:tnt_minecart>,
	[
		[null, null, null],
		[<ore:ingotIron>, <minecraft:tnt>, <ore:ingotIron>],
		[<ore:ingotIron>, <ore:ingotIron>, <ore:ingotIron>],
	]
);


val blockwool = {
	<minecraft:wool:0>: <ore:dyeWhite>,
	<minecraft:wool:1>: <ore:dyeOrange>,
	<minecraft:wool:2>: <ore:dyeMagenta>,
	<minecraft:wool:3>: <ore:dyeLight_blue>,
	<minecraft:wool:4>: <ore:dyeYellow>,
	<minecraft:wool:5>: <ore:dyeLime>,
	<minecraft:wool:6>: <ore:dyePink>,
	<minecraft:wool:7>: <ore:dyeGray>,
	<minecraft:wool:8>: <ore:dyeLightGray>,
	<minecraft:wool:9>: <ore:dyeCyan>,
	<minecraft:wool:10>: <ore:dyePurple>,
	<minecraft:wool:11>: <ore:dyeBlue>,
	<minecraft:wool:12>: <ore:dyeBrown>,
	<minecraft:wool:13>: <ore:dyeGreen>,
	<minecraft:wool:14>: <ore:dyeRed>,
	<minecraft:wool:15>: <ore:dyeBlack>
} as IOreDictEntry[IItemStack];
for key, value in blockwool {
	recipes.addShapeless(key, [value, <ore:wool>]);
}
for key, value in blockwool {
	recipes.addShapeless(key*8, [<ore:wool>, <ore:wool>, <ore:wool>, <ore:wool>, value, <ore:wool>, <ore:wool>, <ore:wool>, <ore:wool>]);
}
