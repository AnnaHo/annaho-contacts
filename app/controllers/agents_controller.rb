class AgentsController < ApplicationController
  before_action :find_agent, only: [:edit, :update,:destroy]

  def index
    @agents = Agent.all
  end

  def show
    @agent = Agent.find(params[:id])
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.new(agent_params)
    @agent.contacts.first.default = true
    if @agent.save
      flash[:notice] = "Agent #{@agent.name} created successfully"
      redirect_to agents_path
    else
      flash[:error] = "Fail to create agent #{@agent.name}"
      render :new
    end
  end

  def edit
  end

  def update
    if @agent.update_attributes(agent_params)
      flash[:notice] = "Update agent successfully!"
      redirect_to agents_path
    else
      flash[:error] = "Agent information update failed"
      render :edit
    end
  end

  def destroy
    @agent.destroy
    redirect_to agents_path
  end

  private

  def find_agent
    @agent = Agent.find(params[:id])
  end

  def agent_params
    params.require(:agent).permit(:name, contacts_attributes:[:id, :agent_id, :phone])
  end

end