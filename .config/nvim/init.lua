vim.cmd('source ~/.vimrc')

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
  })
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'christoomey/vim-tmux-navigator'
  use 'talek/obvious-resize'
  use 'ludovicchabant/vim-gutentags'
  use 'vim-scripts/ReplaceWithRegister'
  use 'tpope/vim-commentary'
  use 'tpope/vim-obsession'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'godlygeek/tabular'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'chrisbra/Colorizer'
  use 'HerringtonDarkholme/yats.vim'
  use 'maxmellon/vim-jsx-pretty'
  use 'ryanoasis/vim-devicons'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } } }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'rcarriga/cmp-dap'
  use 'folke/which-key.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

local mapopts = { noremap = true, silent = true }
local map = vim.keymap.set;

require('mason').setup()

local whichkey = require('which-key')
whichkey.setup()

-- Telescope {{{
do
  local telescope = require 'telescope';
  local actions = require 'telescope.actions'

  local ripgrep_options = {
    '--hidden',
    '--smart-case',
    '--type-add',
    'js:*.{js,ts,jsx,tsx}',
  }
  vim.opt.grepprg = (function()
    local s = 'rg --vimgrep '
    -- Need to quote some options here
    for _, opt in pairs(ripgrep_options) do
      s = s .. " '" .. opt .. "'"
    end
    return s
  end)()
  vim.api.nvim_create_user_command(
    'Rg',
    function(opts) vim.cmd('silent grep! ' .. opts.args .. ' | Telescope quickfix') end,
    { nargs = '*' }
  )

  map('n', '<Leader>F', ':Rg ', { noremap = true })
  map('n', '<Leader>l', ':Telescope live_grep<CR>', mapopts)
  map('n', '<Leader>b', ':Telescope buffers<CR>', mapopts)
  map('n', '<Leader>f', ':Telescope find_files<CR>', mapopts)
  map('n', '<Leader>r', ':Telescope lsp_document_symbols<CR>', mapopts)

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<Esc>'] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = { additional_args = function() return ripgrep_options end },
      find_files = { hidden = true },
      buffers = {
        sort_mru = true,
        sort_lastused = true,
        mappings = {
          i = {
            ['<C-s>'] = actions.select_horizontal,
            ['<C-x>'] = actions.delete_buffer,
          },
          n = {
            ['<C-s>'] = actions.select_horizontal,
            ['<C-x>'] = actions.delete_buffer,
          },
        },
      },
    },
  }
end
-- }}}

-- LSP {{{
do
  map('n', '<Leader>D', vim.diagnostic.setloclist, mapopts)
  map('n', '[d', vim.diagnostic.goto_prev, mapopts)
  map('n', ']d', vim.diagnostic.goto_next, mapopts)

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <C-x><C-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'gtd', vim.lsp.buf.type_definition, bufopts)
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', 'gh', vim.lsp.buf.hover, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('i', '<C-h>', vim.lsp.buf.signature_help, bufopts)
    map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    map('n', '<Leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map('n', '<Leader>gR', vim.lsp.buf.rename, bufopts)
    map('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
  end

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local lspconfig = require 'lspconfig'

  lspconfig['tsserver'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    handlers = {
      -- https://github.com/typescript-language-server/typescript-language-server/issues/216
      ['textDocument/definition'] = function(err, result, method, ...)
        if vim.tbl_islist(result) and #result > 1 then
          local filtered_result = {}
          for k, v in pairs(result) do
            if string.match(v.targetUri, '%.d.ts') == nil then
              table.insert(filtered_result, v)
            end
          end

          return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
        end

        vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
      end
    },
  }

  lspconfig['rust_analyzer'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig['pyright'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  lspconfig['omnisharp'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { fn.stdpath('data') .. '/mason/packages/omnisharp/omnisharp', '--languageserver' , '--hostPID', tostring(pid) },
  }

  lspconfig['sumneko_lua'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
      },
    },
  }
end
-- }}}

-- DAP {{{
do
  local dap = require 'dap'
  local dapui = require 'dapui'
  dapui.setup()

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  fn.sign_define('DapBreakpoint', { text = '🅱', texthl = '', linehl = '', numhl = '' })
  fn.sign_define('DapBreakpointCondition', { text = '❓', texthl = '', linehl = '', numhl = '' })
  fn.sign_define('DapStopped', { text = '🥨', texthl = 'ColorColumn', linehl = 'ColorColumn', numhl = '' })

  require('telescope').load_extension('dap')

  whichkey.register({
   ['<Leader>d'] = { name = 'Debugger' },
   ['<Leader>db'] = { name = 'Breakpoints' },
   ['<Leader>dbb'] = { dap.toggle_breakpoint, 'Toggle Breakpoint' },
   ['<Leader>dbc'] = {
     function() dap.set_breakpoint(fn.input('Breakpoint condition: ')) end,
     'Set Conditional Breakpoint'
   },
   ['<Leader>dbl'] = { dap.list_breakpoints, 'List Breakpoints' },
   ['<Leader>dbC'] = { dap.clear_breakpoints, 'Clear All Breakpoints' },
   ['<Leader>dc'] = { dap.continue, 'Continue' },
   ['<Leader>dC'] = { dap.run_to_cursor, 'Continue to Cursor' },
   ['<Leader>dh'] = { dapui.eval, 'Eval Expression' },
   ['<Leader>do'] = { dap.step_over, 'Step Over' },
   ['<Leader>di'] = { dap.step_into, 'Step Into' },
   ['<Leader>dI'] = { dap.step_out, 'Step Out' },
   ['<Leader>dk'] = { dap.up, 'Stacktrace Up' },
   ['<Leader>dj'] = { dap.down, 'Stacktrace Down' },
   ['<Leader>dr'] = { dap.repl.open, 'Repl' },
   ['<Leader>dt'] = { ':Telescope dap ',  'Telescope dap', silent = false },
  })
  map('v', '<Leader>dh', dapui.eval, mapopts);

  dap.adapters.node2 = {
    type = 'executable',
    command = fn.stdpath('data') .. '/mason/packages/node-debug2-adapter/node-debug2-adapter',
  }
  local js_configs = {
    {
      name = 'Node Launch File',
      type = 'node2',
      request = 'launch',
      program = '${file}',
    },
    {
      name = 'Node Attach',
      type = 'node2',
      request = 'attach',
    },
  }
  dap.configurations.javascript = js_configs;
  dap.configurations.typescript = js_configs;

  dap.adapters.netcoredbg = {
    type = 'executable',
    command = fn.stdpath('data') .. '/mason/packages/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' },
  }
  dap.configurations.cs = {
    {
      name = 'Attach',
      type = 'netcoredbg',
      request = 'attach',
      processId = require('dap.utils').pick_process,
    }
  }

  dap.adapters.codelldb = {
    type = 'server',
    port = '${port}',
    host = '127.0.0.1',
    executable = {
      command = fn.stdpath('data') .. '/mason/packages/codelldb/extension/adapter/codelldb',
      args = {
        '--liblldb', fn.stdpath('data') ..'/mason/packages/codelldb/extension/lldb/lib/liblldb.so',
        '--port', '${port}',
      },
    },
  }
  dap.configurations.rust = {
    {
      name = 'Launch File',
      type = 'codelldb',
      request = 'launch',
      cwd = '${workspaceFolder}',
      program = function()
        local cwd = vim.fn.getcwd()
        local dirname = vim.fn.fnamemodify(cwd, ':t')
        return cwd .. '/target/debug/' .. dirname
      end,
      args = {},
    }
  }
end
-- }}}

-- CMP / LuaSnip {{{
do
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  luasnip.filetype_extend('javascriptreact', { 'javascript' })
  luasnip.filetype_extend('typescript', { 'javascript' })
  luasnip.filetype_extend('typescriptreact', { 'javascript' })
  require('luasnip.loaders.from_snipmate').lazy_load()

  local next_item_mapping = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expandable() then
      luasnip.expand()
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { 'i', 's' });

  local prev_item_mapping = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { 'i', 's' })

  cmp.setup({
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }),
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    enabled = function()
      return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt'
        or require('cmp_dap').is_dap_buffer()
    end,
    completion = { autocomplete = false },
    mapping = {
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<Tab>'] = next_item_mapping,
      ['<S-Tab>'] = prev_item_mapping,
      ['<C-n>'] = next_item_mapping,
      ['<C-p>'] = prev_item_mapping,
      ['<C-a>'] = cmp.mapping.complete(),
    },
  })

  cmp.setup.filetype({ 'dap-repl', 'dapui_watches' }, {
    sources = {
      { name = 'dap' },
    },
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
end
-- }}}

-- Vim-Airline {{{
vim.g.airline_theme = 'custom_base16_monokai'
vim.g.airline_powerline_fonts = 0
vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#show_buffers'] = 1
vim.g['airline#extensions#tabline#show_tabs'] = 1
vim.g['airline#extensions#tabline#show_tab_count'] = 1
vim.g['airline#extensions#tabline#tab_nr_type'] = 1 -- Tab number
vim.g['airline#extensions#tabline#tabnr_formatter'] = 'tabnr'
vim.g['airline#extensions#tabline#show_tab_nr'] = 1
vim.g['airline#extensions#tabline#show_tab_type'] = 0
vim.g['airline#extensions#tabline#buf_label_first'] = 0
vim.g['airline#extensions#tabline#buffer_idx_mode'] = 1
vim.g['airline#extensions#tabline#buffer_nr_show'] = 0
vim.g['airline#extensions#tabline#show_splits'] = 0
vim.g['airline#extensions#tabline#show_close_button'] = 0
vim.g['airline#extensions#tabline#fnamemod'] = ':t'
vim.g.airline_section_z = '%l:%c'
-- Move section b, the git branch, to the right side
vim.g['airline#extensions#default#layout'] = {
  { 'a', 'c' },
  { 'b', 'x', 'y', 'z', 'error', 'warning' },
}
-- Truncate the status mode to one capital letter
vim.g.airline_mode_map = {
  ['__'] = '-',
  ['n']  = 'N',
  ['i']  = 'I',
  ['R']  = 'R',
  ['c']  = 'C',
  ['v']  = 'V',
  ['V']  = 'V',
  ['^V'] = 'V',
  ['s']  = 'S',
  ['S']  = 'S',
  ['^S'] = 'S',
}
map('n', '<Tab>', '<Plug>AirlineSelectNextTab', mapopts)
map('n', '<S-Tab>', '<Plug>AirlineSelectPrevTab', mapopts)
map('n', '<Leader>1', '<Plug>AirlineSelectTab1', mapopts)
map('n', '<Leader>2', '<Plug>AirlineSelectTab2', mapopts)
map('n', '<Leader>3', '<Plug>AirlineSelectTab3', mapopts)
map('n', '<Leader>4', '<Plug>AirlineSelectTab4', mapopts)
map('n', '<Leader>5', '<Plug>AirlineSelectTab5', mapopts)
map('n', '<Leader>6', '<Plug>AirlineSelectTab6', mapopts)
map('n', '<Leader>7', '<Plug>AirlineSelectTab7', mapopts)
map('n', '<Leader>8', '<Plug>AirlineSelectTab8', mapopts)
map('n', '<Leader>9', '<Plug>AirlineSelectTab9', mapopts)
-- }}}

-- Obvious-Resize' {{{
map('n', '<S-Up>', ':<C-U>ObviousResizeUp 5<CR>', mapopts)
map('n', '<S-Down>', ':<C-U>ObviousResizeDown 5<CR>', mapopts)
map('n', '<S-Left>', ':<C-U>ObviousResizeLeft 5<CR>', mapopts)
map('n', '<S-Right>', ':<C-U>ObviousResizeRight 5<CR>', mapopts)
-- }}}

-- Vim-Commentary
-- Comment lines with '/' (registers as '_')
map({ 'n', 'v' }, '<C-_>', ':Commentary<CR>', mapopts)

-- Gutentags
vim.g.gutentags_file_list_command = "rg --files --ignore-file $HOME/.ignore --glob '!*.json' --glob !'*.yaml'"

-- Colorizer
vim.api.nvim_create_user_command('CH', 'ColorHighlight', { nargs = 0 })

-- Vim-Obsession session saving & session loading {{
map('n', '<Leader>O', ':Obsess<Space>~/.config/nvim/sessions/', { noremap = true })
map('n', '<Leader>o', ':so<Space>~/.config/nvim/sessions/', { noremap = true })
vim.api.nvim_create_user_command('SessionEcho', 'echo v:this_session', { nargs = 0 })
-- }}}
