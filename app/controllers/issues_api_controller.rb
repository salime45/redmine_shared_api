class IssuesApiController < ApplicationController

  before_filter :require_login
  accept_api_auth :index
  
  helper :custom_fields
  helper :issues
  
  def index
    scope = Issue.recently_updated
  
    respond_to do |format|      
      format.api  {
        @offset, @limit = api_offset_and_limit
        @issue_count = scope.count
        @issues =  Issue.joins("JOIN #{ContactsIssue.table_name} ci ON ci.issue_id = #{Issue.table_name}.id  and contact_id=#{params[:contact]}")

                    #where(:contact_id => params[:contact])
      }
    end
  end
end
