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
				display_mode = "split",
				model = "medragondot/Sky-T1-32B-Preview:latest",
				no_auto_close = true,
				replace = false,
				show_model = true,
				show_prompt = true,
			})

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

			gen.prompts = {}
			gen.prompts["Chat"] = { prompt = "$input" }
			gen.prompts["Suggest better naming"] = {
				prompt = function()
					local prompt = {
						Context = TopNotchDev(),
						Instruction = [[ Take all variable and function names, and provide only a list with suggestions with improved naming, only if any changes are required]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = fileOutputDataIndicator(),
					}

					return mergeTableIntoString(prompt)
				end,
			}

			gen.prompts["Enhance wording"] = {
				prompt = function()
					local prompt = {
						Context = TopNotchDev(),
						Instruction = [[Modify the following text to use better wording.
Output the final text without additional quotes around it:]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = fileOutputDataIndicator(),
					}
					return mergeTableIntoString(prompt)
				end,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Conventional commit"] = {
				prompt = function()
					local prompt = {
						Context = "You are top-notch developer, expert in conventional commit convention.",
						Instruction = [[Given the following Git diff, please generate a concise and informative commit message that adheres to the Conventional Commits Convention.
The commit message should clearly describe what changes were made (WHAT) and why they were made (WHY).]],
						OutputIndicator = "And the output is expected to be into the following format:"
							.. "- <type>(<optional scope>): <description>"
							.. "- [optional body]"
							.. "- [optional footer(s)]",
						InputData = get_git_diff(true),
					}

					return mergeTableIntoString(prompt)
				end,
				-- model = "llama3.2",
				replace = false,
			}

			gen.prompts["Ask about"] = {
				prompt = "Regarding the following :\n" .. "$text" .. "\n" .. "$input",
			}

			gen.prompts["Advanced code refactoring"] = {
				prompt = function()
					local prompt = {
						Context = TopNotchDev(),
						Instruction = [["Your mission is to rewrite this code for possible around:
							.. - DRY rules.
							.. - SOLID rules.
							.. - Coding best practices for the language.
							.. The goal is to improve readability, and maintainability.
							.. And avoid any code smells and anti-patterns.]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = fileOutputDataIndicator(),
					}

					return mergeTableIntoString(prompt)
				end,
				replace = false,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Advanced code review"] = {
				prompt = function()
					local prompt = {
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

					return mergeTableIntoString(prompt)
				end,
				replace = false,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Adds missing documentation to the following code"] = {
				prompt = function()
					local prompt = {
						Context = TopNotchDev(),
						Instruction = [[Your mission is to add clear and comprehensive code documentation for the provided code.
The result should follow best-practices for the coding language.
All methods, struct, and packages definition should be documented.
And you should return as output the very same code amended with the missing documentation.]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = fileOutputDataIndicator(),
					}

					return mergeTableIntoString(prompt)
				end,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Generate Gherkin unit-tests cases"] = {
				prompt = "Act as a top-notch developer. "
					.. "Generate unit-tests cases for the given code."
					.. "Full feature coverage is expected. "
					.. "As much as possible group unit-tests cases by targetted feature. "
					.. "Just answer with Gherkin test cases in Gherkin file format."
					.. "```"
					.. vim.bo.filetype
					.. "\n"
					.. "$text"
					.. "\n```",
				extract = "```$filetype\n(.-)```",
				model = "llama3.2",
			}

			gen.prompts["Generate unit-tests"] = {
				prompt = function()
					local prompt = {
						Context = TopNotchDev(),
						Instruction = [[Your missing is to generate unit-tests for the given code.
It must following standard coding convention for the language and best-practices to write unit-tests.
Full feature coverage is expected.
Use Gherkin comments syntax for different testing phases.]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = fileOutputDataIndicator(),
					}

					return mergeTableIntoString(prompt)
				end,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Refactor with SOLID"] = {
				prompt = function()
					local prompt = {
						Context = "You are top-notch developer and expert in SOLID principles.",
						Instruction = [[ Your mission is to process and refactor the provided code to make it compliant with each SOLID principle]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = fileOutputDataIndicator(),
					}

					return mergeTableIntoString(prompt)
				end,
				replace = false,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["SOLID code review"] = {
				prompt = function()
					local prompt = {
						Context = "You are top-notch developer and expert in SOLID principles.",
						Instruction = [[Your mission is to review the provided code and check compliance with each SOLID principle]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = [[For each principle:
If the principle pass review, output the following output:
✅ <Principle name> = <Description>

If principle fails review:
❌ <Principle name> = <Description>]],
					}

					return mergeTableIntoString(prompt)
				end,
				replace = false,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Review code"] = {
				prompt = function()
					local prompt = {
						Context = "You are top-notch developer.",
						Instruction = "Please review the following code and make concise suggestions.",
						InputData = fileInputDataIndicator(),
					}

					return mergeTableIntoString(prompt)
				end,
				replace = false,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Simplify code"] = {
				prompt = function()
					local prompt = {
						Context = TopNotchDev(),
						Instruction = [[Simplify the following code to make it as clear and effective as possible, while keeping the existing logic intact]],
						InputData = fileInputDataIndicator(),
						OutputIndicator = "```" .. vim.bo.filetype .. "\n" .. "$text" .. "\n```",
					}

					return mergeTableIntoString(prompt)
				end,
			}
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
