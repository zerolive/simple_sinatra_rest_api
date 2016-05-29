require 'spec_helper'
require 'json'

describe 'Simple app' do

  before do
    Widgets.reset
  end

  context 'GET /' do

    it 'returns with the list of witgets' do
      widgets = [{ :id => 1, :name => "First Widget"}, { :id => 2, :name => "Second Widget"}]

      get '/'

      expect(last_response.body).to eq(widgets.to_json)
      expect(last_response.status).to eq 200
    end
  end

  context 'POST /widget' do
    describe 'with a name param' do
      it "adds a new widget" do
        widget_name = "Third widget"

        post '/widget', { name: "Third widget" }

        expect(last_response.status).to eq 201
      end
    end

    describe 'with missing name param' do
      it "retrieves bad request" do
        widget_name = "Third widget"

        post '/widget'

        expect(last_response.status).to eq 400
      end
    end

    describe 'with empty name param' do
      it "retrieves bad request" do
        widget_name = "Third widget"

        post '/widget', { name: "" }

        expect(last_response.status).to eq 400
      end
    end
  end

  context 'GET /widget' do

    describe 'with right params' do
      it 'returns a specific widget with an id' do
        widget = { :id => 1, :name => "First Widget"}

        get '/widget', { :id => 1 }

        expect(last_response.body).to eq(widget.to_json)
      end

      it 'returns a different widget with another id' do
        widget = { :id => 2, :name => "Second Widget"}

        get '/widget', { :id => 2 }

        expect(last_response.body).to eq(widget.to_json)
      end
    end

    describe 'with missing id param' do
      it "retrieves bad request" do

        get '/widget'

        expect(last_response.status).to eq(400)
      end
    end

    describe 'with empty id param' do
      it "retrieves bad request" do

        get '/widget', { id: '' }

        expect(last_response.status).to eq(400)
      end
    end

    describe 'with non-existent id' do
      it "responses with a not found request" do

        get '/widget', { id: :id }

        expect(last_response.status).to eq(404)
      end
    end
  end

  context 'PUT /widget' do

    describe 'with right params' do
      it "updates the name of widget" do

        put '/widget', {  :id => 1, :name => "new name" }

        expect(last_response.status).to eq 200
      end
    end

    describe 'with missing id param' do
      it 'responses with a bad request' do

        put 'widget', { name: "new name" }

        expect(last_response.status).to eq 400
      end
    end

    describe 'with missing name param' do
      it 'responses with a bad request' do

        put 'widget', { id: 1 }

        expect(last_response.status).to eq 400
      end
    end

    describe 'with empty id param' do
      it 'responses with a bad request' do

        put 'widget', { id: '', name: "new name" }

        expect(last_response.status).to eq 400
      end
    end

    describe 'with empty name param' do
      it 'responses with a bad request' do

        put 'widget', { id: 1, name: "" }

        expect(last_response.status).to eq 400
      end
    end

    describe 'with non-existent id' do
      it 'responses with a not found request' do

        put 'widget', { id: :id, name: "new_name" }

        expect(last_response.status).to eq 404
      end
    end
  end

  context 'DELETE /widget' do

    describe 'with an existent id' do
      it "deletes a widget" do

        delete '/widget', { id: 2 }

        expect(last_response.status).to eq 200
      end
    end

    describe 'with non-existent id' do
      it 'responses with a not found request' do

        delete '/widget', { id: :id }

        expect(last_response.status).to eq 404
      end
    end

    describe 'with missing id param' do
      it 'responses with a bad request' do

        delete '/widget'

        expect(last_response.status).to eq 400
      end
    end

    describe 'with empty id param' do
      it 'responses with a bad request' do

        delete '/widget'

        expect(last_response.status).to eq 400
      end
    end
  end
end