require 'sinatra'
require 'json'
require_relative './repos/widgets'

BAD_REQUEST = 400
CREATED = 201
NOT_FOUND = 404
OK = 200

get '/' do
  Widgets.all.to_json
end

get '/widget' do
  halt_with_bad_request_if(missing_id)
  widget = Widgets.find_one(id)
  halt_if_not_found(widget)
  widget.to_json
end

post '/widget' do
  halt_with_bad_request_if(invalid_name)
  Widgets.add(name)
  status CREATED
end

put '/widget' do
  halt_with_bad_request_if(missing_params)
  widget = Widgets.update_one(id, name)
  halt_if_not_found(widget)
  status OK
end

delete '/widget' do
  halt_with_bad_request_if(missing_id)
  widget = Widgets.delete(id)
  halt_if_not_found(widget)
  status OK
end

private

def halt_with_bad_request_if condition
  halt BAD_REQUEST if condition
end

def halt_if_not_found widget
  halt NOT_FOUND if is_not_found?(widget)
end

def is_not_found? item
  item.empty?
end

def missing_params
  missing_id or invalid_name
end

def missing_id
  id.nil? or id.empty?
end

def invalid_name
  name.nil? or name.empty?
end

def id
  params[:id]
end

def name
  params[:name]
end