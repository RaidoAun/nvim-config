return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
        -- "ibhagwan/fzf-lua",              -- optional
    },
    config = function()
        local neogit = require("neogit")
        neogit.setup({})
        -- Function to log messages to a file
        local function log_message(message)
            -- local log_file = vim.fn.stdpath("data") .. "/neogit_toggle.log"
            -- local log = io.open(log_file, "a")
            -- log:write(message .. "\n")
            -- log:close()
        end
        -- Function to find git repositories in a directory
        local function find_git_repos()
            local handle = io.popen('git config --file .gitmodules --get-regexp "^submodule\\..*\\.path$"')
            if handle == nil then
                return {}
            end

            local result = handle:read("*a")
            if result == nil then
                return {}
            end
            handle:close()

            local repos = {}
            table.insert(repos, vim.fn.getcwd())

            for line in result:gmatch("[^\r\n]+") do
                local path = line:match("submodule%.(.*)%.path")
                path = vim.fn.getcwd() .. "/" .. path
                table.insert(repos, path)
            end

            return repos
        end

        -- Cache for git repositories
        local git_repos = {}
        local current_index = 1

        -- Function to initialize the git repositories cache
        local function initialize_git_repos()
            git_repos = find_git_repos()
            if #git_repos == 1 then
                log_message("No git submodules found in the current directory.")
            end
            log_message("Initialized git repositories: " .. vim.inspect(git_repos))
        end

        -- Function to toggle between git repositories
        function ToggleNeogitProject()
            if #git_repos == 0 then
                initialize_git_repos()
                if #git_repos == 1 then
                    return
                end
            end

            current_index = current_index % #git_repos + 1
            local repo_path = git_repos[current_index]
            vim.cmd("cd " .. repo_path)
            neogit.open()
            log_message("Switched to " .. repo_path)
        end

        -- Key mapping to toggle between projects
        vim.keymap.set("n", "<leader>gt", function()
            ToggleNeogitProject()
        end, { noremap = true, silent = true })

        vim.keymap.set("n", "<leader>gg", function()
            neogit.open()
        end)
    end,
}
