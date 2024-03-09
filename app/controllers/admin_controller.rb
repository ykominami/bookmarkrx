class AdminController < ApplicationController
  before_action :set_pathx, only: %i[ show edit update destroy look look2 ]
end
