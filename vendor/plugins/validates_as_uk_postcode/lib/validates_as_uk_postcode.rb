#
# Licensed under a Creative Commons Attribution-ShareAlike 2.5 License
# http://creativecommons.org/licenses/by-sa/2.5/
# 
module Postcodes
  UK = begin    
    an_naa_or_ann_naa   = '^[A-PR-UWYZ]{1}\d{1,2}\s?\d[ABD-HJLNP-UWXYZ]{2}$'
    aan_naa_or_aann_naa = '^[A-PR-UWYZ]{1}[A-HK-Y]{1}\d{1,2}\s?\d[ABD-HJLNP-UWXYZ]{2}$'
    ana_naa             = '^[A-PR-UWYZ]{1}\d[A-HJKSTUW]{1}\s?\d[ABD-HJLNP-UWXYZ]{2}$'
    aana_naa            = '^[A-PR-UWYZ]{1}[A-HK-Y]{1}\d[ABEHMNPRVWXY]{1}\s?\d[ABD-HJLNP-UWXYZ]{2}$'
    historic_code="GIR\s?0AA"
    postcode_spec = "#{an_naa_or_ann_naa}|#{aan_naa_or_aann_naa}|#{ana_naa}|#{aana_naa}|#{historic_code}"
    pattern = /#{postcode_spec}/i
  end
end

# Validation helper for ActiveRecord derived objects that cleanly and simply
# allows the model to check if the given string is a syntactically valid email
# address (by using the RFC822 module above).
#
# Original code by Ximon Eighteen <ximon.eightee@int.greenpeace.org> which was
# heavily based on code I can no longer find on the net, my apologies to the
# author!
#
# Huge credit goes to Dan Kubb <dan.kubb@autopilotmarketing.com> for
# submitting a patch to massively simplify this code and thereby instruct me
# in the ways of Rails too! I reflowed the patch a little to keep the line
# length to a maximum of 78 characters, an old habit.

module ActiveRecord
  module Validations
    module ClassMethods
      def validates_as_uk_postcode(*attr_names)
        configuration = {
          :message   => 'is an invalid uk postcode',
          :with      => Postcodes::UK,
          :allow_nil => true }
        configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)

        validates_format_of attr_names, configuration
      end
    end
  end
end
