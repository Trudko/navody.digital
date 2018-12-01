require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe Admin::TasksController, type: :controller do
  include AdminAuthHelper

  before(:each) do
    admin_http_login
  end

  # This should return the minimal set of attributes required to create a valid
  # Task. As you add validations to Task, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    build(:task).attributes
  }

  let(:invalid_attributes) {
    build(:task, title: '').attributes
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TasksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      task = Task.create!(valid_attributes)
      get :index, params: {journey_id: task.step.journey.id, step_id: task.step.id}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      task = Task.create! valid_attributes
      get :show, params: {journey_id: task.step.journey.id, step_id: task.step.id, id: task.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      step = create(:step)
      get :new, params: {journey_id: step.journey.id, step_id: step.id}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      task = Task.create! valid_attributes
      get :edit, params: {journey_id: task.step.journey.id, step_id: task.step.id, id: task.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        step = create(:step)
        expect {
          post :create, params: {journey_id: step.journey.id, step_id: step.id, task: valid_attributes}, session: valid_session
        }.to change(Task, :count).by(1)
      end

      it "redirects to the created task" do
        step = create(:step)
        post :create, params: {journey_id: step.journey.id, step_id: step.id, task: valid_attributes}, session: valid_session

        task = Task.last
        expect(response).to redirect_to(admin_journey_step_task_url(task.step.journey, task.step, task))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        step = create(:step)
        post :create, params: {journey_id: step.journey.id, step_id: step.id, task: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          title: 'Foo bar'
        }
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        put :update, params: {journey_id: task.step.journey.id, step_id: task.step.id, id: task.to_param, task: new_attributes}, session: valid_session
        task.reload
        expect(task.title).to eq 'Foo bar'
      end

      it "redirects to the task" do
        task = Task.create! valid_attributes
        put :update, params: {journey_id: task.step.journey.id, step_id: task.step.id, id: task.to_param, task: valid_attributes}, session: valid_session
        expect(response).to redirect_to(admin_journey_step_task_url(task.step.journey, task.step, task))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        task = Task.create! valid_attributes
        put :update, params: {journey_id: task.step.journey.id, step_id: task.step.id, id: task.to_param, task: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete :destroy, params: {journey_id: task.step.journey.id, step_id: task.step.id, id: task.to_param}, session: valid_session
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      task = Task.create! valid_attributes
      delete :destroy, params: {journey_id: task.step.journey.id, step_id: task.step.id, id: task.to_param}, session: valid_session
      expect(response).to redirect_to(admin_journey_step_tasks_url(task.step.journey, task.step))
    end
  end

end
