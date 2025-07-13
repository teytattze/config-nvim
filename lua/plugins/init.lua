return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
    },
  },

  {
    "mfussenegger/nvim-dap",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      require("configs.lspconfig-java").setup()
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = require("configs.nvimtree").opts,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require("configs.treesitter").opts,
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    config = require("configs.nvim-dap-ui").config,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
  },

  {
    "stevearc/conform.nvim",
    opts = require("configs.conform").opts,
  },

  {
    "williamboman/mason.nvim",
    opts = require("configs.mason").opts,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
