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

              auxDirectory = "pdf", 

              chktex = {
                onEdit = true,
                onOpenAndSave = true,
              },
            },
          },
        },
        tinymist = {
          single_file_support = true,
          settings = {
            exportPdf = "onSave",
            formatterMode = "typstyle",
          },
        },
      },
    },
  },
}