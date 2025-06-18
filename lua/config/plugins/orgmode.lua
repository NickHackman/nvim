return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  dependencies = {
      -- https://nvim-orgmode.github.io/plugins.html
      {"michaelb/sniprun", branch = "master", build = "sh install.sh"},
  },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/Documents/org/**/*',
      org_default_notes_file = '~/Documents/org/refile.org',
    })
  end,
}
