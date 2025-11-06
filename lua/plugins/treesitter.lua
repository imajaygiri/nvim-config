return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "HiPhish/rainbow-delimiters.nvim",
    },
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            auto_install = true,
            ensure_installed = { "cmake" ,"c", "lua", "cpp", "html", "css", "javascript","tsx" , "typescript"},
            highlight = { enable = true },
            indent = { enable = true },
            rainbow = {
                enable = true,
                extended_mode = true, -- Highlight non-bracket delimiters like tags
                max_file_lines = nil, -- No file size limit
            },
        })
    end,
}
