class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

#def destroy
    #@micropost.destroy
   # flash[:success] = "Micropost deleted"
  #  redirect_to request.referrer || root_url
 # end

  def destroy
    @micropost= current_user.microposts.find(params[:id])
    if @micropost.present?
      @micropost.destroy
          flash[:success] = "Micropost deleted"
    end
      redirect_to request.referrer || root_url
end

  private

    def micropost_params
       params.require(:micropost).permit(:content, :picture)
           end

       def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
