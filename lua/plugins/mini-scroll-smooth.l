return{
  "echasnovski/mini.animate",
  version = false,
  config = function()
    require("mini.animate").setup({
      scroll = {
        enable = true,
        timing = require("mini.animate").gen_timing.linear({ duration = 150, unit = "total" }),
      }
    })
  end
}

