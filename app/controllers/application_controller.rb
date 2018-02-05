class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :city,
                                                       :facebook, :twitter])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :city,
                                                              :facebook,
                                                              :twitter])
  end

  private

  def require_login
    if user_signed_in?
      if current_user.id != @recipe.user_id
        flash[:alert] = 'Você não pode editar receitas enviadas por outros
                        usuários.'
        redirect_to root_path
      end
    else
      flash[:alert] = 'Acesso negado! Você precisa estar logado.'
      redirect_to root_path
    end
  end
end
