-- local json = require("json")
-- local http = require("http")

local api_key = ""
local api_token = ""

local M = {}

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

local function authenticate()
	-- Implement authentication with Trello API using api_key and token
end

local function create_card()
	local url = "https://api.trello.com/1/cards"
		.. "?key="
		.. api_key
		.. "&token="
		.. api_token
		.. "&name=New%20Card&desc=test%20content%20from%20nvim&idList="
	-- local body = {
	-- 	name = "New Card",
	-- 	desc = "test content from nvim",
	-- }
	local response_body = {}
	-- local request_body = json.encode(body)

	local headers = {
		["Content-Type"] = "application/json",
		-- ["Authorization"] = "Bearer " .. token,
	}

	-- local request_body = vim.fn.json_encode(body)

	local curl_command = string.format(
		"curl -X POST '%s' -H 'Content-Type: application/json'",
		url
		-- request_body
	)
	local response = vim.fn.systemlist(curl_command)

	-- local res, code, response_headers = http.request({
	-- 	url = url,
	-- 	method = "POST",
	-- 	headers = headers,
	-- 	-- source = ltn12.source.string(request_body),
	-- 	-- sink = ltn12.sink.table(response_body),
	-- })

	if code == 200 then
		return table.concat(response_body), response
	else
		return nil, "HTTP Error: " .. code
	end
end

local function parse_buffer_content()
	-- Implement parsing the content of the current buffer
end

local function select_board()
	local selected_board = config[board_index]
	if selected_board then
		return selected_board.boardId, selected_board.listId
	else
		return nil, nil
	end
end

-- Define Neovim commands
vim.cmd([[command! -nargs=0 TrelloAuth lua authenticate()]])
vim.cmd([[command! -nargs=0 TrelloCreate lua require'nvim-trellocard'.create_card()]])
vim.cmd([[command! -nargs=1 TrelloSelectBoard lua select_board(<args>)]])

M.create_card = create_card
M.parse_buffer_content = parse_buffer_content
M.select_board = select_board
M.authenticate = authenticate

return M
