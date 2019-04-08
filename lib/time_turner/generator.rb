require 'active_support/core_ext/integer'

module TimeTurner
  class Generator
    def initialize(seed)
      @seed = seed
      @rng = Random.new(seed)
      @big_bang = Time.at(@rng.rand(0..Time.utc(2420).to_i))
      @log = []
    end

    # Returns random time that will act as the epoch for the class instance
    #
    # @return [Time]
    attr_reader :big_bang
    attr_reader :log

    # Generates random value within the range provided
    # By default, returns a floating point number between 0 and 1
    #
    # @param [Range] range
    #
    # @return [Time]
    def rand(range = 0.0..1)
      time = @rng.rand(range)
      @log << { constraint: range, val: time }
      time
    end
  end
end
