return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    require('orgmode').setup({
      org_default_notes_file = '~/org/todo.org',
      org_agenda_files = '~/org/**/*',
    })

  end,
}
