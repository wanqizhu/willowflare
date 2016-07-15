# frozen_string_literal: true

module Thredded
  class MessageboardGroupsController < Thredded::ApplicationController
    #before_action :verify_admin, :only => :create

    def new
      @messageboard_group = MessageboardGroup.new
      authorize @messageboard_group, :create?
    end

    def create
      # only admins can create new msg boards
      if thredded_current_user.auth_level < 90
        redirect_to root_path
        return
      end

      @messageboard_group = MessageboardGroup.new(messageboard_group_params)
      authorize @messageboard_group, :create?

      if @messageboard_group.save
        redirect_to root_path
      else
        render action: :new
      end
    end

    private

    # only admins can create new msg boards
    def verify_admin
      if thredded_current_user.auth_level < 90
        redirect_to root_path
        return
      end
    end

    def messageboard_group_params
      params
        .require(:messageboard_group)
        .permit(:name)
    end
  end
end
