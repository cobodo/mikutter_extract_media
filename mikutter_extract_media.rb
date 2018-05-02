Plugin.create :extract_media do
  defextractcondition(:include_media, name: _('メディアを含む'), operator: false, args: 0) do |message:raise|
    uris = score_of(message).map(&:uri).map(&:to_s)

    Enumerator.new{|y|
      Plugin.filtering(:openimg_image_openers, y)
    }.any?{|opener|
      uris.any?{|uri|
        opener.condition === uri
      }
    }
  end
end
