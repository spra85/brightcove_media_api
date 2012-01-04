module Brightcove
  module MediaAPI
    class Playlist < Brightcove::MediaAPI::Request
      class << self
        def create_playlist(playlist_options = {})
          send_api_post(:create_playlist, :playlist => playlist_options)
        end

        def update_playlist(playlist_options = {})
          send_api_post(:update_playlist, :playlist => playlist_options)
        end

        def delete_playlist_by_reference_id(reference_id)
          send_api_post(:delete_playlist, :reference_id  => reference_id)
        end

        def find_playlist_by_reference_id(reference_id, options = {}, return_urls = false)
          options[:reference_id] = reference_id
          send_api_get(:find_playlist_by_reference_id, options, return_urls)
        end

        def find_playlists_by_reference_ids(reference_ids, options = {}, return_urls = false)
          options[:reference_ids] = content_item_ids.join(",")
          send_api_get(:find_playlists_by_reference_ids, options, return_urls)
        end

        def mrss_feed(reference_id)
          find_playlist_by_reference_id(reference_id, { :output => "mrss" }, true)
        end

        def find_playlist_by_id(playlist_id, video_fields = nil)
          params = { :playlist_id => playlist_id }
          params[:video_fields] = video_fields.join(",") if video_fields

          send_api_get(:find_playlist_by_id, params)
        end
      end
    end
  end
end
