# coding: utf-8

module NicoUtil::AttrSetter
  def attr_setter(sym, val = nil, &block)
    val = yield sym if block_given?
    instance_variable_set('@' + sym.to_s, val)
    self.class.class_eval do |_|
      attr_reader sym
    end
  end

  def arr_setter(syms)
    syms.each do |sym|
      val = yield sym
      instance_variable_set('@' + sym.to_s, val)
    end
    self.class.class_eval do |_|
      syms.each do |sym|
        attr_reader sym
      end
    end
  end
end
