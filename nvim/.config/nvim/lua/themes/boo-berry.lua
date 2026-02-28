return {
	"mrpbennett/boo-berry.nvim",
	lazy = true,
	priority = 1000,

	opts = {
		-- Set italic comments
		italic_comment = true, -- default: false

		-- Use transparent background
		transparent_bg = true, -- default: false

		-- Show '~' after end of buffer
		show_end_of_buffer = false, -- default: false

		-- Custom lualine background
		lualine_bg_color = nil, -- default: nil (uses berry_dim)

		-- Override any palette colour
		colors = {
			-- bg = "#3A2A4D",
			-- ... see lua/boo-berry/palette.lua for all keys
		},

		overrides = function(colors)
			return {
				-- Normal = { fg = colors.fg },
				TelescopeNormal = { bg = "none" },
				TelescopePromptNormal = { bg = "none" },
				TelescopeResultsNormal = { bg = "none" },
				TelescopePreviewNormal = { bg = "none" },
				-- Borders (Setting bg to none makes them transparent)
				TelescopeBorder = { bg = "none" },
				TelescopeResultsBorder = { bg = "none" },
				TelescopePreviewBorder = { bg = "none" },
				-- Matching the Prompt Border to the Preview Border
				TelescopePromptBorder = { fg = colors.purple, bg = "none" },
			}
		end,
	},
}
