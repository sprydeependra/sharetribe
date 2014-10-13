class RefNotExtendedError < StandardError; end

# Ref is a immutable reference to an entity defined by an id (+ subclass type).
# It always has an id and it may have a value. If it has a value
# it means the ref is already loaded. We call this an extended mode.
# Trying to access the value of a ref not loaded in extended more raises
# an error indicating a programmer mistake.
class Ref
  attr_reader :id

  def initialize(id, value = nil)
    raise ArgumentError.new("Id is a mandatory value.") if id.nil?

    @id = id
    @value = value
  end

  def value
    if (@value.nil?)
      raise RefNotExtendedError.new("The ref for id #{@id} was not loaded in extended mode.")
    end

    @value
  end

  # You can also access as ref[:id] and ref[:value]
  def [](key)
    if key == :id
      id
    elsif key == :value
      value
    end
  end

end
