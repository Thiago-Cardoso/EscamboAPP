class BackofficeController < ApplicationController
    before_action :authenticate_admin! #verificao para autentificacao
    layout "backoffice"

    #sobreescrita do metodo
    def pundit_user
      current_admin # current_user to Pundit
    end
end
