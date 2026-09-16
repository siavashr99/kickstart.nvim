-- Harpoon: quickly mark and jump between files
-- https://github.com/ThePrimeagen/harpoon

local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'
harpoon:setup()

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set('n', '<C-h>', function() harpoon:list():select(1) end, { desc = 'Harpoon to file 1' })
vim.keymap.set('n', '<C-t>', function() harpoon:list():select(2) end, { desc = 'Harpoon to file 2' })
vim.keymap.set('n', '<C-n>', function() harpoon:list():select(3) end, { desc = 'Harpoon to file 3' })
vim.keymap.set('n', '<C-s>', function() harpoon:list():select(4) end, { desc = 'Harpoon to file 4' })
