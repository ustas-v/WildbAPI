# frozen_string_literal: true

class MainController < ApplicationController
  ## Modules, constants
  ## Helpers
  ## Before, after and other filters

  before_action :fetch_index_data, only: [:index]

  ## Loading and authorize resource(s)
  ## Decorate resource(s)
  ## Responders

  ## Actions

  def index; end

  ## Protected methods
  ## Callbacks before, after, other filters and etc
  protected

  ## Private methods
  ## Callbacks before, after, other filters and etc
  private

  def fetch_index_data
    @items_on_stocks    = Wildberry.items_on_stocks
    @items_to_clients   = Wildberry.items_to_clients
    @items_from_clients = Wildberry.items_from_clients
  end
end
