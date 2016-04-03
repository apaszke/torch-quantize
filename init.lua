local quantize = {}

require 'nn'
require 'quantize.Module'

function quantize.fixed(integer, remainder)
   local remainder_pow = math.pow(2, remainder)
   local range = math.pow(2, remainder + integer)
   local function fixed_precision(t)
      t:mul(remainder_pow):round():clamp(-range, range):div(remainder_pow)
   end
   return fixed_precision
end

return quantize
