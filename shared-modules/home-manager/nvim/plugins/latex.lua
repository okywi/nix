return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                executable = "latexmk",
                args = {
                  "-pdf",
                  "-interaction=nonstopmode",
                  "-synctex=1",
                  "-outdir=pdf",
                  "-auxdir=build",
                  "%f",
                },
                onSave = true,
                forwardSearchAfter = true,
              },

              chktex = {
                onEdit = true,
                onOpenAndSave = true,
              },
            },
          },
        },
      },
    },
  },
}