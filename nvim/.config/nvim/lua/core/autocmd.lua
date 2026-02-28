vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

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

	vim.api.nvim_set_hl(0, "User1", { fg = normal_bg, bg = color, bold = true })

	vim.api.nvim_set_hl(0, "User2", { fg = color, bg = normal_bg })

	vim.cmd("redrawstatus")
end

vim.opt.statusline = "%2*%1* %f %m %=%y %p%% %2*"

local statusline_group = vim.api.nvim_create_augroup("ModeStatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "ModeChanged", "ColorScheme" }, {
	group = statusline_group,
	callback = update_hl,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*",
	callback = function(event)
		if vim.bo[event.buf].filetype == "help" then
			vim.cmd.only()
			vim.bo[event.buf].buflisted = true
			vim.bo[event.buf].buftype = ""
			-- Keep the "help" features (like jumping to tags with Ctrl-])
			-- even though it's now a 'normal' buffer
			vim.bo[event.buf].syntax = "help"
			vim.keymap.set("n", "q", ":bd<CR>", { buffer = event.buf, silent = true })
		end
	end,
})
