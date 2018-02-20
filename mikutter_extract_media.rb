Plugin.create :extract_media do
  defextractcondition(:include_media, name: _('メディアを含む'), operator: false, args: 0) do |message:raise|
    message.entity.any?{|entity|
      if entity[:open].is_a?(Plugin::Photo::Photo)
        next true
      end
      uri = nil
      if entity[:open].is_a?(String)
        uri = entity[:open]
      elsif entity[:open].is_a?(Diva::Model)
        uri = entity[:open].uri
      end
      next false if uri.nil?

      Enumerator.new{|y|
        Plugin.filtering(:openimg_image_openers, y)
      }.any?{|opener|
        opener.condition === uri.to_s
      }
    }
  end
end
