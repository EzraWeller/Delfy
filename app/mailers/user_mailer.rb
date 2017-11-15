class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation [Delfy]"
  end

  def community_invitation(invitation)
    @invitation = invitation
    @email = @invitation.email
    @community = @invitation.community
    mail to: @email, subject: "Community invitation [Delfy]"
  end

  def remove_membership(membership) 
    @user = membership.user
    @community = membership.community
    @email = @user.email
    @reason = membership.removal_reason
    mail to: @email, subject: "#{@community.name} membership removed [Delfy]"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset [Delfy]"
  end
end
