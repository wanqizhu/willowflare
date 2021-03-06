# frozen_string_literal: true
module Thredded
  class MessageboardsController < Thredded::ApplicationController
    before_action :thredded_require_login!, only: [:new, :create, :edit, :update]

    after_action :verify_authorized, except: %i(index)
    after_action :verify_policy_scoped, except: %i(new create edit update)
    #before_action :verify_admin, :only => :create



    def index
      @groups = policy_scope(Messageboard.all)
        .preload(:group, last_topic: [:last_user]).group_by(&:group)
        .map { |(group, messageboards)| MessageboardGroupView.new(group, messageboards) }
        .sort{ |a,b| a.group && b.group ? b.group.created_at <=> a.group.created_at : a.group ? 1 : -1 }
        # sort descending by created_at, with those w/o message-board groups at the top
    end

    def new
      @messageboard = Messageboard.new
      @messageboard_group = MessageboardGroup.order('created_at ASC')
      authorize_creating @messageboard
    end

    def create

      @messageboard = Messageboard.new(messageboard_params)
      authorize_creating @messageboard
      if @messageboard.save
        Topic.transaction do
          @topic = Topic.create!(topic_params)
          @post = Post.create!(post_params)
        end
        redirect_to root_path
      else
        render :new
      end
    end

    def edit
      @messageboard = Messageboard.friendly.find(params[:id])
      authorize @messageboard, :update?
    end

    def update
      @messageboard = Messageboard.friendly.find(params[:id])
      authorize @messageboard, :update?
      if @messageboard.update(messageboard_params)
        redirect_to messageboard_topics_path(@messageboard), notice: I18n.t('thredded.messageboard.updated_notice')
      else
        render :edit
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

    def messageboard_params
      params
        .require(:messageboard)
        .permit(:name, :description, :messageboard_group_id)
    end

    def topic_params
      {
        messageboard: @messageboard,
        user: thredded_current_user,
        last_user: thredded_current_user,
        title: "Welcome to your messageboard's very first thread",
      }
    end

    def post_params
      {
        messageboard: @messageboard,
        postable: @topic,
        content: "There's not a whole lot here for now.",
        ip: request.ip,
        user: thredded_current_user,
      }
    end
  end
end
