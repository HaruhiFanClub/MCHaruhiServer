import mods.touhoulittlemaid.Altar;

Altar.removeRecipe("touhou_little_maid:spawn_maid");
Altar.addMaidSpawnCraftRecipe(
	"touhou_little_maid:spawn_maid", 1.0,
	<contenttweaker:nijigen_crystal>, <minecraft:iron_block>, <minecraft:gold_block>, <minecraft:lapis_block>, <minecraft:coal_block>, <minecraft:redstone_block>
);

Altar.removeRecipe("touhou_little_maid:craft_gashapon_machines");
