# Public: helpers for your controllers and views.
#
module RailsAbTest
  module Helper

    # Public: renders A/B Test versions of same template/partial.
    #
    # options - hash. Optional.
    #           If not passed a template render by controller.action_name is done.
    #           If passed it should has the form { partial: 'partial_name' }
    #
    # Examples
    #   render_ab partial: 'my_partial', a_variable_for_the_partial: 'xyz'
    #
    def render_ab(options = {})
      # TODO: should/can be extended to cover more render usages
      if options[:partial].present?
        partial = options.delete(:partial)
        render "#{partial}_#{@ab_test}", options
      else
        render "#{action_name}_#{@ab_test}"
      end
    end

  end
end
