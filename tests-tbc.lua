debugstack = debug.traceback
strmatch = string.match

loadfile("Libs/LibStub/LibStub.lua")()
loadfile("LibTradeSkillRecipes.lua")()
loadfile("recipes/expansions.lua")()
loadfile("recipes/2/items.lua")()
loadfile("recipes/2/enchantments.lua")()

local LibTradeSkillRecipes = LibStub("LibTradeSkillRecipes-1")

assert(LibTradeSkillRecipes)
print("Tests Passed!")