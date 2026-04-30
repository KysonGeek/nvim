-- 基于 ~/.config/alacritty/alacritty.toml 调色板克隆而来
-- 主调对应 gruvboxl 的结构，方便切换

-- ==== 背景与前景（来自 [colors.primary]）====
local bg          = "#101421" -- alacritty primary.background
local fg          = "#fffbf6" -- alacritty primary.foreground

-- ==== dark 阶（在 bg 基础上向上推导，用于面板/状态栏/光标行等）====
local dark0_hard  = "#0a0d17"
local dark0       = "#101421" -- = bg
local dark0_soft  = "#161a28"
local dark1       = "#1c2030"
local dark2       = "#2e2e2e" -- alacritty normal.black
local dark3       = "#3a3f50"
local dark4       = "#565656" -- alacritty bright.black
local dark4_256   = "#565656"

local dark_ext1   = "#1a1f2e" -- CursorLine / ColorColumn / Folded
local dark_ext2   = "#181c2a" -- StatusLine / TabLine

-- ==== gray 阶 ====
local gray_ext1   = "#2c3243" -- Visual 选中
local gray_ext2   = "#3a3f50" -- LineNr / WinSeparator
local gray_ext3   = "#4a4f60" -- FloatBorder
local gray_ext4   = "#353a4a" -- SignColumn
local gray_ext5   = "#565656" -- Comment / Folded fg

local gray_245    = "#6b7080"
local gray_244    = "#6b7080"

-- ==== light 阶（在 fg 与 normal.white 之间推导）====
local light0_hard = "#ffffff" -- alacritty bright.white
local light0      = "#fffbf6" -- alacritty primary.foreground
local light0_soft = "#f5f3ee"
local light1      = "#eef0f5"
local light2      = "#e5e9f0" -- alacritty normal.white
local light3      = "#d0d4dc"
local light4      = "#b0b4bc"
local light4_256  = "#b0b4bc"

-- ==== 主色（bright 来自 alacritty.bright，neutral 来自 alacritty.normal，faded 推导）====
local bright_red    = "#ec5357" -- bright.red
local bright_green  = "#c0e17d" -- bright.green
local bright_yellow = "#f9da6a" -- bright.yellow
local bright_blue   = "#49a4f8" -- bright.blue
local bright_purple = "#a47de9" -- bright.magenta
local bright_aqua   = "#99faf2" -- bright.cyan
local bright_orange = "#f5a85a" -- 推导：在 yellow 与 red 之间过渡

local neutral_red    = "#eb4129" -- normal.red
local neutral_green  = "#abe047" -- normal.green
local neutral_yellow = "#f6c744" -- normal.yellow
local neutral_blue   = "#47a0f3" -- normal.blue
local neutral_purple = "#7b5cb0" -- normal.magenta
local neutral_aqua   = "#64dbed" -- normal.cyan
local neutral_orange = "#e08e3a" -- 推导：饱和暖橙

local faded_red    = "#b8311e"
local faded_green  = "#7fa334"
local faded_yellow = "#c8a233"
local faded_blue   = "#2e6db8"
local faded_purple = "#5a417f"
local faded_aqua   = "#4a9eb0"
local faded_orange = "#a86729"

-- term

vim.g.terminal_color_0 = dark2 -- 黑色
vim.g.terminal_color_1 = neutral_red -- 红色
vim.g.terminal_color_2 = neutral_green -- 绿色
vim.g.terminal_color_3 = neutral_yellow -- 黄色
vim.g.terminal_color_4 = neutral_blue -- 蓝色
vim.g.terminal_color_5 = neutral_purple -- 洋红色
vim.g.terminal_color_6 = neutral_aqua -- 青色
vim.g.terminal_color_7 = light2 -- 白色
vim.g.terminal_color_8 = dark4 -- 亮黑色
vim.g.terminal_color_9 = bright_red -- 亮红色
vim.g.terminal_color_10 = bright_green -- 亮绿色
vim.g.terminal_color_11 = bright_yellow -- 亮黄色
vim.g.terminal_color_12 = bright_blue -- 亮蓝色
vim.g.terminal_color_13 = bright_purple -- 亮洋红色
vim.g.terminal_color_14 = bright_aqua -- 亮青色
vim.g.terminal_color_15 = light0_hard -- 亮白色

-- 设置高亮
local function hl(theme)
  for k, v in pairs(theme) do
    vim.api.nvim_set_hl(0, k, v)
  end
end
-- 基础颜色
hl({
  NvimLightGrey2 = { fg = light2 },

  Normal = { fg = light2, bg = dark0 },
  CursorLine = { bg = dark_ext1 },
  CursorLineNr = {},
  WildMenu = { fg = bright_red, bg = bright_yellow },

  WinBar = {},
  WinBarNC = {},

  WinSeparator = { fg = gray_ext2 },
  Pmenu = { fg = light2, bg = dark0 },
  PmenuSel = { fg = dark0, bg = bright_blue },
  PmenuMatch = { bold = true },
  PmenuMatchSel = { bold = true },
  PmenuKind = { link = "Pmenu" },
  PmenuKindSel = { link = "PmenuSel" },
  PmenuExtra = { link = "Pmenu" },
  PmenuExtraSel = { link = "PmenuSel" },
  PmenuSbar = { bg = "#262b3a" },
  PmenuThumb = { bg = gray_ext2 },
  QuickFixLine = { bg = dark1 },

  NormalFloat = {},
  FloatBorder = { fg = gray_ext3 },
  StatusLine = { bg = dark_ext2, fg = light1 },
  StatusLineNC = { bg = dark_ext2 },

  TabLine = { bg = dark_ext2, fg = gray_ext5 },
  TabLineSel = { fg = light1, bg = dark0 },
  Directory = { fg = bright_blue },
  Title = { fg = bright_blue, bold = true },
  Question = { fg = bright_blue },
  Search = { fg = dark0, bg = bright_yellow },
  IncSearch = { fg = dark0, bg = bright_orange },
  CurSearch = { link = "IncSearch" },

  Comment = { fg = gray_ext5, italic = true },
  Todo = { fg = bright_green },
  Error = { fg = dark0, bg = bright_red },

  MoreMsg = { fg = bright_green },
  ModeMsg = { fg = bright_green },
  ErrorMsg = { fg = bright_red, bg = dark0 },
  WarningMsg = { fg = bright_yellow },

  DiffAdd = { fg = dark0, bg = bright_green },
  DiffChange = { fg = dark0, bg = bright_aqua },
  DiffDelete = { fg = dark0, bg = bright_red },
  DiffText = { fg = dark0, bg = bright_yellow },

  LineNr = { fg = gray_ext2 },
  SignColumn = { fg = gray_ext4 },

  Cursor = { reverse = true },
  lCursor = { link = "Cursor" },

  Type = { fg = bright_yellow },
  PreProc = { fg = bright_yellow },
  Include = { fg = bright_blue },
  Function = { fg = bright_blue },
  String = { fg = bright_green },
  Statement = { fg = bright_red },
  Constant = { fg = bright_red },
  Special = { fg = bright_aqua },
  Operator = { fg = bright_blue },
  Delimiter = { fg = neutral_orange },
  Identifier = { fg = bright_red },

  Visual = { bg = gray_ext1 },
  VisualNOS = { link = "Visual" },
  Folded = { fg = gray_ext5, bg = dark_ext1 },
  FoldColumn = { fg = gray_ext5, bg = dark_ext1 },

  DiagnosticError = { fg = bright_red },
  DiagnosticInfo = { fg = bright_aqua },
  DiagnosticHint = { fg = bright_blue },
  DiagnosticWarn = { fg = neutral_yellow },
  DiagnosticOk = { fg = bright_green },

  DiagnosticUnderlineError = { underline = true, sp = bright_blue },
  DiagnosticUnderlineWarn = { underline = true, sp = bright_yellow },
  DiagnosticUnderlineInfo = { underline = true, sp = bright_aqua },
  DiagnosticUnderlineHint = { underline = true, sp = bright_blue },
  DiagnosticUnderlineOk = { underline = true, sp = bright_green },

  ColorColumn = { bg = dark_ext1 },
  Debug = { fg = neutral_yellow },
  ["@variable"] = { fg = light2 },
  ["@variable.member"] = { fg = bright_red },
  ["@punctuation.delimiter"] = { fg = neutral_orange },
  ["@keyword.operator"] = { fg = bright_purple },
  ["@keyword.exception"] = { fg = bright_red },

  ["@markup"] = { link = "Special" },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.heading"] = { fg = bright_blue },
  ["@markup.link"] = { fg = bright_red },

  ["@markup.quote"] = { bg = dark_ext1 },
  ["@markup.list"] = { fg = bright_red },
  ["@markup.link.label"] = { fg = bright_aqua },
  ["@markup.link.url"] = { underline = true, fg = bright_orange },
  ["@markup.raw"] = { fg = bright_orange },
  -- lsp semanticTokens
  -- ["@lsp.type.macro.rust"] = { link = "@lsp" },
  ["@lsp.type.modifier.java"] = { link = "@lsp" },
  ["@lsp.type.namespace.java"] = { link = "@variable" },

  LspReferenceWrite = { fg = "#e78a4e" },
  LspReferenceText = { fg = "#e78a4e" },

  NvimTreeGitNew = { fg = neutral_yellow },
  NvimTreeFolderIcon = { fg = bright_blue },
  NvimTreeSpecialFile = { fg = neutral_yellow, bold = true },
  NvimTreeIndentMarker = { fg = "#2a2f3e" },

  Added = { fg = bright_green },
  Removed = { fg = bright_red },
  Changed = { fg = neutral_yellow },

  diffChanged = { fg = neutral_yellow },
  diffAdded = { fg = bright_green },

  BlinkCmpMenuBorder = { link = "FloatBorder" },
  BlinkCmpDocBorder = { link = "FloatBorder" },

  SnacksPickerBorder = { fg = gray_245 },
  SnacksDiffContext = { fg = nil, bg = dark_ext1 },
  SnacksDiffContextLineNr = { fg = nil, bg = dark_ext1 },

  MarkviewCode = { bg = dark_ext1 },
  MarkviewInlineCode = { bg = dark_ext1 },
})
