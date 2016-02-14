require 'json'

module Kapnismology
  class EvaluationCollection
    include Enumerable

    def initialize(test_classes)
      @smoke_tests_classes = test_classes
    end

    def each(&_block)
      evaluations.each do |member|
        yield(member)
      end
    end

    def passed?
      evaluations.all?(&:passed?)
    end

    def to_json
      evaluations.to_json
    end

    private

    def evaluations
      @evaluations ||= @smoke_tests_classes.map do |klass|
        Evaluation.new(klass)
      end
    end
  end
end
