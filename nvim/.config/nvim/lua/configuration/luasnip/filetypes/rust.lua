local luasnip = require('luasnip')
local snippet_collection = require('luasnip.session.snippet_collection')
local format = require('luasnip.extras.fmt').fmt

local snippet = luasnip.s
local insert = luasnip.insert_node
local text = luasnip.text_node
local choice = luasnip.choice_node

local function_node = luasnip.function_node

local same_as = function(index)
    return function_node(function(args)
        return args[1]
    end, { index })
end

local on = function(trigger)
    return { trig = trigger, wordTrig = true }
end

luasnip.add_snippets("rust", {
    -- function closure, traits
    snippet(on("fn"),
        format("fn {}({}) {}{{\n\t{}\n}}", {
            insert(1, "name"),
            insert(2, ""),
            choice(3, {
                text "",
                format("-> {} ", insert(1, "i32")),
            }),
            insert(0)
        })),
    snippet(on("|"),
        format("{} |{}| {{\n\t{}\n}}", {
            insert(1, "move"),
            insert(2, ""),
            insert(0)
        })),
    snippet(on("ctor"),
        format("pub fn new({}) -> {} {{\n\t{}{{ {} }}\n}}", {
            insert(1, ""),
            insert(2, ""), -- autosnippet detect impl in text before
            same_as(2),
            insert(0, "")
        })),
    snippet(on("extern"),
        format("extern {}", choice(1) {
            format("crate {};", insert(1, "some_crate")),
            format("\"C\" {}", insert(1, "")),
        })),
    -- Result and error
    snippet(on("matchresult"),
        format("match {} {{\n\tOk({}) => {},\n\t{}{}\n}}", {
            insert(1, "Result"),
            insert(2, "value"),
            insert(3, "DoSomethingWithTheResult"),
            choice(4, {
                format("Err({}) => return Err({})", {
                    insert(1),
                    same_as(1)
                }),
                format("Err({}) => {},", {
                    insert(1, "error"),
                    insert(2, "OwnErrorHandling"),
                }),
                format("Err({}) => panic!(\"{} {{:?}}\",{})", {
                    insert(1, "error"),
                    insert(2, "Some error occured"),
                    same_as(1),
                }),
                format("Err({}) => println!(\"{} {{?:}}\", {})", {
                    insert(1, "error"),
                    insert(2, "Some error occured"),
                    same_as(1),
                })
            }),
            insert(0)
        })),
})
