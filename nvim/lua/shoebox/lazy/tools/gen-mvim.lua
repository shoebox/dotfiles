local vim = vim

local function get_git_diff(staged)
  local cmd = staged and "git diff --no-ext-diff --staged" or "git diff --no-ext-diff"
  local handle = io.popen(cmd)
  if not handle then
    return ""
  end

  local result = handle:read("*a")
  handle:close()
  return result
end

local fileInputDataIndicator = function()
  return string.format(
    [[```%s
%s
```
]],
    vim.bo.filetype,
    "$text"
  )
end
local fileOutputDataIndicator = function()
  return string.format(
    [[```%s
%s
```
]],
    vim.bo.filetype,
    "$text"
  )
end

local TopNotchDev = function()
  return string.format("You are a top-notch %s developer", vim.bo.filetype)
end

local function mergeTableIntoString(t)
  local mergedString = ""
  for key, value in pairs(t) do
    if value == "" then
    else
      mergedString = mergedString .. key .. " : " .. tostring(value) .. "\n"
    end
  end

  return mergedString
end

local prompts = {}
prompts["Adds missing documentation to the following code"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [[Your mission is to add clear and comprehensive code documentation for the provided code.
The result should follow best-practices for the coding language.
All methods, struct, and packages definition should be documented.
And you should return as output the very same code amended with the missing documentation.]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

prompts["Advanced code refactoring"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [["Your mission is to refactor this code for possible around:
- DRY rules.
- SOLID rules.
- Coding best practices for the language.

The goal is to improve readability, and maintainability.
And avoid any code smells and anti-patterns.]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

prompts["Advanced code review"] = function()
  return {
    Context = string.format("You are a top-notch %v developer", vim.bo.fileype),
    Instruction = [[Your mission is to review this code and provide suggestions for possible improvement around the following subjects:
- DRY rules.
- SOLID rules.
- Coding best practices for the language.

The goal are to:
- improve readability
- improve maintainability
- avoid any code smells and anti-patterns.]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

prompts["Conventional commit"] = function()
  return {
    Context = "You are top-notch developer, expert in conventional commit convention.",
    Instruction = [[Given the following Git diff, please generate a concise and
    informative commit message that adheres to the Conventional Commits
    Convention. The commit message should clearly describe what changes were
    made (WHAT) and why they were made (WHY).

    The types of commit messages are:
        - API or UI relevant changes:
            - `feat`:  Commits, that add or remove a new feature to the API or UI
            - `fix`: Commits, that fix a API or UI bug of a preceded feat commit
        - `refactor`: Commits, that rewrite/restructure your code, however do not change any API or UI behaviour
            - `perf`: Commits are special refactor commits, that improve performance
        - `style`: Commits, that do not affect the meaning (white-space, formatting, missing semi-colons, etc)
        - `test`: Commits, that add missing tests or correcting existing tests
        - `docs`: Commits, that affect documentation only
        - `build`: Commits, that affect build components like build tool, ci pipeline, dependencies, project version, ...
        - `ops`: Commits, that affect operational components like infrastructure, deployment, backup, recovery, ...
        - `chore`: Miscellaneous commits e.g. modifying .gitignore

    The scope provides additional contextual information.

    Is an optional part of the format
    Allowed Scopes depend on the specific project
    Don't use issue identifiers as scopes

    The description contains a concise description of the change. It is a
    mandatory part of the format Use the imperative, present tense: "change"
    not "changed" nor "changes" Think of This commit will... or This commit
    should... Don't capitalize the first letter No dot (.) at the end

    The body should include the motivation for the change and contrast this with
    previous behavior. Is an optional part of the format Use the imperative,
    present tense: "change" not "changed" nor "changes" This is the place to
    mention issue identifiers and their relations

    The footer should contain any information about Breaking Changes and is
    also the place to reference Issues that this commit refers to. Is an
    optional part of the format optionally reference an issue by its id.
    Breaking Changes should start with the word BREAKING CHANGE: followed by
    space or two newlines. The rest of the commit message is then used for
    this.

### Examples
- `feat: add email notifications on new direct messages`
- `feat(shopping cart): add the amazing button`
- ```
  feat!: remove ticket list endpoint

  refers to JIRA-1337

  BREAKING CHANGE: ticket endpoints no longer supports list all entities.
  ```
- `Fix(shopping-cart): prevent order an empty shopping cart`
- `fix(api): fix wrong calculation of request body checksum`
- ```
  fix: add missing parameter to service call

  The error occurred due to <reasons>.
  ```
- ```
  perf: decrease memory footprint for determine uniqe visitors by using HyperLogLog
  ```
- ```
  build: update dependencies
  ```
- ```
  build(release): bump version to 1.0.0
  ```
- ```
  refactor: implement fibonacci number calculation as recursion
  ```
- ```
  style: remove empty line
  ```
    ]],
    OutputIndicator = [[And the output is expected to follow the format:
<type>(<optional scope>): <description>"

[optional body]"

[optional footer(s)]],
    Inputdata = get_git_diff(true),
    Model = "llama3.2",
  }
end

prompts["Enhance wording"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [[Modify the following text to use better wording.
Output the final text without additional quotes around it:]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

prompts["Generate Gherkin unit-tests cases"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [[Generate unit-tests cases for the given code.
Full feature coverage is expected.
As much as possible group the unit-tests cases by targetted feature.
Just answer with Gherkin test cases in Gherkin file format.]],
    InputData = fileInputDataIndicator(),
  }
end

prompts["Generate unit-tests cases"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [[Your missing is to generate unit-tests for the given code.
It must following standard coding convention for the language and best-practices to write unit-tests.
Full feature coverage is expected.
Just focus on the unit-tests generation themselves, not on the boilerplate and the mocks generation.
Use Gherkin comments syntax for different testing phases.
If GoLang as much as possible use table-driven testing to avoid repetition.
]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

prompts["Refactor with SOLID"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [[ Your mission is to process and refactor the provided code
    to make it compliant with each SOLID principle. Keep in mind that the code
    should remain readable, maintainable, and simple.
    ]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

prompts["Review code"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = "Act as a code reviewer. Please review the following code and make concise suggestions.",
    InputData = fileInputDataIndicator(),
  }
end

prompts["Simplify code"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [[Simplify the following code to make it as clear and effective as possible, while keeping the existing logic intact]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

prompts["SOLID code review"] = function()
  return {
    Context = "You are top-notch developer and expert in SOLID principles.",
    Instruction = [[Your mission is to review the provided code and check compliance with each SOLID principle]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = [[For each principle:
If the principle pass review, output the following output:
✅ <Principle name> = <Description>

If principle fails review:
❌ <Principle name> = <Description>]],
  }
end

prompts["Suggest better naming"] = function()
  return {
    Context = TopNotchDev(),
    Instruction = [[ Take all variable and function names, and provide only a
    list with suggestions with improved naming, only if any changes are
    required.
    Following best practices and convention for the coding language.
    ]],
    InputData = fileInputDataIndicator(),
    OutputIndicator = fileOutputDataIndicator(),
  }
end

return {
  {
    "David-Kunz/gen.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = "Gen",
    config = function()
      local gen = require("gen")

      gen.setup({
        debug = false,
        display_mode = "split",
        file = false,
        model = "deepseek-r1:7b",
        no_auto_close = true,
        replace = false,
        show_model = true,
        show_prompt = true,
      })

      gen.prompts = {}
      for key, val in pairs(prompts) do
        print(vim.inspect(key))
        local def = {
          prompt = function()
            return mergeTableIntoString(val())
          end,
          extract = "```$filetype\n(.-)```",
        }

        gen.prompts[key] = def
      end

      gen.prompts["Chat"] = { prompt = "$input" }
      gen.prompts["Ask about"] = { prompt = "Regarding the following text, $input:\n$text" }

      vim.keymap.set({ "n", "v", "x" }, "<leader>]", ":Gen<CR>")
    end,
    keys = {
      {
        "<leader>]",
        function()
          require("gen").select_prompt()
        end,
        desc = "Gen.nvim",
      },
    },
  },
}
