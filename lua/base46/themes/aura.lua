---@type Base46Table
local M = {}

M.type = "dark"

M.base_30 = {
	white = "#edecee",
	darker_black = "#0f0e13",
	black = "#15141b", -- nvim background
	black2 = "#1c1b24",
	one_bg = "#21202e", -- popup bg, statusline bg
	one_bg2 = "#2a2838",
	one_bg3 = "#322f42",
	grey = "#6d6d6d",
	grey_fg = "#7d7d7d",
	grey_fg2 = "#8a8a8a",
	light_grey = "#9a99a3",
	red = "#ff6767",
	baby_pink = "#f694ff",
	pink = "#f694ff",
	line = "#3d375e", -- vertsplit, indent lines
	green = "#61ffca",
	vibrant_green = "#61ffca",
	nord_blue = "#82e2ff",
	blue = "#82e2ff",
	yellow = "#ffca85",
	sun = "#ffca85",
	purple = "#a277ff",
	dark_purple = "#8464c6",
	teal = "#61ffca",
	orange = "#ffca85",
	cyan = "#82e2ff",
	statusline_bg = "#1c1b24",
	lightbg = "#2a2838",
	pmenu_bg = "#a277ff",
	folder_bg = "#82e2ff",
}

M.base_16 = {
	base00 = "#15141b",
	base01 = "#1c1b24",
	base02 = "#21202e",
	base03 = "#6d6d6d",
	base04 = "#9a99a3",
	base05 = "#edecee",
	base06 = "#edecee",
	base07 = "#edecee",
	base08 = "#ff6767",
	base09 = "#ffca85",
	base0A = "#ffca85",
	base0B = "#61ffca",
	base0C = "#82e2ff",
	base0D = "#82e2ff",
	base0E = "#a277ff",
	base0F = "#f694ff",
}

M.polish_hl = {
	init = {
		Comment = { italic = true },
		["@keyword"] = { italic = true },
	},
}

return M
