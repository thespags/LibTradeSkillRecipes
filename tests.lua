debugstack = debug.traceback
strmatch = string.match

loadfile("Libs/LibStub/LibStub.lua")()
loadfile("LibTradeSkillRecipes.lua")()
loadfile("recipes/3/items.lua")()
loadfile("recipes/3/enchantments.lua")()

local LibTradeSkillRecipes = LibStub("LibTradeSkillRecipes")

local function assertEquals(expected, actual)
    if expected ~= actual then
        print(string.format("Expected %s but was %s", expected, actual))
        assert(false)
    end
end

local function assertTableEquals(expected, actual)
    expected = table.concat(expected)
    actual = table.concat(actual)
    assertEquals(expected, actual)
end

-- lib:AddRecipe(165, 2406, 2158, 2307, nil, nil) -- 1359 Fine Leather Boots
local category, recipes, spell, item, itemSpell, effect = LibTradeSkillRecipes:GetInfoByRecipeId(2406)
assertEquals(165, category)
assertTableEquals({2406}, recipes)
assertEquals(2158, spell)
assertEquals(2307, item)
assertEquals(nil, itemSpell)
assertEquals(nil, effect)

-- lib:AddRecipe(165, nil, 2152, 2304, 2831, 15) -- 1356 Light Armor Kit
category, recipes, spell, item, itemSpell, effect = LibTradeSkillRecipes:GetInfoByItemId(2304)
assertEquals(165, category)
assertTableEquals({}, recipes)
assertEquals(2152, spell)
assertEquals(2304, item)
assertEquals(2831, itemSpell)
assertEquals(15, effect)

-- lib:AddRecipe(165, nil, 2153, 2303, nil, nil) -- 1355 Handstitched Leather Pants
category, recipes, spell, item, itemSpell, effect = LibTradeSkillRecipes:GetInfoBySpellId(2153)
assertEquals(165, category)
assertTableEquals({}, recipes)
assertEquals(2153, spell)
assertEquals(2303, item)
assertEquals(nil, itemSpell)
assertEquals(nil, effect)

-- lib:AddRecipe(333, 11813, 15596, 11811, nil, nil) -- 8440 Smoking Heart of the Mountain
-- lib:AddRecipe(333, 45050, 15596, 11811, nil, nil) -- 8440 Smoking Heart of the Mountain
category, recipes, spell, item, itemSpell, effect = LibTradeSkillRecipes:GetInfoBySpellId(15596)
assertEquals(333, category)
assertTableEquals({11813, 45050}, recipes)
assertEquals(15596, spell)
assertEquals(11811, item)
assertEquals(nil, itemSpell)
assertEquals(nil, effect)

-- lib:AddEnchantmentRecipe(333, 16214, 20008, 1883) -- 11373 Enchant Bracer - Greater Intellect
category, recipes, spell, item, itemSpell, effect = LibTradeSkillRecipes:GetInfoBySpellId(20008)
assertEquals(333, category)
assertTableEquals({16214}, recipes)
assertEquals(20008, spell)
assertEquals(nil, item)
assertEquals(nil, itemSpell)
assertEquals(1883, effect)

local effectName = LibTradeSkillRecipes:GetEffect(15)
assertEquals("Reinforced (+8 Armor)", effectName)

local effects = LibTradeSkillRecipes:GetEffects()
assert(effects ~= nil)

local categorySpells = LibTradeSkillRecipes:GetCategorySpells(165)
assert(categorySpells ~= nil)

local categories = LibTradeSkillRecipes:GetCategories()
assert(categories ~= nil)

print("Tests Passed!")