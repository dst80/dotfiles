cd ~
sumneko_dir=".local/share/nvim/site/pack/lua_language-server/"

if [ -d "$sumneko_dir" ] 
then 
    rm -rf "$sumneko_dir"
fi

git clone https://github.com/sumneko/lua-language-server "$sumneko_dir"
cd "$sumneko_dir"
git submodule update --init --recursive

cd 3rd/luamake
compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild
cd ~/
