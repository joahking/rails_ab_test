# Public: helper methods for ApplicationController to generate A/B testing version.
#
module RailsAbTest
  module Controller
    extend ActiveSupport::Concern

    included do
      helper RailsAbTest::Helper
    end

    protected

    # Internal: generates the AB version, i.e. randomly (50%) "A" or "B".
    # Examples
    #   before_filter :choose_ab_test or read README for other examples.
    #
    # The version s accessible in controllers, views and helpers as @ab_test.
    #
    # For testing/QA purposes: If the parameter ab_test=A is appended to the url,
    #                          the version passed is used.
    #
    # TODO: should/can be extended to:
    # - accept different probabilities of each version to e.g. 75%, 25%
    #
    def choose_ab_test(ab_tests: ['A', 'B'])
      #TODO add cookie and configure it's usage
      @ab_test = if ab_tests.include? params[:ab_test]
                   # support to test/QA page versions
                   params[:ab_test]
                 else
                   ab_tests.sample # randomize A/B Test version
                 end
    end

  end
end
