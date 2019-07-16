class MailsController < ApplicationController
    skip_before_action :get_current_user, only: [:contact_us]

    def contact_us
        if params[:name].nil? or params[:cc].nil? or params[:email].nil? or params[:description].nil?
            render json: {error:"Not enough params"}, status: :unprocessable_entity
        else
            ContactMailer.contact_us(params[:name], params[:cc], params[:email], params[:description]).deliver
            render json: {status:"in process"}, status: :ok
        end
    end

end
