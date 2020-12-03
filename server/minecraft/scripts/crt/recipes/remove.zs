import crafttweaker.item.IIngredient;

val removeItemArray = [
	<tconstruct:throwball:*>,
	<thermalexpansion:augment:336>,
	<randomthings:diviningrod:*>,
	<randomthings:spectrekey>,
	<randomthings:spectreanchor>,
	<randomthings:spectresword>,
	<randomthings:spectrepickaxe>,
	<randomthings:spectreaxe>,
	<randomthings:spectreshovel>,
	<randomthings:spectrecoil_redstone>,
	<randomthings:spectrecoil_ender>,
	<randomthings:spectrecoil_number>,
	<randomthings:spectreilluminator>,
	<randomthings:chunkanalyzer>,
	<cfm:item_crow_bar>,
	<cfm:tv>,
	<cfm:printer>,
	<cfm:mirror>,
	<cfm:modern_tv>,
	<cfm:washing_machine>
] as IIngredient[];
for item in removeItemArray{
	recipes.remove(item);
}

recipes.removeByMod("chiselsandbits");