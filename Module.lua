local function quantize_weights(self)
   if self.weight then
      self.qweight:copy(self.weight)
      self.quantizer(self.qweight)
   end
   if self.bias then
      self.qbias:copy(self.bias)
      self.quantizer(self.qbias)
   end
end

local function swap_weights(self)
   local tmp = self.weight
   self.weight = self.qweight
   self.qweight = tmp

   tmp = self.bias
   self.bias = self.qbias
   self.qbias = self.bias
end

local function quantized_updateOutput(self, ...)
   quantize_weights(self)
   swap_weights(self)
   local ret = self:_updateOutput(...)
   swap_weights(self)
   return ret
end

local function quantized_updageGradInput(self, ...)
   swap_weights(self)
   local ret = self:_updateGradInput(...)
   swap_weights(self)
   return ret
end

local function quantized_updateGradParameters(self, ...)
   swap_weights(self)
   local ret = self:_updateGradParameters(...)
   swap_weights(self)
   return ret
end

function nn.Module:quantize(quantizer)
   self.quantizer = quantizer

   -- override functions
   self._updateOutput = self.updateOutput
   self.updateOutput = quantized_updateOutput
   self._updateGradInput = self.updateGradInput
   self.updateGradInput = quantized_updageGradInput
   self._updateGradParameters = self.updateGradParameters
   self.updateGradParameters = quantized_updateGradParameters

   if self.weight then
      self.qweight = self.qweight or self.weight:clone()
      quantizer(self.qweight)
   end
   if self.bias then
      self.qbias = self.qbias or self.bias:clone()
      quantizer(self.qbias)
   end

   if self.modules then
      for i,submodule in ipairs(self.modules) do
         submodule:quantize(quantizer)
      end
   end
end
