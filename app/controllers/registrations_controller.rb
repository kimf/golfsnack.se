# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up(resource_name, resource)
    invitation = ::Invitation.where(email: resource.email, code: resource.invite_code).first
    invitation.user = resource
    invitation.claimed_at = Time.zone.now
    invitation.save

    sign_in(resource_name, resource)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(_resource)
    edit_user_registration_path
  end

  def after_update_path_for(_resource)
    profile_path
  end
end
