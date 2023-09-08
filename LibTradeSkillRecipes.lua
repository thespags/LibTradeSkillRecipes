local MAJOR = "LibTradeSkillRecipes"
local MINOR = 1
assert(LibStub, MAJOR .. " requires LibStub")

local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then
    return
 end

local function getOrCreate(tOfT, key)
    local t = tOfT[key]
    if t == nil then
        t = {}
        tOfT[key] = t
    end
    return t
end

lib.categories = lib.cateogories or {}
lib.categorySpells = lib.categorySpells or {}
lib.recipes = lib.recipes or {}
lib.recipeSpells = lib.recipeSpells or {}
lib.spells = lib.spells or {}
lib.items = lib.items or {}
lib.itemSpells = lib.itemSpells or {}
lib.spellEffects = lib.spellEffects or {}
lib.effects = lib.effects or {}

function lib:AddEnchantment(id, name)
    lib.effects[id] = name
end

---Adds an enchantment recipe.
---@param categoryId number
---@param recipeId number|nil
---@param spellId number
---@param effectId number
function lib:AddEnchantmentRecipe(categoryId, recipeId, spellId, effectId)
    self:AddRecipe(categoryId, recipeId, spellId, nil, nil, effectId)
end

---Adds a recipe.
---@param categoryId number
---@param recipeId number|nil
---@param spellId number
---@param itemId number|nil
---@param itemSpellId number|nil
---@param effectId number|nil
function lib:AddRecipe(categoryId, recipeId, spellId, itemId, itemSpellId, effectId)
    local categories = getOrCreate(lib.categories, categoryId)
    table.insert(categories, spellId)
    lib.categorySpells[spellId] = categoryId

    if recipeId then
        local recipes = getOrCreate(lib.recipes, spellId)
        table.insert(recipes, recipeId)
        lib.recipeSpells[recipeId] = spellId
    end
    if lib.spells[spellId] then
        assert(itemId == lib.spells[spellId], "Duplicate spellId doesn't match item: " .. spellId)
    end
    lib.spells[spellId] = itemId

    if itemId then
        lib.items[itemId] = spellId

        if itemSpellId then
            if lib.itemSpells[itemId] then
                assert(lib.itemSpells[itemId] == itemSpellId, "Duplicate spellId doesn't match itemSpellId: " .. spellId)
            end
            lib.itemSpells[itemId] = itemSpellId
        end
    end

    if effectId then
        local spellEffectId = itemSpellId or spellId
        if lib.spellEffects[spellEffectId] then
            assert(lib.spellEffects[spellEffectId] == effectId, "Duplicate spellId doesn't match effectId:" .. spellId)
        end
        -- If this is an item that creates an effect (e.g. a sharpening stone).
        -- Or simply an enchantment.
        lib.spellEffects[spellEffectId] = effectId
    end
end

---Gets the name of the effect.
---@param effectId number id of the effect
---@return string name of the effect
function lib:GetEffect(effectId)
    return lib.effects[effectId]
end

---Gets all effects, id to name.
---@return table all the effects
function lib:GetEffects()
    return lib.effects
end

---Gets all the associated spells to the given category.
---@param categoryId number id of the category
---@return table spell ids associated to the category
function lib:GetCategorySpells(categoryId)
    return lib.categories[categoryId]
end

---Gets all trade categories, id to a table of all the info.
---@return table all the categories
function lib:GetCategories()
    return lib.categories
end

---Given an recipe id, returns associated information for crafting.
---@param recipeId number
---@return number id of the category
---@return table list of ids for recipes
---@return number id of the spell to create the item or effect
---@return number id of the item, may be nil
---@return number id of the item if it creates a spell, may be nil
---@return number id of the effect of the spell or item spell, may be nill
function lib:GetInfoByRecipeId(recipeId)
    local spellId = lib.recipeSpells[recipeId]
    local itemId = lib.spells[spellId]
    local itemSpell = lib.itemSpells[itemId]
    local spellEffect = lib.spellEffects[itemSpell]
    return lib.categorySpells[spellId], lib.recipes[spellId] or {}, spellId, itemId, itemSpell, spellEffect
end

---Given an item id, returns associated information for crafting.
---@param itemId number
---@return number id of the category
---@return table list of ids for recipes
---@return number id of the spell to create the item or effect
---@return number id of the item, may be nil
---@return number id of the item if it creates a spell, may be nil
---@return number id of the effect of the spell or item spell, may be nill
function lib:GetInfoByItemId(itemId)
    local spellId = lib.items[itemId]
    local itemSpell = lib.itemSpells[itemId]
    local spellEffect = lib.spellEffects[itemSpell]
    return lib.categorySpells[spellId], lib.recipes[spellId] or {}, spellId, itemId, itemSpell, spellEffect
end

---Given a spellId  id, returns associated information for crafting.
---@param spellId number
---@return number id of the category
---@return table list of ids for recipes
---@return number id of the spell to create the item or effect
---@return number id of the item, may be nil
---@return number id of the item if it creates a spell, may be nil
---@return number id of the effect of the spell or item spell, may be nill
function lib:GetInfoBySpellId(spellId)
    local itemId = lib.spells[spellId]
    local itemSpell = lib.itemSpells[itemId]
    local spellEffect = lib.spellEffects[itemSpell or spellId]
    return lib.categorySpells[spellId], lib.recipes[spellId] or {}, spellId, itemId, itemSpell, spellEffect
end