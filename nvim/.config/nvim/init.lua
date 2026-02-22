require("core.options")
require("core.keymaps")
require("core.autocmd")
require("config.lazy")

local theme_cache = vim.fn.stdpath("data") .. "/last_theme.txt"

do
	local theme_file = io.open(theme_cache, "r")
	if theme_file then
		local saved_theme = theme_file:read("*all"):gsub("%s+", "")
		theme_file:close()
		pcall(vim.cmd.colorscheme, saved_theme)
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("SaveTheme", { clear = true }),
	callback = function(args)
		if args.match ~= "" then
			local theme_file = io.open(theme_cache, "w")
			if theme_file then
				theme_file:write(args.match)
				theme_file:close()
			end
		end
	end,
})
