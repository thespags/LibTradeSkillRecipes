# LibTradeSkillRecipes

A simple aggregation of trade skill recipes. Links trade category <-> recipe(s) <-> skill spell <-> item <-> item spell <-> effects.

Not all item's have a spell, nor all item spells have an effect. For instance, enchantments create an effect and not item at all!
If a trade skill is taught strictly by an NPC then there is no recipe. In some versions, some trade skills have multiple recipes,
hence we use a table of recipes, although in general the result is an empty table or singleton. 

## API

```

---Gets the name of the effect.
---@param effectId number id of the effect
---@return string name of the effect
function lib:GetEffect(effectId)

---Gets all effects, id to name.
---@return table all the effects
function lib:GetEffects()

---Gets all the associated spells to the given category.
---@param categoryId number id of the category
---@return table spell ids associated to the category
function lib:GetCategorySpells(categoryId)

---Gets all trade categories, id to a table of all the info.
---@return table all the categories
function lib:GetCategories()

---Given an recipe id, returns associated information for crafting.
---@param recipeId number
---@return number id of the category
---@return table list of ids for recipes
---@return number id of the spell to create the item or effect
---@return number id of the item, may be nil
---@return number id of the item if it creates a spell, may be nil
---@return number id of the effect of the spell or item spell, may be nill
lib:GetInfoByRecipeId(recipeId)

---Given an item id, returns associated information for crafting.
---@param itemId number
---@return number id of the category
---@return table list of ids for recipes
---@return number id of the spell to create the item or effect
---@return number id of the item, may be nil
---@return number id of the item if it creates a spell, may be nil
---@return number id of the effect of the spell or item spell, may be nill
function lib:GetInfoByItemId(itemId)

---Given a spellId  id, returns associated information for crafting.
---@param spellId number
---@return number id of the category
---@return table list of ids for recipes
---@return number id of the spell to create the item or effect
---@return number id of the item, may be nil
---@return number id of the item if it creates a spell, may be nil
---@return number id of the effect of the spell or item spell, may be nill
function lib:GetInfoBySpellId(spellId)
```

## Update
Run scripts in [WowDbScripts](https://github.com/thespags/WowDbScripts), 
then copy over any change here.

## Run Tests
Ensure you have lua installed, e.g. `brew install lua`.

Run `lua tests.lua` and look for `Tests Passed!`.
