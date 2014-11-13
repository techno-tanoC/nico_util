# coding: utf-8

module NicoUtil::Hashable
  def to_hash_by_public_send(arr)
    to_hash_by_process(arr) do |sym|
      public_send(sym)
    end
  end

  def to_hash_by_instance_variables(arr)
    to_hash_by_process(arr) do |sym|
      instance_variable_get(sym)
    end
  end

  def to_hash_by_process(arr)
    vars =
      if arr.nil? or arr.empty?
        instance_variables.map do |sym|
          (sym.to_s).delete('@').to_sym
        end
      else
        arr
      end
    vars.map {|sym|
      [sym, yield(sym)]
    }.to_h
  end
end
