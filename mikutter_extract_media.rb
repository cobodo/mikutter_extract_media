Plugin.create :extract_media do
  defextractcondition(:include_media, name: _('メディアを含む'), operator: false, args: 0) do |message:raise|
    message.entity.any?{|entity|
      Enumerator.new{|y|
        Plugin.filtering(:openimg_image_openers, y)
      }.any?{|opener|
        opener.condition === entity[:open]
      }
    }
  end
end
