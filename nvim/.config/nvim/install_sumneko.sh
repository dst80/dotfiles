if [ -d "~/.local/.local/share/nvim/site/pack/lua_language-server" ] 
then 
    rm -rf ~/.local/.local/share/nvim/site/pack/lua_language-server
fi

git clone https://github.com/sumneko/lua-language-server ~/.local/.local/share/nvim/site/pack/lua_language-server
cd ~/.local/.local/share/nvim/site/pack/lua_language-server
git submodule update --init --recursive

cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
cd ~/
