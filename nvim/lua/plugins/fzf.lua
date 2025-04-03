-- lua/plugins/fzf.lua

return {
  {
    "junegunn/fzf",
    build = ":call fzf#install()",
  },
  {
    "junegunn/fzf.vim",
  },
}

