local function get_git_diff(staged)
	local cmd = staged and "git diff --staged" or "git diff"
	local handle = io.popen(cmd)
	if not handle then
		return ""
	end

	local result = handle:read("*a")
	handle:close()
	return result
end

return {
	{
		"David-Kunz/gen.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function()
			local gen = require("gen")

			gen.setup({
				display_mode = "split",
				model = "deepseek-coder:6.7b",
				no_auto_close = true,
				replace = false,
				show_model = true,
				show_prompt = true,
			})

			gen.prompts = {}
			gen.prompts["Suggest better naming"] = {
				prompt = function()
					return "Take all variable and function names, and provide only a list with suggestions with improved naming if any changes required:"
						.. "\n"
						.. "$text"
						.. "\n```"
				end,
			}

			gen.prompts["Enhance wording"] = {
				prompt = function()
					return "Modify the following text to use better wording, just output the final text without additional quotes around it:\n"
						.. "Only ouput the result in format:"
						.. ":\n```"
						.. vim.bo.filetype
						.. "\n"
						.. "$text"
						.. "\n```"
				end,
			}

			gen.prompts["Conventional commit"] = {
				-- return "Answer only with a commit message that must follow the conventional commit convention, for the following changes"
				prompt = function()
					return "Your mission is to create clean and comprehensive commit messages as "
						.. "per the conventional commit convention, and explain WHAT were the "
						.. "changes and mainly WHY the changes were done. "
						.. "I'll send you an output of 'git diff --staged' command, and you are to "
						.. "convert it into a commit message."
						.. "\nThe git diff --staged output is:"
						.. "\n"
						.. get_git_diff(true)
						.. "\n```"
						.. "\n``$filetype\n$text\n```"
				end,
				replace = true,
			}

			gen.prompts["Ask about"] = {
				prompt = "Regarding the following :\n" .. "$text" .. "\n" .. "$input",
			}

			gen.prompts["Advanced code review"] = {
				prompt = "Act as a top-notch developer. "
					.. "Review this code and provide suggestions for: possible improvement around: "
					.. "coding best practices (SOLID and DRY), "
					.. "how-to improve readability, and maintainability. "
					.. "how to avoid any code smells and anti-patterns. "
					.. "If the provided code does does not need any changes, just say 'No changes needed'. "
					.. "Only ouput the result in format:"
					.. ":\n```"
					.. vim.bo.filetype
					.. "\n"
					.. "$text"
					.. "\n```",
				replace = true,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Adds simple documentation to the following code"] = {
				prompt = function()
					return "Provide a simple and concise description of the following code using "
						.. "coding language standards:\n"
						.. "```"
						.. vim.bo.filetype
						.. "\n"
						.. "$text"
						.. "\n```"
				end,
				replace = true,
				extract = "```$filetype\n(.-)```",
			}
			gen.prompts["Adds missing documentation to method"] = {
				prompt = "Act as a top-notch developer. Adds missing documentation to the following method. "
					.. "It should only document the functional itself"
					.. "It must following standard coding convention for the language"
					.. ":\n```"
					.. vim.bo.filetype
					.. "\n"
					.. "$text"
					.. "\n```",
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["SOLID code review"] = {
				prompt = "Act as a top-notch Golang devloper. Review this code and check compliance with each SOLID principle:\n```"
					.. vim.bo.filetype
					.. "\n"
					.. "$text"
					.. "\n```",
				replace = false,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Review code"] = {
				prompt = "Review the following code and make concise suggestions, only output the result in format:\n```"
					.. vim.bo.filetype
					.. "\n"
					.. "$text"
					.. "\n```",
				replace = false,
				extract = "```$filetype\n(.-)```",
			}

			gen.prompts["Simplify code"] = {
				prompt = function()
					return "Simplify the following code, only output the result in format:"
						.. "\n````"
						.. vim.bo.filetype
						.. "\n"
						.. "$text"
						.. "\n```"
				end,
			}

			vim.keymap.set({ "n", "v" }, "<leader>]", ":Gen<CR>")
		end,
		-- keys = {
		-- 	{
		-- 		"<leader>]",
		-- 		"<cmd>:Gen<CR>",
		-- 		mode = "n",
		-- 		desc = "Gen",
		-- 	},
		-- 	{
		-- 		"<leader>]",
		-- 		"<cmd>:Gen<CR>",
		-- 		mode = "v",
		-- 		desc = "Gen",
		-- 	},
		-- },
	},
}
