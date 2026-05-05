return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      html = { enabled = false },
      latex = { enabled = false },
      yaml = { enabled = false },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    build = function() vim.fn["mkdp#util#install"]() end,
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 1 -- Automatically launch preview
      vim.g.mkdp_preview_options = {
        mermaid = { enabled = true } -- Enable Mermaid rendering
      }
    end
  }
}
