module KernelSpecs
  class CallerLocationsTest
    def self.locations(*args)
      caller_locations(*args)
    end
  end

  class CallerLocationsInInitialize
    @calls = []

    class << self
      attr_reader :calls

      def clear
        @calls = []
      end
    end

    def initialize
      self.class.calls << caller_locations(1, 2).map(&:label)
    end
  end

  class CallerLocationsOuter
    def call
      CallerLocationsInInitialize.new
    end
  end

  def self.caller_locations_from_initialize
    CallerLocationsInInitialize.clear
    2.times { CallerLocationsOuter.new.call }
    CallerLocationsInInitialize.calls
  end
end
