# LibTradeSkillRecipes

A simple aggregation of trade skill recipes. Links trade category &lt;-&gt; recipe(s) &lt;-&gt; skill spell &lt;-&gt; item &lt;-&gt; item spell &lt;-&gt; effects.

Not all item's have a spell, nor all item spells have an effect. For instance, enchantments create an effect and not item at all!
If a trade skill is taught strictly by an NPC then there is no recipe. In some versions, some trade skills have multiple recipes,
hence we use a table of recipes, although in general the result is an empty table or singleton. 

## Usage
For library usages in your TOC file:  
  * Classic: `Libs\LibTradeSkillRecipes\lib-classic.xml`  
  * TBC: `Libs\LibTradeSkillRecipes\lib-tbc.xml`  
  * Wotlk: `Libs\LibTradeSkillRecipes\lib-wotlk.xml`  
  * Retail: `Libs\LibTradeSkillRecipes\lib-retail.xml`  

Then reference via LibStub with  
`local LibTradeSkillRecipes = LibStub("LibTradeSkillRecipes")`

## API

---Gets the name of the effect.  
---@param effectId number id of the effect  
---@return string name of the effect  
**lib:GetEffect(effectId)**

---Gets all effects, id to name.  
---@return table all the effects  
**lib:GetEffects()**

---Gets all the associated spells to the given category.  
---@param categoryId number id of the category  
---@return table spell ids associated to the category  
**lib:GetCategorySpells(categoryId)**

---Gets all trade categories, id to a table of all the info.  
---@return table all the categories  
**lib:GetCategories()**

---Given an recipe id, returns associated information for crafting.  
---@param recipeId number  
---@return number id of the category  
---@return number expansion  
---@return table list of ids for recipes  
---@return number id of the spell to create the item or effect  
---@return number id of the item, may be nil  
---@return number id of the item if it creates a spell, may be nil  
---@return number id of the effect of the spell or item spell, may be nil  
**lib:GetInfoByRecipeId(recipeId)**

---Given an item id, returns associated information for crafting.  
---@param itemId number  
---@return number id of the category  
---@return number expansion  
---@return table list of ids for recipes  
---@return number id of the spell to create the item or effect  
---@return number id of the item, may be nil  
---@return number id of the item if it creates a spell, may be nil  
---@return number id of the effect of the spell or item spell, may be nil  
**lib:GetInfoByItemId(itemId)**

---Given a spellId  id, returns associated information for crafting.  
---@param spellId number  
---@return number id of the category  
---@return number expansion  
---@return table list of ids for recipes  
---@return number id of the spell to create the item or effect  
---@return number id of the item, may be nil  
---@return number id of the item if it creates a spell, may be nil  
---@return number id of the effect of the spell or item spell, may be nil  
**lib:GetInfoBySpellId(spellId)**

Note: Expansion is a value `0` to `9`, e.g. Wotlk is `2`, Retail is `9`. While versions are represented `1-10` for tables, 
Blizzard uses a 0 index for table values. Also, [Wago Db](https://wago.tools/db2/) does not have data for expansions `3-6`, so those values are `7`.

## Update
Run scripts in [WowDbScripts](https://github.com/thespags/WowDbScripts), 
then copy over any change here.

## Run Tests
Ensure you have lua installed, e.g. `brew install lua`.

Run `lua tests.lua` and look for `Tests Passed!`.

## Discord
[https://discord.gg/yY6Q6EgNRu](https://discord.gg/yY6Q6EgNRu)