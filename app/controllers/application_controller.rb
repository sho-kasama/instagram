class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
  
    # 例外バンドル
    unless Rails.env.development?
      rescue_from Exception,                        with: :_render_500
      rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
      rescue_from ActionController::RoutingError,   with: :_render_404
    end
  
    def routing_error
      raise ActionController::RoutingError, params[:path]
    end





    protected
  
      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name])
      end

      def _render_404(e = nil)
        logger.info "Rendering 404 with exception: #{e.message}" if e
    
        if request.format.to_sym == :json
          render json: { error: '404 error' }, status: :not_found
        else
          render 'errors/404', status: :not_found
        end
      end
    
      def _render_500(e = nil)
        logger.error "Rendering 500 with exception: #{e.message}" if e
        Airbrake.notify(e) if e # Airbrake/Errbitを使う場合はこちら
    
        if request.format.to_sym == :json
          render json: { error: '500 error' }, status: :internal_server_error
        else
          render 'errors/500', status: :internal_server_error
        end
      end
    end
      
end

# application コントローラーは全てのコントローラーの読み込まれる前に読み込まれるファイル