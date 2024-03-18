local M = {}

-- TODO:
-- - proper json to table conversion and back
-- - store authenticate
-- - use proper nvim paths
-- - build config for setup
-- - implement select board


--
-- https://github.com/folke/neodev.nvim
--
--
--   https://miguelcrespo.co/posts/how-to-write-a-neovim-plugin-in-lua/
--
--
--   https://www.reddit.com/r/neovim/comments/oxpl9j/beginneers_guide_to_using_luarocks_on_neovim/


local config = {
	{
		boardId = "BOARD_ID_1",
		listId = "LIST_ID_1",
	},
	{
		boardId = "BOARD_ID_2",
		listId = "LIST_ID_2",
	},
	-- Add more boards/lists as needed
}

local file_path = vim.fn.stdpath("config") .. "/trello_config"

local function authenticate(creds)
	print("path: " .. file_path)

	words = {}
	for word in creds:gmatch("%w+") do
		table.insert(words, word)
	end

	local file = io.open(file_path, "w")
	if file then
		file:write('{\n "api_key": "' .. words[0] .. '",\n  "token": "' .. words[1] .. '"\n}')
		file:close()
		print("Credentials saved")
	else
		print("Error: Unable to open file " .. file_path)
	end
end

local function read_credentials()
	local file = io.open(file_path, "r")
	if file then
		-- Read the first line and store it in a variable
		local firstLine = file:read("*line")

		-- Read the second line and store it in a variable
		local secondLine = file:read("*line")

		-- Read the third line and store it in a variable
		local thirdLine = file:read("*line")

		return firstLine, secondLine, thirdLine
		-- local creds = file:read("a")
		-- return json.decode(creds)
	else
		print("Error: Unable to open file " .. file_path)
	end
end

local function create_card()
	-- -- get visual selection
	-- local vstart = vim.fn.getpos("'<")
	-- local vend = vim.fn.getpos("'>")
	-- local line_start = vstart[2]
	-- local line_end = vend[2]
	-- -- or use api.nvim_buf_get_lines
	-- local lines = vim.fn.getline(line_start, line_end)
    local selected_text = vim.fn.getline("'<", "'>")
    print('Selected text: ' .. selected_text)
  return selected_text

	-- print(lines)
	--
	-- local key, token, list_id = read_credentials()
	--
	-- local url = "https://api.trello.com/1/cards"
	-- 	.. "?key="
	-- 	.. key
	-- 	.. "&token="
	-- 	.. token
	-- 	.. "&name=New%20Card&desc=test%20content%20from%20nvim&idList="
	-- 	.. list_id
	--
	-- local curl_command = string.format("curl -X POST '%s' -H 'Content-Type: application/json'", url)
	-- local response = vim.fn.systemlist(curl_command)
	--
	-- return response
	-- if code == 200 then
	-- 	return table.concat(response_body), response
	-- else
	-- 	return nil, "HTTP Error: " .. code
	-- end
end

local function select_board()
	-- 	local selected_board = config[board_index]
	-- 	if selected_board then
	-- 		return selected_board.boardId, selected_board.listId
	-- 	else
	-- 		return nil, nil
	-- 	end
end

-- Define Neovim commands
vim.cmd([[command! -nargs=1 TrelloAuth lua require'nvim-trellocard'.authenticate(<f-args>)]])
vim.cmd([[command! -range TrelloCreate lua require'nvim-trellocard'.create_card()]])
vim.cmd([[command! -nargs=1 TrelloSelectBoard lua require'nvim-trellocard'.select_board(<args>)]])

M.create_card = create_card
M.select_board = select_board
M.authenticate = authenticate

return M
