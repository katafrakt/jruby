module KernelSpecs
  class CallerTest
    def self.locations(*args)
      caller(*args)
    end
  end

  class CallerInInitialize
    @calls = []

    class << self
      attr_reader :calls

      def clear
        @calls = []
      end
    end

    def initialize
      self.class.calls << caller(1, 2)
    end
  end

  class CallerOuter
    def call
      CallerInInitialize.new
    end
  end

  def self.caller_from_initialize
    CallerInInitialize.clear
    2.times { CallerOuter.new.call }
    CallerInInitialize.calls
  end
end
