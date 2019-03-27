module CustomFieldsHelper
  
  def custom_values(custom, id)
    if id
      cutom_art =  CustomAttriValue.where(model_id: id, custom_field_id: custom.try(:id))
      if cutom_art
        value = cutom_art.last.try(:value)
      else
         value = custom.try(:default)
      end
    else
      value = custom.try(:default)
    end
    return value
  end
  
end
