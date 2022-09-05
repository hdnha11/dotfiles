local opts = {
  settings = {
    gopls = {
      buildFlags = {
        '-tags=integration,wireinject,goleak'
      },
    },
  },
}

return opts
