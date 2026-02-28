return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "▎", -- You can change this to "│" or "╎"
			tab_char = "▎",
		},
		scope = {
			enabled = true,
			show_start = false,
			show_end = false,
			highlight = { "Function", "Label" }, -- Colors the guide based on scope
		},
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
	},
}
