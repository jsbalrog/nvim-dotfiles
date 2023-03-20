-- [[ Configure neo-tree ]]
require('neo-tree').setup({
  event_handlers = {
    {
      event = 'file_opened',
      handler = function(file_path)
        -- auto-close
        require('neo-tree').close_all()
      end
    },
  }
})
