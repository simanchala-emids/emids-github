class User < ApplicationRecord

	def self.create_or_update_with_omniauth(auth)
		user = self.find_by_uid(auth["uid"])
		user = self.create(uid: auth["uid"], access_token: auth["credentials"]["token"], nick_name:  auth["info"]["nickname"], name:  auth["info"]["name"]) unless user
		user
  end

  def fetch_review_comment(data)
    from = data[:from].to_i
    to = data[:to].to_i
    review_comments = []
    if to >= from
      from.upto(to) do |pull|
        url = "#{Settings.github_url}repos/#{data['owner']}/#{data["repo"]}/pulls/#{pull}?access_token=#{self.access_token}"
        response = Typhoeus.get(url)
        break if response.response_code != 200
        pull_request_obj = parse_json_data response
        if pull_request_obj["review_comments"] > 0
          url = "#{pull_request_obj["review_comments_url"]}?access_token=#{self.access_token}"
          response = Typhoeus.get(url)
          review_objs = parse_json_data response
          review_objs.each do |review_obj|
            review_comments.push([pull, pull_request_obj["title"], pull_request_obj["body"], review_obj["body"],
                                  pull_request_obj["user"]["login"], review_obj["user"]["login"], review_obj["path"]])
          end
        else
          review_comments.push([pull, pull_request_obj["title"], pull_request_obj["body"], "",
                                pull_request_obj["user"]["login"], "", ""])
        end
      end
    end
    review_comments
  end

  def parse_json_data response
    begin
      ActiveSupport::JSON.decode(response.response_body)
    rescue ActiveSupport::JSON.parse_error
      Rails.logger.warn("Attempted to decode invalid JSON")
    end
  end
end
