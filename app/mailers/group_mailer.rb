class GroupMailer < ApplicationMailer
  def invite(user_id, group_id)
    puts('але')
    @group = Group.find(group_id)
    @url  = "http://localhost:3000/groups/#{group_id}/add_user?user_id=#{user_id}&group_id=#{group_id}"
    @user = User.find(user_id)
    mail(
      to: @user.email,
      subject: 'Вам пришло приглашение в группу'
  )
  end
end
