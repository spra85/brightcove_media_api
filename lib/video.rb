module Brightcove
  module MediaAPI
    class Video < Brightcove::MediaAPI::Request
      THUMBNAIL_IMAGE_TYPE = "THUMBNAIL".freeze
      VIDEO_STILL_IMAGE_TYPE = "VIDEO_STILL".freeze

      class << self
        def create_video(video_path, video_options = {})
          raise "Video path (#{video_path}) invalid!" unless video_path && File.exists?(video_path)

          params = { :video => video_options }

          params.merge!({:create_multiple_renditions  => "TRUE", :encode_to => "MP4"}) unless File.extname(video_path) == ".flv"

          send_api_post_file(:create_video, video_path, params)
        end

        def update_video(video_id, video_options = {})
          video_options.merge!({ :id => video_id }) if video_id

          send_api_post(:update_video, :video => video_options)
        end

        def delete_video_by_reference_id(reference_id)
          send_api_post(:delete_video, { :reference_id => reference_id, :delete_shares => true })
        end

        def share_video(video_id, sharee_account_ids, override_options = {})
          return if sharee_account_ids.empty?

          share_options = {
            :video_id => video_id,
            :sharee_account_ids => sharee_account_ids,
            :auto_accept => true,
            :force_reshare => true
          }
          share_options.merge!(override_options)

          send_api_post(:share_video, share_options)
        end

        def add_image(type, file_path, video_id)
          case type
          when "thumb" then
            add_video_image(file_path, video_id, { :type => THUMBNAIL_IMAGE_TYPE })
          when "still" then
            add_video_image(file_path, video_id, { :type => VIDEO_STILL_IMAGE_TYPE })
          end
        end

        def find_by_video_id(video_id, options = {}, return_urls = false)
          options[:video_id] = video_id

          send_api_get(:find_video_by_id, options, return_urls)
        end

        def find_videos_by_ids(video_ids, return_urls = false)
          send_api_get(:find_videos_by_ids, { :video_ids => video_ids.join(",") }, return_urls)
        end

        def find_video_by_reference_id(reference_id, options = {}, return_urls = false)
          options[:reference_id] = reference_id

          send_api_get(:find_video_by_reference_id, options, return_urls)
        end

        def find_videos_by_reference_ids(reference_ids, options = {}, return_urls = false)
          options[:reference_ids] = reference_ids.join(",")

          send_api_get(:find_videos_by_reference_ids, options, return_urls)
        end

        def upload_complete?(video_id = nil, reference_id = nil)
          upload_status = get_upload_status(video_id, reference_id)
          upload_status["result"] && upload_status["result"].eql?("COMPLETE")
        end

        def search_videos(options = {}, return_urls = false)
          send_api_get(:search_videos, options, return_urls)
        end

        def get_upload_status(video_id = nil, reference_id = nil)
          options = {}
          options[:video_id] = video_id if video_id
          options[:reference_id] = reference_id if reference_id

          send_api_post(:get_upload_status, options)
        end

        def add_video_image(image_path, video_id, image_options = {})
          raise "Invalid path #{image_path}" unless File.exists?(image_path)

          send_api_post_file(:add_image, image_path, { :video_id => video_id, :image => image_options })
        end
      end
    end
  end
end
