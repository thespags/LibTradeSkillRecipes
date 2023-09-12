local MAJOR = "LibTradeSkillRecipes"
local MINOR = 3
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

lib.categories = lib.categories or {}
lib.categorySpells = lib.categorySpells or {}
lib.recipes = lib.recipes or {}
lib.recipeSpells = lib.recipeSpells or {}
lib.spells = lib.spells or {}
lib.items = lib.items or {}
lib.itemSpells = lib.itemSpells or {}
lib.spellEffects = lib.spellEffects or {}
lib.effects = lib.effects or {}
lib.expansions = lib.expansions or {}
lib.expansionSpells = lib.expansionSpells or {}

---Adds the expansion a spell was added.
---@param spellId number 
---@param expansion number
function lib:AddExpansion(spellId, expansion)
    local expansions = getOrCreate(lib.expansions, expansion)
    table.insert(expansions, expansion)
    lib.expansionSpells[spellId] = expansion
end

---Adds the name of the enchantment.
---@param id number 
---@param name string
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

---Gets all the associated spells to the given expansion.
---@param expansion number
---@return table all sppells for that expansion
function lib:GetExpansionSpells(expansion)
    return lib.expansions[expansion]
end

---Gets all expansions, id to a table of all the spells
---@return table expansions to spells
function lib:GetExpansions()
    return lib.expansions
end

---Given an recipe id, returns associated information for crafting.  
---@param recipeId number  
---@return number id of the category  
---@return number expansion  
---@return table list of ids for recipes  
---@return number id of the spell to create the item or effect  
---@return number id of the item, may be nil  
---@return number id of the item if it creates a spell, may be nil  
---@return number id of the effect of the spell or item spell, may be nil  
function lib:GetInfoByRecipeId(recipeId)
    local spellId = lib.recipeSpells[recipeId]
    return lib:GetInfoBySpellId(spellId)
end

---Given an item id, returns associated information for crafting.  
---@param itemId number  
---@return number id of the category  
---@return number expansion  
---@return table list of ids for recipes  
---@return number id of the spell to create the item or effect  
---@return number id of the item, may be nil  
---@return number id of the item if it creates a spell, may be nil  
---@return number id of the effect of the spell or item spell, may be nil  
function lib:GetInfoByItemId(itemId)
    local spellId = lib.items[itemId]
    return lib:GetInfoBySpellId(spellId)
end

---Given a spellId id, returns associated information for crafting.  
---@param spellId number  
---@return number id of the category  
---@return number expansion  
---@return table list of ids for recipes  
---@return number id of the spell to create the item or effect  
---@return number id of the item, may be nil  
---@return number id of the item if it creates a spell, may be nil  
---@return number id of the effect of the spell or item spell, may be nil  
function lib:GetInfoBySpellId(spellId)
    local itemId = lib.spells[spellId]

    local category = lib.categorySpells[spellId]
    local expansion = lib.expansionSpells[spellId]
    local recipes =  lib.recipes[spellId] or {}
    local itemSpell = lib.itemSpells[itemId]
    local spellEffect = lib.spellEffects[itemSpell or spellId]
    return category, expansion, recipes, spellId, itemId, itemSpell, spellEffect
end