class Profile::BaseController < ApplicationController
  before_action :require_user
end
