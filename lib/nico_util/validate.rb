# coding: utf-8

module NicoUtil::Validate
  def validate_state(doc)
    if doc.root.attribute('status').value == "ok"
      doc
    else
      raise doc.get_text("nicovideo_thumb_response/error/description")
    end
  end
end
