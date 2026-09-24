-- Temi minimal / low-color.
-- Provali al volo con `:colorscheme <nome>` oppure dal picker Telescope
-- (`:Telescope colorscheme`). Il default si imposta nel blocco tokyonight in init.lua.
return {
  -- vague: grigio/blu desaturato, contrasto basso, molto riposante. Nome: `vague`
  { 'vague2k/vague.nvim', lazy = false, priority = 1000, opts = {} },

  -- no-clown-fiesta: pensato apposta per usare pochissimi colori, quasi monocromo
  -- con accenti tenui. Nome: `no-clown-fiesta`
  { 'aktersnurra/no-clown-fiesta.nvim', lazy = false, priority = 1000 },

  -- gruber-darker: classico, ~6 colori caldi su fondo scuro. Nome: `gruber-darker`
  { 'blazkowolf/gruber-darker.nvim', lazy = false, priority = 1000, opts = {} },

  -- zenbones/zenwritten: praticamente monocromo (richiede lush).
  -- Nomi: `zenbones`, `zenwritten`, `neobones`, `nordbones`, ...
  {
    'mcchrish/zenbones.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
  },
}
