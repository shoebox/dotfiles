local vim = vim

local colorizeCmpItem = function(group, hl, revert)
  revert = revert or true
  local fn = vim.fn
  local bg = fn.synIDattr(fn.synIDtrans(fn.hlID(hl)), "bg#")
  local fg = fn.synIDattr(fn.synIDtrans(fn.hlID(hl)), "fg#")

  vim.api.nvim_set_hl(0, group, {
    fg = revert and bg or fg,
    bg = revert and fg or bg,
  })
end

local function colorizeCmpItems()
  colorizeCmpItem("CmpItemKindField", "@variable.member")
  colorizeCmpItem("CmpItemKindProperty", "@property")
  colorizeCmpItem("CmpItemKindEvent", "@constant")

  colorizeCmpItem("CmpItemKindText", "@property")
  colorizeCmpItem("CmpItemKindEnum", "@variable.member")
  colorizeCmpItem("CmpItemKindKeyword", "@keyword")

  colorizeCmpItem("CmpItemKindConstant", "@constant")
  colorizeCmpItem("CmpItemKindConstructor", "@type")
  colorizeCmpItem("CmpItemKindReference", "@variable.parameter.reference")

  colorizeCmpItem("CmpItemKindFunction", "@function")
  colorizeCmpItem("CmpItemKindStruct", "@constant")
  colorizeCmpItem("CmpItemKindClass", "@type")
  colorizeCmpItem("CmpItemKindModule", "@module")
  colorizeCmpItem("CmpItemKindOperator", "@operator")

  colorizeCmpItem("CmpItemKindVariable", "@variable")
  colorizeCmpItem("CmpItemKindFile", "@variable")

  colorizeCmpItem("CmpItemKindUnit", "@constant")
  colorizeCmpItem("CmpItemKindSnippet", "@constant")
  colorizeCmpItem("CmpItemKindFolder", "@constant")

  colorizeCmpItem("CmpItemKindMethod", "@function.method")
  colorizeCmpItem("CmpItemKindEnumMember", "@variable.member")
  colorizeCmpItem("CmpItemKindValue", "@variable.member")

  colorizeCmpItem("CmpItemKindInterface", "@type")
  colorizeCmpItem("CmpItemKindColor", "DevIconCss")
  colorizeCmpItem("CmpItemKindTypeParameter", "@variable.parameter")

  colorizeCmpItem("CmpItemKindSnippet", "@constant")

  colorizeCmpItem("CmpItemKindFile", "TSURI")
end

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    init = function()
      -- hide copilot suggestion when BlinkCmp menu is open
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          require("copilot.suggestion").dismiss()
          vim.b.copilot_suggestion_hidden = true
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end,
      })
    end,
    opts = {
      enabled = function()
        return vim.bo.buftype ~= "prompt" and vim.bo.buftype ~= "nofile"
      end,
      keymap = {
        preset = "default",
        ["<Tab>"] = {},
        ["<CR>"] = { "accept", "fallback" },
      },
      fuzzy = {
        sorts = {
          "exact",
          -- defaults
          "score",
          "sort_text",
        },
        implementation = "prefer_rust_with_warning",
      },
      completion = {
        ghost_text = {
          enabled = false,
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 1000,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = {
          auto_show = true,
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            padding = { 0, 2 },
            components = {
              kind_icon = {
                text = function(ctx)
                  local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return " " .. kind_icon .. ctx.icon_gap .. " "
                end,
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              kind = {
                -- (optional) use highlights from mini.icons
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
              label = {
                width = { fill = true, max = 100 },
                text = function(ctx)
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    -- Or you want to add more item to label
                    return highlights_info.label
                  else
                    return ctx.label
                  end
                end,
                highlight = function(ctx)
                  local highlights = {}
                  local highlights_info = require("colorful-menu").blink_highlights(ctx)
                  if highlights_info ~= nil then
                    highlights = highlights_info.highlights
                  end
                  for _, idx in ipairs(ctx.label_matched_indices) do
                    table.insert(highlights, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
                  end
                  -- Do something else
                  return highlights
                end,
              },
            },
          },
        },
      },
      cmdline = {
        sources = {},
        enabled = false,
      },
      term = {
        sources = {},
        enabled = false,
      },
      sources = {
        default = {
          "buffer",
          "lsp",
          "omni",
          "path",
          "snippets",
          "copilot",
        },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
          cmdline = {
            enabled = false,
          },
        },
      },
    },
    dependencies = {
      { "fang2hou/blink-copilot" },
      { "xzbdmw/colorful-menu.nvim" },
      { "rafamadriz/friendly-snippets" },
    },
  },
}
