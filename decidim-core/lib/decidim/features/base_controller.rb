# frozen_string_literal: true

module Decidim
  module Features
    # Controller from which all feature engines inherit from. It's in charge of
    # setting the appropiate layout, including necessary helpers, and overall
    # fooling the engine into thinking it's isolated.
    class BaseController < Decidim::ApplicationController
      layout "layouts/decidim/participatory_process"
      include NeedsParticipatoryProcess
      helper Decidim::TranslationsHelper
      helper Decidim::ParticipatoryProcessHelper
      helper_method :current_feature

      skip_authorize_resource

      before_action do
        authorize! :read, current_participatory_process
      end

      def current_feature
        request.env["decidim.current_feature"]
      end

      private

      def current_participatory_process
        request.env["decidim.current_participatory_process"]
      end
    end
  end
end
