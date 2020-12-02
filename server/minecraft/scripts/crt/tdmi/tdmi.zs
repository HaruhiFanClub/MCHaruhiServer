#priority 2

import crafttweaker.item.IItemStack;
import crafttweaker.game.IGame;
import mods.jei.JEI.addDescription;

// mods.jei.JEI.addDescription(<contenttweaker:crafting_mining_laser>, game.localize("item.contenttweaker.crafting_mining_laser.message"));
// <contenttweaker:crafting_mining_laser>.addTooltip(game.localize("item.contenttweaker.crafting_mining_laser.tooltips"));
// mods.jei.JEI.addDescription(<ic2:mining_laser>, game.localize("item.ic2.mining_laser.jei.description"));

addDescription(<contenttweaker:death_teleporter>, game.localize("item.contenttweaker.death_teleporter.jei.description"));

// <contenttweaker:death_teleporter>.addTooltip(game.localize("item.contenttweaker.death_teleporter.tooltips.1"));
// <contenttweaker:death_teleporter>.addTooltip(game.localize("item.contenttweaker.death_teleporter.tooltips.2"));
// <contenttweaker:death_teleporter>.addTooltip(game.localize("item.contenttweaker.death_teleporter.tooltips.3"));
// <contenttweaker:death_teleporter>.addTooltip(game.localize("item.contenttweaker.death_teleporter.tooltips.4"));

// <gravestone:death_info>.addTooltip(game.localize("item.gravestone.death_info.tooltips.1")+game.localize("item.contenttweaker.death_teleporter.name"));


val netherstar_blocks = [<contenttweaker:netherstar_block>,
	<contenttweaker:compressed_netherstar_block>,
	<contenttweaker:double_compressed_netherstar_block>,
	<contenttweaker:triple_compressed_netherstar_block>,
	<contenttweaker:quadruple_compressed_netherstar_block>,
	<contenttweaker:quintuple_compressed_netherstar_block>,
	<contenttweaker:sextuple_compressed_netherstar_block>,
	<contenttweaker:septuple_compressed_netherstar_block>,
	<contenttweaker:eightfold_compressed_netherstar_block>,
	<contenttweaker:ninefold_compressed_netherstar_block>
] as IItemStack[];
for index,item in netherstar_blocks {
	item.addTooltip(game.localize("tile.contenttweaker.netherstar_block.tooltips")+(pow(9,(index + 1)) as long));
}
