package = "quantize"
version = "0.1-1"
source = {
   url = "https://github.com/apaszke/torch-quantize"
}
dependencies = {
   "torch",
}
build = {
   type = "builtin",
   modules = {
       ["quantize.init"]     = "init.lua",
       ["quantize.Module"]   = "Module.lua",
   }
}
