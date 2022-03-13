require('nordic').colorscheme({
    -- Underline style used for spelling
    -- Options: 'none', 'underline', 'undercurl'
    underline_option = 'undercurl',

    -- Italics for certain keywords such as constructors, functions,
    -- labels and namespaces
    italic = true,

    -- Italic styled comments
    italic_comments = true,

    -- Minimal mode: different choice of colors for Tabs and StatusLine
    minimal_mode = false,

    -- Darker backgrounds for certain sidebars, popups, etc.
    -- Options: true, false, or a table of explicit names
    -- Supported: terminal, qf, vista_kind, packer, nvim-tree, telescope, whichkey
    alternate_backgrounds = true,

    -- Callback function to define custom color groups
    -- See 'lua/nordic/colors/example.lua' for example defitions
    custom_colors = function(c, s, cs)
      return {
        { 'TelescopeSelection', c.yellow, c.gray, s.bold },
        { 'TelescopeMatching', c.yellow, c.gray },
      }
    end
})