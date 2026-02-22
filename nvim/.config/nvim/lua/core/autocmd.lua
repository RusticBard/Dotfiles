-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- MUST HAVE THIS for Hex colors to work
vim.opt.termguicolors = true

local function get_theme_color(group, attr)
	local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
	local color = hl[attr]
	return color and string.format("#%06x", color) or nil
end

local function update_hl()
	local mode = vim.fn.mode()
	local normal_bg = get_theme_color("Normal", "bg") or "#1e1e1e"

	local mode_colors = {
		n = get_theme_color("Function", "fg") or "#81a1c1",
		i = get_theme_color("String", "fg") or "#a3be8c",
		v = get_theme_color("Statement", "fg") or "#b48ead",
		V = get_theme_color("Statement", "fg") or "#b48ead",
		["\22"] = get_theme_color("Statement", "fg") or "#b48ead",
		R = get_theme_color("ErrorMsg", "fg") or "#bf616a",
	}

	local color = mode_colors[mode] or mode_colors["n"]

	-- Define the custom User highlight groups
	-- User1: The main bar (Text is Dark, Background is Mode Color)
	vim.api.nvim_set_hl(0, "User1", { fg = normal_bg, bg = color, bold = true })

	-- User2: The Caps (Text is Mode Color, Background is Editor Dark)
	vim.api.nvim_set_hl(0, "User2", { fg = color, bg = normal_bg })

	-- Force the UI to refresh the statusline immediately
	vim.cmd("redrawstatus")
end

-- Define the actual statusline string using the User groups
-- %2* = User2 (Caps), %1* = User1 (Body)
vim.opt.statusline = "%2*%1* %f %m %=%y %p%% %2*"

local statusline_group = vim.api.nvim_create_augroup("ModeStatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "ModeChanged", "ColorScheme" }, {
	group = statusline_group,
	callback = update_hl,
})
