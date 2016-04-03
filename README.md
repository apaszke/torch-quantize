## quantize

This package allows to train regular torch neural networks with quantized weights.

## How to use it?

```lua
local q = require 'quantize'
model:quantize(q.fixed(1, 4))
```

To enable call `:quantize()` on a model and pass a quantizer function. For now
there's one provided with the package.

`q.fixed(integer, reminder)` rounds all weights to
a range representable using `integer` bits for integer part and `reminder` bits for
remainder part (it also adds one implicit bit for the sign).
