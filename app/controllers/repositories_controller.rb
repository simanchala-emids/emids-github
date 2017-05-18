class RepositoriesController < ApplicationController

  def index
    url = "#{Settings.repos}#{current_user.access_token}"
    response = Typhoeus.get(url)
    begin
      @respositories = ActiveSupport::JSON.decode(response.response_body)
    rescue ActiveSupport::JSON.parse_error
      Rails.logger.warn("Attempted to decode invalid JSON: #{some_string}")
    end
  end

  def show
  end

  def review_comment
    @review_comments = current_user.fetch_review_comment(params)
    respond_to do |format|
      format.html
      format.xlsx {render xlsx: 'review_comment',filename: "review_comment.xlsx"}
    end
  end
end
