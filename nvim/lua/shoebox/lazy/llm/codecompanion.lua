local constants = {
  LLM_ROLE = "llm",
  USER_ROLE = "user",
  SYSTEM_ROLE = "system",
}

local vim = vim
local api = vim.api

local techwriter = {
  role = constants.SYSTEM_ROLE,
  content = [[ Act as a tech writer. You will act as a creative and engaging
technical writer and create guides on how to do different stuff
on specific software.]],
}

local codereviewer = {
  role = constants.SYSTEM_ROLE,
  content = [[ I want you to act as a Code reviewer who is experienced
    developer in the given code language. I will provide you with the code
    block or methods or code file along with the code language name, and I
    would like you to review the code and share the feedback, suggestions and
    alternative recommended approaches. Please write explanations behind the
    feedback or suggestions or alternative approaches. Reply in English using
    professional tone for everyone. ]],
}

local developer = {
  role = constants.SYSTEM_ROLE,
  content = function(context)
    return "You are an top-notch developer with expertise in"
      .. context.filetype
      .. "programming language and software design principles"
  end,
}

local returnSurroundedCode = {
  role = constants.SYSTEM_ROLE,
  content = function(context)
    return "Return any code snippet surrounded by triple backticks "
      .. "and use the language name of the filetype, example: "
      .. "```"
      .. context.filetype
      .. "\n"
      .. "```"
  end,
}

local function is_visual_mode(mode)
  return mode == "v" or mode == "V" or mode == "^V"
end

local function get_visual_selection(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  -- store the current mode
  local mode = vim.fn.mode()

  -- if we're not in visual mode, we need to re-enter it briefly
  local is_visual = is_visual_mode(mode)

  if mode == "n" or mode == "i" then
    -- retrieve the whole content of the buffer
    return api.nvim_buf_get_lines(bufnr, 0, -1, false)
  end

  -- Get positions
  local start_pos, end_pos
  if is_visual then
    -- If we're in visual mode, use 'v' and '.'
    start_pos = vim.fn.getpos("v")
    end_pos = vim.fn.getpos(".")
    -- else
    -- Fallback to marks if not in visual mode
    start_pos = vim.fn.getpos("'<")
    end_pos = vim.fn.getpos("'>")
  end

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]
  print("Start position: ", start_line, start_col)
  print("End position: ", end_line, end_col)

  -- normalize the range to start < end
  if start_line > end_line or (start_line == end_line and start_col > end_col) then
    start_line, end_line = end_line, start_line
    start_col, end_col = end_col, start_col
  end

  local lines = api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

  -- get whole buffer if there is no current/previous visual selection
  if start_line == 0 then
    lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
    start_line = 1
    start_col = 0
    end_line = #lines
    end_col = #lines[#lines]
  end

  -- Handle partial line selections
  if #lines > 0 then
    if mode == "V" or (not is_visual and vim.fn.visualmode() == "V") then
      -- For line-wise selection, use full lines
      start_col = 1
      end_col = #lines[#lines]
    else
      -- For character-wise selection, respect the columns
      if #lines == 1 then
        lines[1] = lines[1]:sub(start_col, end_col)
      else
        lines[1] = lines[1]:sub(start_col)
        lines[#lines] = lines[#lines]:sub(1, end_col)
      end
    end
  end

  return lines, start_line, start_col, end_line, end_col
end

local codeAction = function(txt)
  return {
    role = constants.USER_ROLE,
    content = function(context)
      local code = get_visual_selection(context.bufnr)
      code = table.concat(code, "\n")

      return string.format(
        [[%s %d:

```%s
%s
```]],
        txt,
        context.bufnr,
        context.filetype,
        code
      )
    end,
    opts = {
      contains_code = true,
    },
  }
end

local solidexpert = {
  role = "system",
  content = [[You are an expert software architect specializing in the SOLID
  principles (Single Responsibility, Open/Closed, Liskov Substitution,
  Interface Segregation, Dependency Inversion).]],
}

return {
  {
    "olimorris/codecompanion.nvim",
    opts = {
      prompt_library = {
        ["Generate a Commit Message"] = {
          strategy = "inline",
          description = "Generate a commit message",
          opts = {
            index = 10,
            is_default = true,
            is_slash_cmd = true,
            short_name = "inline_commit",
            auto_submit = true,
            opts = {
              log_level = "DEBUG",
            },
          },
          prompts = {
            {
              role = constants.USER_ROLE,
              content = function()
                return string.format(
                  [[You are an expert at following the Conventional Commit
                  specification. Given the git diff listed below, please
                  generate a commit message for me:

```diff
%s
```
]],
                  vim.fn.system("git diff --no-ext-diff --staged")
                )
              end,
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ["Code review - Basic"] = {
          strategy = "chat",
          description = "Review the code and provide feedback",
          opts = {
            auto_submit = true,
            short_name = "code_review_basic",
            modes = { "n", "v" },
          },
          prompts = {
            developer,
            {
              role = "system",
              content = [[I want you to act as a Code reviewer who is
  experienced developer in the given code language. I will provide
  you with the code block or methods or code file along with the
  code language name, and I would like you to review the code and
  share the feedback, suggestions and alternative recommended
  approaches. Please write explanations behind the feedback or
  suggestions or alternative approaches. Reply in English using
  casual tone for everyone.]],
            },
            codeAction("review the following code"),
          },
        },
        ["Code review - SOLID"] = {
          strategy = "chat",
          description = "Review the code and provide feedback",
          opts = {
            auto_submit = true,
            short_name = "code_review_solid",
          },
          prompts = {
            developer,
            solidexpert,
            {
              role = "user",
              content = [[ Review the provided code snippet or full code file
for compliance with the SOLID principles (Single Responsibility,
Open/Closed, Liskov Substitution, Interface Segregation,
Dependency Inversion).

If the code is fully SOLID compliant, respond with: `The code is SOLID compliant.`

If you find any SOLID violations, for each issue:
- Clearly state which SOLID principle is violated.
- Explain in detail why the code violates this principle.
- Suggest specific improvements or refactorings to make the code more SOLID compliant.

Your feedback should be concise, actionable, and focused on SOLID principles only.]],
            },
            codeAction("review the following code"),
          },
        },
        ["Code review - General"] = {
          strategy = "chat",
          description = "Review the code and provide feedback",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "code_review_general",
          },
          prompts = {
            developer,
            codereviewer,
            {
              role = constants.SYSTEM_ROLE,
              content = [[Provide feedback on the code quality, structure, and any potential
improvements. Focus on best practices, performance, and maintainability, and
enforcing SOLID, DRY, YAGNI, and KISS principles. If no issues are found,
simply respond with "LGTM!" and nothing else]],
            },
            codeAction("review the following code"),
          },
        },
        ["Unit Tests - Gherkin test-cases"] = {
          strategy = "chat",
          description = "Generate Gherkin test scenario for the code",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "unit_tests_gherkin",
          },
          prompts = {
            {
              role = constants.SYSTEM_ROLE,
              content = [[ Act as a top-notch Go developer and generate Gherkin
test cases for the code below. Focus on covering the functionality, edge cases,
and error handling. Ensure that the scenarios are clear, concise, and follow
Gherkin syntax]],
            },
            codeAction("here is the target code"),
          },
        },
        ["Refactoring - matching pattern"] = {
          strategy = "chat",
          description = "Looking for patterns in the code that can be refactored",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "refactor_matching_pattern",
          },
          prompts = {
            developer,
            {
              role = constants.SYSTEM_ROLE,
              content = [[ Analyze the following code snippet and identify any
common software design patterns present, such as Singleton, Factory, Observer,
Strategy, and others. For each identified pattern, provide:
- The name of the design pattern.
- A detailed explanation of the pattern’s purpose.
- A description of the pattern’s typical structure.
- An snippet of how the pattern could be implemented in the
provided code, referencing specific elements or lines where
appropriate.

If no recognizable design patterns are found in the code, state clearly that no
design patterns were identified. ]],
            },
            codeAction("analyze the following code for design patterns"),
          },
        },
        ["Refactoring - SOLID"] = {
          strategy = "chat",
          description = "Refactor the code to follow SOLID principles",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "refactor_solid",
            modes = { "n", "v" },
          },
          prompts = {
            developer,
            solidexpert,
            {
              role = constants.SYSTEM_ROLE,
              content = [[Suggest a way to refactor this code to follow SOLID
              Principles while improving reusability]],
            },
            returnSurroundedCode,
            codeAction("refactor the following code"),
          },
        },
        ["Refactoring - Optimize logging"] = {
          strategy = "chat",
          description = "Optimize logging in the code",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "refactor_solid",
          },
          prompts = {
            developer,
            {
              role = constants.SYSTEM_ROLE,
              content = function(context)
                return [[ You are an expert software engineer specializing in code quality
and observability.  Given the following code, optimize its logging by
applying industry best practices.

Your tasks are to:

- Review all logging statements for clarity, relevance, and performance.
- Ensure appropriate log levels (DEBUG, INFO, WARNING, ERROR, CRITICAL) are used.
- Remove or redact any sensitive information from logs.
- Use structured logging where possible.
- Avoid excessive or redundant logging.
- Add missing logs that would aid in debugging or monitoring.
- Follow language- and framework-specific logging standards.
]]
              end,
            },
            codeAction("refactor the logging in the following code"),
          },
        },
        ["Refactoring - Add missing documentation"] = {
          strategy = "chat",
          description = "Add missing documentation to the code",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "refactoring_missing_doc",
          },
          prompts = {
            developer,
            {
              role = constants.USER_ROLE,
              content = [[ Analyze the following code and identify all areas
              that require documentation, in the best practices for the language.
              For each, generate appropriate comments or docstrings that follow
              the best practices and conventions for the programming language
              used in the code. Ensure that the documentation is clear,
              concise, and informative.
              Do not modify the code logic—only add missing
              documentation in the correct format for the language.]],
            },
            codeAction("here is the target code"),
          },
        },
        ["Refactoring - Find better naming"] = {
          strategy = "chat",
          description = "Find better naming for the code",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "refactor_naming",
          },
          prompts = {
            developer,
            {
              role = constants.USER_ROLE,
              content = [[ Analyze the following code snippet. Review all
              variable, function, and class names for clarity and adherence to
              the naming conventions of the programming language used in the
              code. Suggest more descriptive and meaningful names that improve
              readability and maintainability. For each suggestion, provide the
              original name, your proposed replacement, and a brief explanation
              for the change. Present your suggestions in a clear, organized
              list.]],
            },
            returnSurroundedCode,
            codeAction("find better naming for the following code"),
          },
        },
        ["Rewrite article"] = {
          strategy = "chat",
          description = "Review the code and provide feedback",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "rewrite_article",
          },
          prompts = {
            techwriter,
            {
              role = constants.USER_ROLE,
              content = [[ Rewrite the artifact draft in given buffer.
Make it engaging, clear and easy to read.
Flesh-out the content, add examples, and ensure it is well-structured.
Here is the draft:
#buffer]],
            },
          },
        },
        ["Write article"] = {
          strategy = "chat",
          description = "Review the code and provide feedback",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = true,
            short_name = "write_article",
          },
          prompts = {
            techwriter,
            {
              role = constants.USER_ROLE,
              content = [[ I will give you a subject and you will come up with
  an engaging article on how to do those basic steps. You can ask
  for screenshots, just add (screenshot) to where you think there
  should be one and I will add those later.]],
            },
          },
        },
      },
      display = {
        action_palette = {
          opts = {
            provider = "default",
            show_default_actions = true,
            show_default_prompt_library = true,
            width = 30,
            height = 10,
          },
        },
        chat = {
          window = {
            show_references = true,
            show_header_separator = true,
            show_settings = true,
            width = 0.33,
          },
        },
      },
      strategies = {
        -- Change the default chat adapter
        chat = {
          adapter = "copilot",
          keymaps = {
            debug = {
              modes = {
                n = "gdd",
              },
              index = 16,
              callback = "keymaps.debug",
              description = "View debug info",
            },
          },
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
      "CodeCompanion",
    },
    keys = {
      {
        "<leader>za",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v", "x" },
        desc = "Code Companion - Actions",
      },
      {
        "<leader>]",
        mode = { "n", "v" },
        "<cmd>CodeCompanionActions<cr>",
        desc = "Code Companion - Actions",
      },
      {
        "<leader>zc",
        "<cmd>CodeCompanionChat<cr>",
        desc = "Code Companion - Chat",
      },
    },
  },
}
