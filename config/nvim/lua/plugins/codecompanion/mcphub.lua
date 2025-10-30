require("mcphub").setup({
  extensions = {
    codecompanion = {
      -- Show the mcp tool result in the chat buffer
      show_result_in_chat = true,
      -- Make chat #variables from MCP server resources
      make_vars = true,
    }
  }
})

require("codecompanion").setup({
  strategies = {
    chat = {
      tools = {
        ["mcp"] = {
          -- Prevent mcphub from loading before needed
          callback = function()
            return require("mcphub.extensions.codecompanion")
          end,
          description = "Call tools and resources from the MCP Servers",
          opts = {
            requires_approval = true,
          }
        }
      }
    }
  }
})
