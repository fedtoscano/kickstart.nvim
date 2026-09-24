-- Modalità prosa: trasforma la finestra corrente in un editor di testo minimale.
--
--  Attivazione SOLO manuale, con `:Prose` oppure <leader>z. Non si accende mai da sola:
--  scrivere codice resta esattamente com'era prima.
--
--  Il lavoro pesante lo fa zen-mode.nvim (vedi `lua/custom/plugins/prose.lua`): crea una
--  finestra centrata, applica le opzioni di finestra e le ripristina da solo alla chiusura.
--  Qui resta solo ciò che zen-mode non sa fare: il movimento per riga visiva e il markdown.

local M = {}

-- Un paragrafo di prosa è una sola riga logica lunghissima. Senza questi mapping `j` e `k`
-- saltano l'intero paragrafo invece di scendere di una riga sullo schermo.
--  Il controllo su v:count serve a non rompere i conteggi: `5j` deve restare un salto di
--  5 righe LOGICHE, come in qualsiasi altro buffer.
local motions = {
  j = function() return vim.v.count == 0 and 'gj' or 'j' end,
  k = function() return vim.v.count == 0 and 'gk' or 'k' end,
  ['0'] = 'g0',
  ['^'] = 'g^',
  ['$'] = 'g$',
}

-- Buffer su cui abbiamo messo i mapping, da ripulire all'uscita.
local touched = nil

--- Accende o spegne il rendering del markdown, ma solo se il buffer è markdown.
---  pcall: un problema del rendering non deve impedire di entrare o uscire dalla modalità.
---@param buf integer
---@param enable boolean
local function render_markdown(buf, enable)
  if vim.bo[buf].filetype ~= 'markdown' then return end
  pcall(function()
    local md = require 'render-markdown'
    vim.api.nvim_buf_call(buf, enable and md.buf_enable or md.buf_disable)
  end)
end

--- Entra in modalità prosa. Chiamata da zen-mode tramite `on_open`.
---@param win integer finestra zen appena creata
function M.on(win)
  local buf = vim.api.nvim_win_get_buf(win)
  touched = buf

  for lhs, rhs in pairs(motions) do
    -- Solo normale e visuale: in operator-pending `dj` e `yj` devono restare linewise.
    vim.keymap.set({ 'n', 'x' }, lhs, rhs, {
      buffer = buf,
      expr = type(rhs) == 'function',
      silent = true,
      desc = 'Prosa: movimento per riga visiva',
    })
  end

  render_markdown(buf, true)
end

--- Esce dalla modalità prosa. Chiamata da zen-mode tramite `on_close`.
---  Le opzioni di finestra le ripristina zen-mode: qui si ripulisce solo ciò che è buffer-local.
function M.off()
  local buf = touched
  touched = nil
  if not buf or not vim.api.nvim_buf_is_valid(buf) then return end

  for lhs, _ in pairs(motions) do
    pcall(vim.keymap.del, { 'n', 'x' }, lhs, { buffer = buf })
  end

  render_markdown(buf, false)
end

--- Accende o spegne la modalità prosa.
---  Lo stato lo tiene zen-mode, così non c'è un flag nostro da mantenere sincronizzato.
function M.toggle() require('zen-mode').toggle() end

vim.api.nvim_create_user_command('Prose', M.toggle, { desc = 'Modalità prosa: colonna centrata, a capo sulle parole, interfaccia nascosta' })
vim.keymap.set('n', '<leader>z', M.toggle, { desc = 'Modalità prosa (scrittura)' })

return M
