return {
	"nvim-telescope/telescope.nvim",
	lazy = true,
	-- Stay lazy!
	cmd = "Telescope",
	keys = {
		{ "<leader>?", "<cmd>Telescope oldfiles<cr>", desc = "[?] Find recently opened files" },
		{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "[ ] Find existing buffers" },
		{
			"<leader>/",
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			desc = "[/] Fuzzily search in current buffer",
		},
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "[s]earch [f]iles" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[s]earch [h]elp" },
		{ "<leader>sg", "<cmd>Telescope grep_string<cr>", desc = "[s]earch current [w]ord" },
		{ "<leader>s.", "<cmd>Telescope live_grep<cr>", desc = "[s]earch by [g]rep" },
		{ "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "[s]earch [d]iagnostics" },
		{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "[s]earch [k]eymaps" },
		{
			"<leader>sc",
			"<cmd>Telescope find_files hidden=true no_ignore=false cwd=~/.dotfiles<cr>",
			desc = "[s]earch [c]onfig",
		},
		{ "<leader>sw", "<cmd>Telescope find_files cwd=~/Others/Workspace<cr>", desc = "[S]earch [W]orkspace" },
		{ "<leader>so", "<cmd>Telescope oldfiles<cr>", desc = "[s]earch [o]ldfiles" },
		{ "<leader>shl", "<cmd>Telescope highlights<cr>", desc = "[s]earch telescope [h]igh[l]ights" },
		{
			"<leader>st",
			function()
				require("telescope.builtin").colorscheme({ ignore_builtins = true })
			end,
			desc = "Telescope colorschemes",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-ui-select.nvim",
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	-- Use 'opts' for your specific data and layout
	opts = {
		defaults = {
			prompt_prefix = "   ",
			selection_caret = "▶ ",
			sorting_strategy = "ascending",
			layout_config = {
				prompt_position = "top",
				horizontal = {
					height = 0.99,
					width = 0.99,
					preview_width = 0.5,
				},
			},
			mappings = {
				i = {
					-- Wrapped in a function so it doesn't load Telescope on startup
					["<esc>"] = function(...)
						return require("telescope.actions").close(...)
					end,
				},
			},
		},
		pickers = {
			current_buffer_fuzzy_find = {
				theme = "dropdown",
				previewer = false,
				layout_config = { height = 0.9, width = 0.8 },
			},
			buffers = {
				theme = "dropdown",
				previewer = false,
				layout_config = { height = 0.8, width = 0.8 },
			},
			colorscheme = {
				enable_preview = true,
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	},
	-- Keep this 'config' ONLY to run the mechanical load_extension calls.
	-- Without this, your fzf and ui-select will be installed but disabled.
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "ui-select")
	end,
}
