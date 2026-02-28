return {
	"aktersnurra/no-clown-fiesta.nvim",
	priority = 1000,
	lazy = true,

	opts = {
		theme = "dark",
		lazy = true,
		styles = {
			type = { bold = true },
			lsp = { underline = false },
			match_paren = { underline = true },
		},
	},
}
