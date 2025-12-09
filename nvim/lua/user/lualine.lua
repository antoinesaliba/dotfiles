local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic", "nvim_lsp" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		return str
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local repo_name = {
	function()
		-- Use current working directory as fallback if no file is open
		local current_file = vim.fn.expand("%:p:h")
		if current_file == "" then
			current_file = vim.fn.getcwd()
		end

		local git_dir = vim.fn.finddir(".git", current_file .. ";")
		if git_dir ~= "" then
			local repo_path = vim.fn.fnamemodify(git_dir, ":h")
			-- Get the absolute path and then the tail to avoid '.' issue
			local abs_repo_path = vim.fn.fnamemodify(repo_path, ":p:h")
			local repo_name = vim.fn.fnamemodify(abs_repo_path, ":t")
			return repo_name
		end
		return ""
	end,
	cond = function()
		local current_file = vim.fn.expand("%:p:h")
		if current_file == "" then
			current_file = vim.fn.getcwd()
		end
		return vim.fn.finddir(".git", current_file .. ";") ~= ""
	end,
	color = { fg = "#000000", gui = "bold" },
}

lualine.setup({
	options = {
		globalstatus = false,
		icons_enabled = true,
		theme = "dracula",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { repo_name, diagnostics },
		lualine_b = { mode },
		lualine_c = {
			{
				"filename",
				path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
			},
		},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, branch, filetype },
		-- lualine_y = { location },
		-- lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		-- lualine_x = { location },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
