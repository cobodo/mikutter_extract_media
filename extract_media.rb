Plugin.create :extract_media do
  defextractcondition(:include_media, name: _('メディアを含む'), operator: false, args: 0) do |message:raise|
    message.entity.any?{ |entity| entity[:slug] == :media }
  end
end
