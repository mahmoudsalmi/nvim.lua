local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require "telescope.config".values

--- Telescope extension for live multi-grep
--- This extension provides a way to search for a pattern in the current working directory
--- using ripgrep. The search is live, meaning that the results are updated as you type.
--- The search results are displayed in a floating window.
local M = {}

--- Live grep options
-- @type LiveGrepOpts
-- @field[opt] cwd string: The current working directory

--- Search for a pattern in the current working directory\
-- @param[opt] opts LiveGrepOpts: Options for the search
local live_mutligrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end

      local pieces = vim.split(prompt, "  ")
      print("pieces", pieces)
      local args = { "rg" }
      if pieces[1] then
        print("pieces[1]", pieces[1])
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        print("pieces[2]", pieces[2])
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end

      return vim.list_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--follow" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Multi Grep",
    finder = finder,
    previewer = conf.grep_previewer(opts),
    sorter = require("telescope.sorters").empty(),
  }):find()
end

--- Setup the live multi-grep keymap
M.setup = function()
  vim.keymap.set("n", "<leader>fg", live_mutligrep)
end

return M
