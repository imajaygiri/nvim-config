return {
  -- other plugins ...
  {
    'bfredl/nvim-ipy',
    -- no pip needed, conda handles jupyter
    config = function()
      vim.g.ipy_term_cmd = "jupyter console --kernel " .. (os.getenv("CONDA_DEFAULT_ENV") or "base")
    end
  }
}

