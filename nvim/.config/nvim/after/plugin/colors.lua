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

        local constructors = {
            'TSConstructor', -- TS
        }

        local namespaces = {
            'TSNamespace', -- TS
            'pythonModule', -- python
        }

        local numbers = {
            -- TS
            'TSBoolean',
            'TSFloat',
            'TSNumber',

            'Boolean',
            'Float',
            'Number', -- VL
        }

        local functions = {
            -- TS
            'TSFunction',
            'TSFunctionCall',
            'TSFuncMacro',
            'TSMethod',
            'Function', -- VL
            'pythonfunction', -- python
            'vimFunction',
            'vimUserFunc', -- vim
        }

        local operators = {
            'TSOperator', -- TS
            'Operator', -- VL
            -- C/C++
            'cOperator',
            'cppOperator',
            'pythonoperator', -- python
        }

        local punctuations = {
            -- TS
            'TSPunctDelimiter',
            'TSPunctBracket',
            'TSPunctSpecial',
            'TSTagDelimiter',
            -- VL
            'Delimiter',
            -- vim
            'vimparensep',
            'vimsep',
            'vimbracket',
            -- sh
            'shCmdParenRegion',
            'shCmdSubRegion',
        }

        return {
            { 'TelescopeSelection', c.yellow, c.gray, s.bold },
            { 'TelescopeMatching', c.yellow, c.gray },
            { namespaces, c.yellow, c.none, cs.bold },
            { numbers, c.orange, c.none, cs.bold },
            { constructors, c.bright_cyan, c.none, cs.bold },
            { functions, c.bright_cyan, c.none, cs.bold },
            { operators, c.purple, c.none, cs.none },
            { punctuations, c.white, c.none, cs.none },
        }
    end
})
