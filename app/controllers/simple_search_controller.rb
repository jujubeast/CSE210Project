class SimpleSearchController < ApplicationController
  def search
    search_val = params[:searchfor]
    search_op = SimpleSearchOperation.new(search_val)
    search_op.do_search
    @view_data = search_op.view_data
  end
end