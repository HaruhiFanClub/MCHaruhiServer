import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import mods.inworldcrafting.FluidToItem;

val arms = [
	<minecraft:iron_sword>,
	<minecraft:wooden_sword>,
	<minecraft:stone_sword>,
	<minecraft:diamond_sword>,
	<minecraft:golden_sword>,
	<bewitchment:silver_sword>,
	<bewitchment:cold_iron_sword>,
	<cfm:item_knife>,
	<randomthings:spectresword>,
	<thermalfoundation:tool.sword_copper>,
	<thermalfoundation:tool.sword_tin>,
	<thermalfoundation:tool.sword_silver>,
	<thermalfoundation:tool.sword_lead>,
	<thermalfoundation:tool.sword_aluminum>,
	<thermalfoundation:tool.sword_nickel>,
	<thermalfoundation:tool.sword_platinum>,
	<thermalfoundation:tool.sword_steel>,
	<thermalfoundation:tool.sword_electrum>,
	<thermalfoundation:tool.sword_invar>,
	<thermalfoundation:tool.sword_bronze>,
	<thermalfoundation:tool.sword_constantan>,
	<atum:stoneguard_greatsword>,
	<atum:limestone_sword>,
	<atum:iron_dagger>,
	<atum:dagger_poison>,
	<atum:iron_scimitar>,
	<atum:iron_greatsword>,
	<atum:iron_club>,
	<cqrepoured:dagger_diamond>,
	<cqrepoured:dagger_ninja>,
	<cqrepoured:dagger_monking>,
	<cqrepoured:sword_turtle>,
	<cqrepoured:sword_spider>,
	<cqrepoured:sword_moonlight>,
	<cqrepoured:sword_sunshine>,
	<cqrepoured:battle_axe_bull>,
	<cqrepoured:sword_walker>,
	<cqrepoured:great_sword_iron>,
	<cqrepoured:great_sword_diamond>,
	<cqrepoured:great_sword_bull>,
	<cqrepoured:great_sword_monking>,
	<cqrepoured:dagger_iron>
] as IItemStack[];
for item in arms {
	FluidToItem.transform(item.withTag({ench: [{lvl: 13 as short, id: 17 as short}]} as IData), <liquid:holy_water>, [item], true);
}