class IssuesApiController < ApplicationController

  before_filter :require_login
  accept_api_auth :index
  
  helper :custom_fields
  helper :issues
  
  def index
    scope = Issue.id.sorted
  
    respond_to do |format|      
      format.api  {
        @offset, @limit = api_offset_and_limit
        @issue_count = scope.count
        @issues = scope.offset(@offset).limit(@limit).to_a
      }
    end
  end
end
