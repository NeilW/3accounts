# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def formatValue(value = Float.new)
	   if !value.nil?
 	  	 currency = '&euro;'
	 	  if value > 0
	  	   value = "<span class='positive_value'>+"+value.to_s+' '+currency+"</span>"
	  	 else
   	     	   value = "<span class='negative_value'>"+value.to_s+' '+currency+"</span>"
 	  	 end
                   else
	   	value="no value"
	   end	
 	   return(value)
	end

	def getBalance(account = Account.new)
	  total = 0
	  for entry in account.entries
	    	if !entry.value.nil?
			total = total + entry.value
		end
	  end
	  return(formatValue(total))
	end

	def getTodayBalance(account = Account.new)
	  entries = getTodayEntries(account)
	  total = 0
	  for entry in entries
	    	if !entry.value.nil?
			total = total + entry.value
		end
	  end
	  return(formatValue(total))
	end

	def tableTestEven(even = Boolean.new)
	  ret = ''
	  if even
		ret = 'even'
	  end
	  return(ret)
	end
  
 	def getTodayEntries(account = Account.new)
		return (Entry.find(:all, :order => "effective_date DESC, created_at DESC", :conditions => "account_id="+account.id.to_s + "  AND effective_date <= '"+Time.now.to_date.to_s+"'"))
	end

	def getUpcomingEntries(account = Account.new)
		return (Entry.find(:all, :order => "effective_date DESC, created_at DESC", :conditions => "account_id="+account.id.to_s + "  AND effective_date > '"+Time.now.to_date.to_s+"'"))
	end


def date_picker_field(object, method)
    obj = instance_eval("@#{object}")
    value = obj.send(method)
    display_value = value.respond_to?(:strftime) ? value.strftime('%d %b %Y') : value.to_s
    #display_value = method.to_s.gsub(/_id$/, "").gsub(/_/, " ").capitalize if display_value.blank?
    display_value = Time.now.strftime('%d %b %Y') if display_value.blank?

    out = hidden_field(object, method, "value" => Time.now.to_date.to_s)
    out << content_tag('a', display_value, :href => '#',
        :id => "_#{object}_#{method}_link", :class => '_demo_link',
        :onclick => "DatePicker.toggleDatePicker('#{object}_#{method}'); return false;")
    out << content_tag('div', '', :class => 'date_picker', :style => 'display: none',
                      :id => "_#{object}_#{method}_calendar")
    if obj.respond_to?(:errors) and obj.errors.on(method) then
      ActionView::Base.field_error_proc.call(out, nil) # What should I pass ?
    else
      out
    end
  end
end
