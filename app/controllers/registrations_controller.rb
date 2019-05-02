class RegistrationsController < Devise::RegistrationsController

    protected
  
    def update_resource(resource, params)
      resource.update_without_current_password(params)
    end

    # after_update_path_for メソッドはDeviseが用意してくれているメソッドです。
    # アカウントをアップデートさせたあと、どのパスに還移させるかを指定することができる
    def after_update_path_for(resource)
        user_path(resource)
    end

  end