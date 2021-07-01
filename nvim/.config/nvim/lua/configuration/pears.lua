require('pears').setup (
    function(config)
        config.on_enter(
            function(pears_handle)
                if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
                    return vim.fn["compe#confirm"]("<CR>")
                else
                    pears_handle()
                end
            end)
        config.expand_on_enter(true)
        config.preset "tag_matching"
    end)
