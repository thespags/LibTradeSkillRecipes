debugstack = debug.traceback
strmatch = string.match

loadfile("Libs/LibStub/LibStub.lua")()
loadfile("LibTradeSkillRecipes.lua")()
loadfile("recipes/expansions.lua")()
loadfile("recipes/10/items.lua")()
loadfile("recipes/10/enchantments.lua")()

local LibTradeSkillRecipes = LibStub("LibTradeSkillRecipes")

assert(LibTradeSkillRecipes)
print("Tests Passed!")