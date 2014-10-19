class ContactsController < ApplicationController
  before_action :find_contact, :only=>[:edit, :update, :destroy]

  def new
    @agent = Agent.find(params[:agent_id])
    @contact = @agent.contacts.new
  end

  def create
    @agent = Agent.find(params[:agent_id])
    @contact = @agent.contacts.new(contact_params)
    if @contact.save
      flash[:notice]="create new contact successfully"
      redirect_to agent_path(@agent)
    else
      flash[:error]="create new contact failed"
      render :new
    end
  end

  def edit
    @agent = Agent.find(params[:agent_id])
  end

  def update
    update_default_contact
    if @contact.update_attributes(contact_params)
      flash[:notice]="update successfully"
      redirect_to agent_path(params[:agent_id])
    else
      flash[:error]="update failed"
      render :edit
    end
  end

  def destroy
    @contact.delete
    redirect_to agent_path(params[:agent_id])
  end

  private
  
  def update_default_contact
    @agent = Agent.find(params[:agent_id])
    default_contact = @agent.contacts.where(default: true).first
    if @contact.id != default_contact.id && params[:contact][:default]=="1"
      default_contact.default = false
      @contact.default = true
      default_contact.save
      @contact.save
    end
  end

  def find_contact
    @contact = Contact.find(params[:id])  
  end

  def contact_params
    params.require(:contact).permit(:phone)
  end
end