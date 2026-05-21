return{
  "karb94/neoscroll.nvim",
  config = function()
    require('neoscroll').setup({
      easing_function = "sine", -- feel free to try "circular" or "quartic"
      hide_cursor = false,
      stop_eof = true,
    })
  end
}

