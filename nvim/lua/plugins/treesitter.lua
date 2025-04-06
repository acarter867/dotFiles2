return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "javascript", "tsx", "typescript" },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
                autotag = {
                    enable = true,
                },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        dependencies = "nvim-treesitter/nvim-treesitter",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
}
