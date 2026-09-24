-- Seamless navigation between Neovim splits and tmux panes with <C-h/j/k/l>.
-- The matching tmux side lives in ~/.config/tmux/tmux.conf ("Smart pane switching").
return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<C-h>', '<cmd>TmuxNavigateLeft<cr>', mode = { 'n', 't' }, desc = 'Move focus to the left window/pane' },
      { '<C-j>', '<cmd>TmuxNavigateDown<cr>', mode = { 'n', 't' }, desc = 'Move focus to the lower window/pane' },
      { '<C-k>', '<cmd>TmuxNavigateUp<cr>', mode = { 'n', 't' }, desc = 'Move focus to the upper window/pane' },
      { '<C-l>', '<cmd>TmuxNavigateRight<cr>', mode = { 'n', 't' }, desc = 'Move focus to the right window/pane' },
    },
  },
}
