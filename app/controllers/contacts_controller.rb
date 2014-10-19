class ContactsController < ApplicationController

  def edit
    @agent = Agent.find(params[:agent_id])
    @contact = @agent.contacts.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update_attributes(contact_params)
      flash[:notice]="update successfully"
      redirect_to agent_path(params[:agent_id])
    else
      flash[:error]="update failed"
      render :edit
    end
  end

  def destroy
  end

  private

  def contact_params
    params.require(:contact).permit(:phone)
  end
end