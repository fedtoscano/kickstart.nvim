-- Plugin della modalità prosa. La logica del toggle sta in `lua/custom/prose.lua`.
--  Entrambi lazy: a vuoto non costano nulla all'avvio.
return {
  { -- Finestra centrata e senza distrazioni: il motore della modalità prosa.
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    opts = {
      window = {
        backdrop = 0.95,
        width = 80, -- larghezza della colonna di testo, in colonne
        height = 1, -- tutta l'altezza disponibile
        options = {
          -- Sono tutte window-local: vivono e muoiono con la finestra zen, quindi è
          -- impossibile che restino attaccate a un buffer di codice.
          wrap = true,
          linebreak = true, -- va a capo sulle PAROLE, non a metà parola
          number = false,
          relativenumber = false,
          signcolumn = 'no',
          cursorline = false,
          cursorcolumn = false,
          foldcolumn = '0',
          list = false,
        },
      },
      plugins = {
        -- laststatus = 0 nasconde mini.statusline.
        options = { enabled = true, ruler = false, showcmd = false, laststatus = 0 },
        tmux = { enabled = true }, -- nasconde anche la statusline di tmux
        gitsigns = { enabled = false },
        twilight = { enabled = false },
      },
      on_open = function(win) require('custom.prose').on(win) end,
      on_close = function() require('custom.prose').off() end,
    },
  },

  { -- Mostra il markdown formattato mentre scrivi: titoli, grassetto, elenchi, citazioni.
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    -- Spento di default: lo accende solo la modalità prosa, buffer per buffer.
    --  Così aprire un .md normalmente non cambia niente rispetto a prima.
    opts = { enabled = false },
  },
}
