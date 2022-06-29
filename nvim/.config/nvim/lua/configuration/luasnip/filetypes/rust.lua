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
    --type structure
    snippet(on("struct"),
        format("struct {} {{\n\t{}\n}}", {
            insert(1, "Name"),
            insert(0)
        })),
    snippet(on("let"),
        format("let {} = {}", {
            insert(1, "param"),
            insert(0, "object")
        })),
    snippet(on("enum"),
        format("enum {} {{\n\t{}\n}}", {
            insert(1, "Name"),
            insert(0),
        })),
    snippet(on("params"),
        format("{} : {}", {
            insert(1, "param"),
            insert(2, "Type")
        })),
    -- function closure, traits
    snippet(on("main"),
        format("fn main() {{\n\t{}\n}}", insert(0))),
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
    snippet(on("trait"),
        format("trait {} {{\n\t{}\n}}", {
            insert(1, "Name"),
            insert(0)
        })),
    snippet(on("impl"),
        format("impl {} for {} {{\n\t{}\n}}", {
            insert(1, "Trait"),
            insert(2, "Name"),
            insert(0)
        })),

    --loops
    snippet(on("for"),
        format("for {} in {} {{\n\t{}\n}}", {
            insert(1),
            insert(2),
            insert(0)
        })),
    snippet(on("while"),
        format("while {} {{\n\t{}\n}}", {
            insert(1, ""),
            insert(0, "")
        })),

    -- conditional branching
    snippet(on("if"),
        format("if {} {{\n\t{}\n}}", {
            insert(1, ""),
            insert(0)
        })),
    snippet(on("else"),
        format("else {}{{\n\t{}\n}}", {
            insert(1, ""),
            insert(0)
        })),
    snippet(on("match"),
        format("match {} {{\n\t{}}};", {
            insert(1, "matcher"),
            insert(0)
        })),
    -- unsafe
    snippet(on("unsafe"),
        format("unsafe {{\n\t{}\n}}", insert(0))),

    -- Result and error
    snippet(on("Result"),
        format("Result<{}, {}>{}", {
            insert(1, "Type"),
            insert(2, "Error"),
            insert(0)
        })),
    snippet(on("Ok"),
        format("Ok({}){},", {
            insert(1, "value"),
            insert(0)
        })),
    snippet(on("Err"),
        format("Err({}){}", {
            insert(1, "err"),
            insert(0)
        })),
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

    --smart pointer creation
    snippet(on("box"),
        format("Box:new({}){}", {
            insert(1),
            insert(0)
        })),
    snippet(on("rc"),
        format("Rc:new({}){}", {
            insert(1),
            insert(0)
        })),
    snippet(on("arc"),
        format("Arc:new({}){}", {
            insert(1),
            insert(0)
        })),
    snippet(on("cell"),
        format("Cell::new({}){}", {
            insert(1),
            insert(0)
        })),
    snippet(on("refcell"),
        format("RefCell::new({}){}", {
            insert(1),
            insert(0)
        })),
    --attributeglobal_allocator
    snippet(on("derive"),
        format("#[derive({})]{}", {
            insert(1, "PartialEq"),
            insert(0),
        })),

    snippet(on("glballo"),
        format("#[GlobalAllocator]{}", {
            insert(0),
        })),
    --common traits
    snippet(on("partialeq"),
        format("impl PartialEq for {} {{\n\tfn eq(&self, other: &self) -> bool {{\n\t{}\n\t}}\n}}", {
            insert(1, "Type"),
            insert(0)
        })),
    snippet(on("ord"),
        format("impl Ord for {} {{\n\tfn cmp(&self, other: &self) -> Ordering {{\n\t{}\n\t}}\n}}", {
            insert(1, "Type"),
            insert(0)
        })),
    snippet(on("parialord"),
        format("impl PartialOrd for {} {{\n\tfn partial_cmp(&self, other: &self) -> Option<Ordering> {{\n\t{}\n\t}}\n}}", {
            insert(1, "Type"),
            insert(0)
        })),
        snippet(on("drop"),
        format("impl Drop for {} {{\n\tfn drop(&mut self) {{\n\t{}\n\t}}\n}}", {
            insert(1, "Type"),
            insert(0)
        })),
    snippet(on("asref"),
        format("impl AsRef<{}> for {} {{\n\tfn as_ref(&self) -> &{} {{\n\t&self.{}\n\t}}\n}}", {
            insert(1, "Ref"),
            insert(2, "Type"),
            same_as(1),
            insert(0, "a_field")
        })),
    snippet(on("asmut"),
        format("impl AsMut<{}> for {} {{\n\tfn as_mut(&self) -> &mut {} {{\n\t&mut self.{}\n\t}}\n}}", {
            insert(1, "Ref"),
            insert(2, "Type"),
            same_as(1),
            insert(0, "a_field")
        })),
    --testing
    snippet(on("modtest"),
        format("#[cfg(test)]\nmod test {{\n\tuse super::*;\n{}\n}}", insert(0))),
    snippet(on("test"),
        format("#[test]\nfn {}() {} {{\n\t{}\n}}", {
            insert(1, "testname"),
            insert(2, ""),
            insert(0)
        })),
    snippet(on("assert_eq"),
        format("assert_eq!({}, {});{}", {
            insert(1),
            insert(2),
            insert(0)
        })),
})
