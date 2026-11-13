-- ============================================================
-- FANZINE ☠
--
-- Colorscheme punk de fotocopia: tinta negra, papel hueso y
-- stickers de colores. Alto contraste, selecciones invertidas,
-- nada de pasteles.
--
-- La misma paleta se usa en tmux/tmux.conf.
-- ============================================================

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "fanzine"

local c = {
  ink    = "#0b0b0b", -- fondo: tinta negra
  ink2   = "#161616", -- línea del cursor, popups
  ink3   = "#2a2a2a", -- fotocopia gris oscura
  paper  = "#efe9dc", -- texto: papel hueso
  grey   = "#6b6b6b", -- comentarios, cosas apagadas
  grey2  = "#444444", -- números de línea
  pink   = "#ff2a6d", -- rosa neón
  acid   = "#f7e600", -- amarillo ácido
  blood  = "#e10600", -- rojo sangre
  xerox  = "#2de2e6", -- cian de fotocopiadora
}

local hl = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ------------------------------------------------------------
-- Editor
-- ------------------------------------------------------------
hl("Normal",       { fg = c.paper, bg = c.ink })
hl("NormalNC",     { fg = c.paper, bg = c.ink })
hl("NormalFloat",  { fg = c.paper, bg = c.ink2 })
hl("FloatBorder",  { fg = c.pink, bg = c.ink2, bold = true })
hl("FloatTitle",   { fg = c.ink, bg = c.pink, bold = true })
hl("Cursor",       { fg = c.ink, bg = c.acid })
hl("CursorLine",   { bg = c.ink2 })
hl("CursorColumn", { bg = c.ink2 })
hl("ColorColumn",  { bg = c.ink2 })
hl("LineNr",       { fg = c.grey2 })
hl("CursorLineNr", { fg = c.acid, bold = true })
hl("SignColumn",   { bg = c.ink })
hl("FoldColumn",   { fg = c.grey2, bg = c.ink })
hl("Folded",       { fg = c.grey, bg = c.ink2, italic = true })
hl("WinSeparator", { fg = c.paper, bold = true })
hl("VertSplit",    { link = "WinSeparator" })
hl("EndOfBuffer",  { fg = c.ink })
hl("NonText",      { fg = c.ink3 })
hl("Whitespace",   { fg = c.ink3 })
hl("SpecialKey",   { fg = c.ink3 })
hl("Conceal",      { fg = c.grey })

-- Selección y búsqueda: invertido, como resaltador sobre fotocopia
hl("Visual",     { fg = c.ink, bg = c.pink, bold = true })
hl("VisualNOS",  { link = "Visual" })
hl("Search",     { fg = c.ink, bg = c.acid, bold = true })
hl("IncSearch",  { fg = c.ink, bg = c.pink, bold = true })
hl("CurSearch",  { fg = c.paper, bg = c.blood, bold = true })
hl("Substitute", { fg = c.paper, bg = c.blood, bold = true })
hl("MatchParen", { fg = c.ink, bg = c.xerox, bold = true })

-- Status / tabs
hl("StatusLine",   { fg = c.ink, bg = c.acid, bold = true })
hl("StatusLineNC", { fg = c.grey, bg = c.ink3 })
hl("TabLine",      { fg = c.paper, bg = c.ink3 })
hl("TabLineFill",  { bg = c.ink })
hl("TabLineSel",   { fg = c.ink, bg = c.pink, bold = true })
hl("WinBar",       { fg = c.paper, bg = c.ink, bold = true })
hl("WinBarNC",     { fg = c.grey, bg = c.ink })

-- Menús
hl("Pmenu",      { fg = c.paper, bg = c.ink2 })
hl("PmenuSel",   { fg = c.ink, bg = c.pink, bold = true })
hl("PmenuSbar",  { bg = c.ink3 })
hl("PmenuThumb", { bg = c.paper })
hl("WildMenu",   { link = "PmenuSel" })

-- Mensajes
hl("Title",      { fg = c.pink, bold = true })
hl("Directory",  { fg = c.acid, bold = true })
hl("Question",   { fg = c.acid, bold = true })
hl("MoreMsg",    { fg = c.acid, bold = true })
hl("ModeMsg",    { fg = c.ink, bg = c.acid, bold = true })
hl("ErrorMsg",   { fg = c.paper, bg = c.blood, bold = true })
hl("WarningMsg", { fg = c.acid, bold = true })

-- ------------------------------------------------------------
-- Sintaxis
-- ------------------------------------------------------------
hl("Comment",    { fg = c.grey, italic = true })
hl("Constant",   { fg = c.blood, bold = true })
hl("String",     { fg = c.xerox })
hl("Character",  { link = "String" })
hl("Number",     { fg = c.blood, bold = true })
hl("Boolean",    { fg = c.blood, bold = true })
hl("Float",      { link = "Number" })
hl("Identifier", { fg = c.paper })
hl("Function",   { fg = c.acid, bold = true })
hl("Statement",  { fg = c.pink, bold = true })
hl("Keyword",    { fg = c.pink, bold = true, italic = true })
hl("Conditional",{ link = "Keyword" })
hl("Repeat",     { link = "Keyword" })
hl("Exception",  { fg = c.blood, bold = true })
hl("Operator",   { fg = c.pink })
hl("PreProc",    { fg = c.pink })
hl("Include",    { fg = c.pink, bold = true })
hl("Type",       { fg = c.paper, bold = true, underline = true })
hl("StorageClass", { fg = c.pink })
hl("Structure",  { link = "Type" })
hl("Special",    { fg = c.acid })
hl("Delimiter",  { fg = c.grey })
hl("Underlined", { fg = c.xerox, underline = true })
hl("Todo",       { fg = c.ink, bg = c.acid, bold = true })
hl("Error",      { fg = c.paper, bg = c.blood, bold = true })

-- Treesitter
hl("@variable",          { fg = c.paper })
hl("@variable.builtin",  { fg = c.blood, italic = true })
hl("@variable.parameter",{ fg = c.paper, italic = true })
hl("@property",          { fg = c.paper })
hl("@field",             { fg = c.paper })
hl("@function.builtin",  { fg = c.acid, italic = true })
hl("@constructor",       { fg = c.acid })
hl("@keyword.return",    { fg = c.blood, bold = true, italic = true })
hl("@punctuation",       { fg = c.grey })
hl("@tag",               { fg = c.pink, bold = true })
hl("@tag.attribute",     { fg = c.acid })
hl("@markup.heading",    { fg = c.ink, bg = c.pink, bold = true })
hl("@markup.strong",     { bold = true })
hl("@markup.italic",     { italic = true })
hl("@markup.link",       { fg = c.xerox, underline = true })
hl("@markup.raw",        { fg = c.acid })
hl("@comment.todo",      { link = "Todo" })

-- ------------------------------------------------------------
-- Diagnósticos y diffs
-- ------------------------------------------------------------
hl("DiagnosticError", { fg = c.blood, bold = true })
hl("DiagnosticWarn",  { fg = c.acid })
hl("DiagnosticInfo",  { fg = c.xerox })
hl("DiagnosticHint",  { fg = c.pink })
hl("DiagnosticOk",    { fg = c.xerox })
hl("DiagnosticUnderlineError", { sp = c.blood, undercurl = true })
hl("DiagnosticUnderlineWarn",  { sp = c.acid, undercurl = true })
hl("DiagnosticUnderlineInfo",  { sp = c.xerox, undercurl = true })
hl("DiagnosticUnderlineHint",  { sp = c.pink, undercurl = true })

hl("DiffAdd",    { fg = c.xerox, bg = "#0f2526" })
hl("DiffChange", { fg = c.acid, bg = "#24220a" })
hl("DiffDelete", { fg = c.blood, bg = "#2a0b0b" })
hl("DiffText",   { fg = c.ink, bg = c.acid, bold = true })
hl("Added",      { fg = c.xerox })
hl("Changed",    { fg = c.acid })
hl("Removed",    { fg = c.blood })

-- ------------------------------------------------------------
-- Plugins
-- ------------------------------------------------------------
-- nvim-tree
hl("NvimTreeNormal",           { fg = c.paper, bg = c.ink })
hl("NvimTreeNormalNC",         { fg = c.paper, bg = c.ink })
hl("NvimTreeWinSeparator",     { fg = c.paper, bg = c.ink, bold = true })
hl("NvimTreeRootFolder",       { fg = c.ink, bg = c.pink, bold = true })
hl("NvimTreeFolderName",       { fg = c.acid, bold = true })
hl("NvimTreeOpenedFolderName", { fg = c.pink, bold = true })
hl("NvimTreeEmptyFolderName",  { fg = c.grey })
hl("NvimTreeFolderIcon",       { fg = c.acid })
hl("NvimTreeIndentMarker",     { fg = c.ink3 })
hl("NvimTreeSpecialFile",      { fg = c.xerox, underline = true })
hl("NvimTreeGitDirty",         { fg = c.acid })
hl("NvimTreeGitNew",           { fg = c.xerox })
hl("NvimTreeGitDeleted",       { fg = c.blood })
hl("NvimTreeCursorLine",       { bg = c.ink2 })

-- ------------------------------------------------------------
-- Colores del :terminal
-- ------------------------------------------------------------
local term = {
  c.ink3, c.blood, c.xerox, c.acid, "#3d5afe", c.pink, c.xerox, c.paper,
  c.grey, "#ff3b30", "#7ff3f5", "#fff35c", "#7b8cff", "#ff6b9a", "#7ff3f5", "#ffffff",
}
for i, color in ipairs(term) do
  vim.g["terminal_color_" .. (i - 1)] = color
end

-- Expone la paleta para otros plugins (bufferline, etc.).
return c
