module InvoicesHelper

  def field_prefix(item)
    record_type = if item.new_record? then "new" else "existing" end
    "invoice[#{record_type}_lines][]"
  end

  def add_items_link(number_of_items = 5)
    change_items_link("Add #{number_of_items} items", number_of_items)
  end

  def remove_items_link(number_of_items = 5)
    change_items_link("Remove #{number_of_items} items", -number_of_items)
  end

  private

  def change_items_link(link, offset)
    content_tag(:p) do
      link_to_if @invoice.sensible_line_items_size?(offset),
        link,
        "?number_of_line_items="+(@invoice.line_items.size+offset).to_s
    end
  end

end
