module AvatarsHelper
  def resource_avatarable?
    resource&.avatarable?
  end

  def resource
    @resource ||= load_resource_instance
  end

  def load_resource_instance
    model_class.find_by_id(params[:id]) if params[:id]
  end

  def model_class
    parts = controller_path.split('/')
    gem_part = parts[0].capitalize if parts.length > 1
    gem_part = "#{gem_part}::" unless gem_part.empty?
    @model_class ||= "#{gem_part}#{controller_name.classify}".constantize
  end

  def resource_not_found
    flash[:error] = I18n.t(:not_found, resource: model_class, scope: :avatares)
    redirect_to request.referrer
  end
end


(byebug) @avatarable.class.to_s.underscore
"spree/user"
(byebug) @avatarable.class.to_s
"Spree::User"
(byebug)