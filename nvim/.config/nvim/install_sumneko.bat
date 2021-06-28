git clone https://github.com/sumneko/lua-language-server "%AppData%\nvim-data\site\pack\lua-language-server"
cd "%AppData%\nvim-data\site\pack\lua-language-server"
git submodule update --init --recursive

cd 3rd\luamake
compile\install.bat
cd ..\..
3rd\luamake\luamake.exe rebuild