# Public: helpers for your controllers and views.
#
module RailsAbTest
  module Helper

    # Public: renders A/B Test versions of same template/partial.
    #
    # options - hash to determine whether to render a template or a partial. Optional.
    #           If not passed it renders a template by controller.action_name. Default.
    #
    # Examples:
    #   to render a template use:
    #     render_ab template: 'template_name'
    #
    #   to render a partial, the options hash can contain more keys:
    #     render_ab partial: 'partial_name', variable: 'you name it'
    #
    def render_ab(options = {})
      if options[:partial].present?
        partial = options.delete(:partial)
        render "#{partial}_#{@ab_test}", options
      else
        template = options[:template] || action_name
        render "#{template}_#{@ab_test}"
      end
    end

  end
end
