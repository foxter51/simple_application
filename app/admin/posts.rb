ActiveAdmin.register Post do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :body, :user_id, :likes_count
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :body, :user_id, :likes_count]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
