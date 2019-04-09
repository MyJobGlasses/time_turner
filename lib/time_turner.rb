require 'version'
require 'active_support/core_ext/integer'

class TimeTurner
  # Returns random time that will act as the epoch for the class instance
  #
  # @return [Time]
  attr_reader :big_bang
  attr_reader :log

  # Initialize TimeTurner pseudo-random generator with a seed value
  #
  # @param [Integer] seed
  def initialize(seed)
    @seed = seed
    @generator = Random.new(seed)
    @big_bang = Time.at(@generator.rand(0..Time.utc(2420).to_i))
    @log = []
  end

  # Generates random value within the range provided
  # By default, returns a floating point number between 0 and 1
  #
  # @param [Range] range
  #
  # @return [Time]
  def rand(range = 0.0..1)
    time = @generator.rand(range)
    @log << { constraint: range, val: time }
    time
  end
end
