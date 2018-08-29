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
        @issues =  Issue.joins("JOIN #{CustomValue.table_name} cv ON cv.customized_id  = #{Issue.table_name}.id " +
        " and customized_type='Issue' and custom_field_id=#{params[:field]} and value = #{params[:value]}")
	.order('id DESC')
      }
    end
  end
end
