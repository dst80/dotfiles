git clone https://github.com/sumneko/lua-language-server "%LocalAppData%\nvim-data\site\pack\lua-language-server"
cd "%LocalAppData%\nvim-data\site\pack\lua-language-server"
git submodule update --init --recursive

cd 3rd\luamake
compile\install.bat
cd ..\..
3rd\luamake\luamake.exe rebuild