-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "gruvbox",
	transparency = true,
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
	hl_override = {
		["@comment"] = { italic = true, bold = true },
		["@keyword"] = { italic = true, bold = true },
		["@function"] = { italic = true },
		["@parameter"] = { italic = true },
		["@conditional"] = { italic = true },
	},
}

M.ui = {
	tabufline = {
		enabled = false,
	},
	statusline = {
		theme = "default",
		separator_style = "round",
	},
	cmp = {
		style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
		icons_left = true,
	},
}

M.nvdash = {
	load_on_startup = true,
	header = {
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠞⢳⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠋⠀⢰⠎⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢆⣤⡞⠃⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢠⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀",
		"⠀⠀⠀⠀⢀⣀⣾⢳⠀⠀⠀⠀⢸⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
		"⣀⡤⠴⠊⠉⠀⠀⠈⠳⡀⠀⠀⠘⢎⠢⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀",
		"⠳⣄⠀⠀⡠⡤⡀⠀⠘⣇⡀⠀⠀⠀⠉⠓⠒⠺⠭⢵⣦⡀⠀⠀⠀",
		"⠀⢹⡆⠀⢷⡇⠁⠀⠀⣸⠇⠀⠀⠀⠀⠀⢠⢤⠀⠀⠘⢷⣆⡀⠀",
		"⠀⠀⠘⠒⢤⡄⠖⢾⣭⣤⣄⠀⡔⢢⠀⡀⠎⣸⠀⠀⠀⠀⠹⣿⡀",
		"⠀⠀⢀⡤⠜⠃⠀⠀⠘⠛⣿⢸⠀⡼⢠⠃⣤⡟⠀⠀⠀⠀⠀⣿⡇",
		"⠀⠀⠸⠶⠖⢏⠀⠀⢀⡤⠤⠇⣴⠏⡾⢱⡏⠁⠀⠀⠀⠀⢠⣿⠃",
		"⠀⠀⠀⠀⠀⠈⣇⡀⠿⠀⠀⠀⡽⣰⢶⡼⠇⠀⠀⠀⠀⣠⣿⠟⠀",
		"⠀⠀⠀⠀⠀⠀⠈⠳⢤⣀⡶⠤⣷⣅⡀⠀⠀⠀⣀⡠⢔⠕⠁⠀⠀",
		"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠫⠿⠿⠿⠛⠋⠁⠀⠀⠀⠀",
	},
	buttons = (function()
		local is_nixcats = false
		pcall(function()
			is_nixcats = require("nixCatsUtils").isNixCats == true
		end)

		local btns = {
			{ txt = "󰈞  Find File", keys = "f", cmd = "lua Snacks.dashboard.pick('smart')" },
			{ txt = "  Recent Files", keys = "r", cmd = "lua Snacks.dashboard.pick('oldfiles')" },
		}

		if is_nixcats then
			table.insert(btns, { txt = "  Dotfiles Folder", keys = "c", cmd = "tcd $HOME/dotfiles/ | e ." })
			table.insert(btns, { txt = "  Settings", keys = "s", cmd = "tcd $HOME/.config/nvim/ | e ." })
		end

		table.insert(btns, { txt = "  Project Folder", keys = "p", cmd = "tcd $HOME/Workspace/Projects/ | e ." })

		if not is_nixcats then
			table.insert(btns, { txt = "  Settings", keys = "s", cmd = "e $MYVIMRC | tcd %:p:h" })
		end

		table.insert(btns, { txt = "󰒲  Lazy", keys = "L", cmd = "Lazy" })
		table.insert(btns, { txt = "  Quit", keys = "q", cmd = "qa" })

		return btns
	end)(),
}

return M
