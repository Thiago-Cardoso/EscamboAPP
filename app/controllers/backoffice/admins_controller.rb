class Backoffice::AdminsController < BackofficeController
    before_action :set_admin, only: [:edit, :update, :destroy]
    after_action :verify_authorized, only: :new
    after_action :verify_policy_scoped, only: :index
  def index
    #@admins = Admin.all
    #@admins = Admin.with_full_access
    @admins = policy_scope(Admin)
  end
  def new
      @admin = Admin.new
      authorize @admin
  end
  def create
    @admin = Admin.new(params_admin)
    if @admin.save
        redirect_to backoffice_admins_path, notice: "O Administrador (#{@admin.email}) foi cadastrado com sucesso!"
    else
        render:new
    end
  end
  def edit
      
  end

  def update
    passwd = params[:admin][:password]
    passwd_confirmation = params[:admin][:password_confirmation]

    #se o password e o password_confirmation estiver em branco - apaga
    if passwd.blank? && passwd_confirmation.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admin.update(params_admin)
        AdminMailer.update_email(current_admin, @admin).deliver_now
        redirect_to backoffice_admins_path, notice: "O Administrador  (#{@admin.email}) foi atualizado com sucesso! "
    else
        render:edit
    end
  end

  def destroy
    authorize @admin
    admin_name = @admin.name
   if @admin.destroy
        redirect_to backoffice_admins_path, notice: "O Administrador  (#{@admin.email}) foi excluido com sucesso! "
    else
        render:index
    end
  end

  private
  def set_admin
    @admin = Admin.find(params[:id])
  end

  private
  def params_admin
    params.require(:admin).permit(policy(@admin).permitted_attributes)
  end

end
