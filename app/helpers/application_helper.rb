module ApplicationHelper
  def profile_avatar_select(user) 
    if user.avatar.attached?
      image_tag user.avatar, id: 'image-preview', class: 'img-responsive img-circle profile-image'
    else
      image_tag 'default-avatar.jpg', class: 'img-responsive img-circle profile-image'
    end
  end
end