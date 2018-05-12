Plugin.create :mikutter_extract_media do
  exts = Gtk::FormDSL::PIXBUF_PHOTO_FILTER.values.flatten.map(&:downcase).uniq.map {|ext| ".#{ext}" }

  defextractcondition(:include_media, name: _('メディアを含む'), operator: false, args: 0) do |message:raise|
    uris = score_of(message).map(&:uri).map(&:to_s)
    has_normal_image = uris.any? do |uri|
      exts.any? {|ext| uri.downcase.end_with? ext}
    end
    next true if has_normal_image

    Enumerator.new{|y|
      Plugin.filtering(:openimg_image_openers, y)
    }.any?{|opener|
      uris.any?{|uri|
        opener.condition === uri
      }
    }
  end
end
