local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("kide" .. name, { clear = true })
end
-- Highlight on yank
autocmd({ "TextYankPost" }, {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- https://nvchad.com/docs/recipes
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if
      line > 1
      and line <= vim.fn.line("$")
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd('normal! g`"')
    end
  end,
})

-- close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
    "fugitive",
    "git",
    "dbui",
    "dbout",
    "httpResult",
    "dap-repl",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd({ "BufReadCmd" }, {
  group = augroup("git_close_with_q"),
  pattern = "fugitive://*",
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("FileType", {
  group = augroup("close_with_q_bd"),
  pattern = {
    "oil",
    "DressingSelect",
    "dap-*",
  },
  callback = function(event)
    vim.keymap.set("n", "q", "<cmd>bd<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("spell"),
  pattern = "*.md",
  command = "setlocal spell spelllang=en_us,cjk",
})

-- outline
autocmd("FileType", {
  group = augroup("OUTLINE"),
  pattern = {
    "OUTLINE",
  },
  callback = function(_)
    vim.api.nvim_set_option_value("signcolumn", "no", { win = vim.api.nvim_get_current_win() })
  end,
})

-- LSP
local function lsp_command(bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, "LspIncomingCalls", vim.lsp.buf.incoming_calls, {
    desc = "Lsp incoming calls",
    nargs = 0,
  })
  vim.api.nvim_buf_create_user_command(bufnr, "LspOutgoingCalls", vim.lsp.buf.outgoing_calls, {
    desc = "Lsp outgoing calls",
    nargs = 0,
  })
end
autocmd("LspAttach", {
  group = augroup("lsp_a"),
  callback = function(args)
    local bufnr = args.buf
    lsp_command(bufnr)
  end,
})

autocmd("TermOpen", {
  group = augroup("close_with_q_term"),
  pattern = "*",
  callback = function(event)
    -- mac 下 t 模式执行 bd! dap 终端会导致 nvim 退出
    -- 这里使用 n 模式下执行
    if vim.b[event.buf].q_close == nil or vim.b[event.buf].q_close == true then
      vim.keymap.set("n", "q", "<cmd>bd!<cr>", { buffer = event.buf, silent = true })
    end
  end,
})

-- 延迟加载 filetype 相关的 setup，避免启动时同步 require
local lazy_ft = {
  { ft = { "java", "xml" }, mod = "kide.tools.maven", group = "lazy_maven" },
  { ft = "plantuml", mod = "kide.tools.plantuml", group = "lazy_plantuml" },
  { ft = "mermaid", mod = "kide.tools.mermaid", group = "lazy_mermaid" },
  { ft = "gitcommit", mod = "kide.gpt.commit", group = "lazy_gpt_commit" },
}
for _, spec in ipairs(lazy_ft) do
  autocmd("FileType", {
    group = augroup(spec.group),
    pattern = spec.ft,
    once = true,
    callback = function(e)
      require(spec.mod).setup()
      -- setup() 内部注册的 FileType autocmd 不会对当前 buffer 生效，
      -- 手动重放一次让其完成 per-buffer 初始化
      vim.api.nvim_exec_autocmds("FileType", { buffer = e.buf })
    end,
  })
end

-- 启动后再加载全局命令（CamelCase / Curl / GptCode），不阻塞 startup
autocmd("VimEnter", {
  group = augroup("lazy_global_tools"),
  once = true,
  callback = function()
    vim.schedule(function()
      require("kide.tools").setup()
      require("kide.tools.curl").setup()
      require("kide.gpt.code").setup()
      -- gpt.code 用 FileType * 给每个 buffer 注册 :GptCode，
      -- 给已加载的 buffer 重放一次 FileType
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype ~= "" then
          vim.api.nvim_exec_autocmds("FileType", { buffer = buf })
        end
      end
    end)
  end,
})

require("kide.melspconfig").init_lsp()
